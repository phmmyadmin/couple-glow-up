#!/usr/bin/env python3
import json
import os
import sys
import urllib.request
import urllib.parse
import re

# Load Supabase URL and ANON KEY from app/.env
ENV_PATH = os.path.join(os.path.dirname(__file__), "../app/.env")
SUPABASE_URL = "https://tarkabzvlllptenatxln.supabase.co"
SUPABASE_KEY = "sb_publishable_slCCCjjFmUxs5R1LrLiRPQ_k8Qy7RUP"

if os.path.exists(ENV_PATH):
    with open(ENV_PATH, "r") as f:
        for line in f:
            if line.startswith("VITE_SUPABASE_URL="):
                SUPABASE_URL = line.split("=", 1)[1].strip()
            elif line.startswith("VITE_SUPABASE_ANON_KEY="):
                SUPABASE_KEY = line.split("=", 1)[1].strip()

HEADERS = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
    "Prefer": "return=representation"
}

def api_get(endpoint):
    url = f"{SUPABASE_URL}/rest/v1/{endpoint}"
    req = urllib.request.Request(url, headers=HEADERS, method="GET")
    with urllib.request.urlopen(req) as res:
        return json.loads(res.read().decode())

def api_post(table, data):
    url = f"{SUPABASE_URL}/rest/v1/{table}"
    req = urllib.request.Request(url, data=json.dumps(data).encode("utf-8"), headers=HEADERS, method="POST")
    with urllib.request.urlopen(req) as res:
        return json.loads(res.read().decode())

def format_iso_timestamp(val):
    if not val:
        return None
    if isinstance(val, (int, float)):
        import datetime
        return datetime.datetime.fromtimestamp(val, datetime.timezone.utc).isoformat()
    return str(val)

def import_to_supabase(json_file="data/hevy_workouts.json"):
    if not os.path.exists(json_file):
        print(f"❌ File not found: {json_file}", flush=True)
        return

    with open(json_file, "r", encoding="utf-8") as f:
        workouts = json.load(f)

    print(f"🚀 Importing {len(workouts)} Hevy Workouts directly into Supabase ({SUPABASE_URL})...", flush=True)

    # 1. Fetch Target Profile ID
    profiles = api_get("profiles?select=id&limit=1")
    if not profiles:
        print("❌ No profile found in Supabase profiles table.", flush=True)
        return
    profile_id = profiles[0]["id"]
    print(f"👤 Target Profile ID: {profile_id}", flush=True)

    # 2. Fetch Existing Exercises Catalog
    existing_exercises = api_get("exercises?select=id,name,name_es")
    ex_map = {}
    for ex in existing_exercises:
        if ex.get("name"):
            ex_map[ex["name"].lower().strip()] = ex["id"]
        if ex.get("name_es"):
            ex_map[ex["name_es"].lower().strip()] = ex["id"]

    imported_workouts = 0
    imported_sets = 0

    for idx, w in enumerate(workouts):
        w_title = w.get("title") or w.get("name") or f"Hevy Workout #{idx+1}"
        started_at = format_iso_timestamp(w.get("start_time") or w.get("started_at") or w.get("created_at"))
        finished_at = format_iso_timestamp(w.get("end_time") or w.get("finished_at") or w.get("completed_at")) or started_at
        
        st_num = w.get("start_time")
        et_num = w.get("end_time")
        duration_mins = w.get("duration_minutes") or w.get("duration")
        if not duration_mins and isinstance(st_num, (int, float)) and isinstance(et_num, (int, float)) and et_num > st_num:
            duration_mins = round((et_num - st_num) / 60)
        elif duration_mins and isinstance(duration_mins, int) and duration_mins > 600:
            duration_mins = max(1, round(duration_mins / 60))
        if not duration_mins:
            duration_mins = 30

        est_vol = w.get("estimated_volume_kg") or w.get("volume_kg") or 0

        # Insert Workout
        w_payload = {
            "profile_id": profile_id,
            "name": w_title,
            "started_at": started_at,
            "finished_at": finished_at,
            "duration_minutes": duration_mins,
            "estimated_volume_kg": est_vol
        }

        try:
            w_res = api_post("workouts", w_payload)
            workout_id = w_res[0]["id"]
            imported_workouts += 1
        except Exception as e:
            print(f"⚠️ Error inserting workout '{w_title}': {e}", flush=True)
            continue

        # Process exercises inside workout
        ex_list = w.get("exercises") or w.get("workout_exercises") or []
        set_counter = 0

        for ex_item in ex_list:
            ex_title = ex_item.get("title") or ex_item.get("name") or "Custom Exercise"
            norm_title = ex_title.lower().strip()

            ex_id = ex_map.get(norm_title)

            # If exercise missing, insert into exercises catalog
            if not ex_id:
                try:
                    new_ex_payload = {
                        "name": ex_title,
                        "name_es": ex_title,
                        "exercise_type": ex_item.get("exercise_type") or "weight_reps",
                        "muscle_group": ex_item.get("muscle_group") or "other",
                        "equipment_category": ex_item.get("equipment_category") or "dumbbell",
                        "is_custom": True
                    }
                    new_ex_res = api_post("exercises", new_ex_payload)
                    ex_id = new_ex_res[0]["id"]
                    ex_map[norm_title] = ex_id
                except Exception as e:
                    print(f"⚠️ Could not create exercise '{ex_title}': {e}", flush=True)
                    continue

            # Process sets
            sets_list = ex_item.get("sets") or []
            sets_payload = []

            for s_item in sets_list:
                set_counter += 1
                indicator = s_item.get("set_type") or s_item.get("indicator") or "normal"
                if indicator not in ["normal", "warmup", "dropset", "failure"]:
                    indicator = "normal"

                sets_payload.append({
                    "workout_id": workout_id,
                    "exercise_id": ex_id,
                    "set_index": set_counter,
                    "indicator": indicator,
                    "weight_kg": float(s_item["weight_kg"]) if s_item.get("weight_kg") is not None else None,
                    "reps": int(s_item["reps"]) if s_item.get("reps") is not None else None,
                    "duration_seconds": int(s_item["duration_seconds"]) if s_item.get("duration_seconds") is not None else None,
                    "distance_meters": float(s_item["distance_meters"]) if s_item.get("distance_meters") is not None else None
                })

            if sets_payload:
                try:
                    sets_res = api_post("workout_sets", sets_payload)
                    imported_sets += len(sets_res)
                except Exception as e:
                    print(f"⚠️ Error inserting sets for workout '{w_title}': {e}", flush=True)

        if (idx + 1) % 25 == 0 or (idx + 1) == len(workouts):
            print(f"✅ Progress: {idx+1}/{len(workouts)} workouts imported ({imported_sets} sets)...", flush=True)

    print(f"\n🎉 DIRECT IMPORT COMPLETE!", flush=True)
    print(f"📊 Workouts imported: {imported_workouts}/{len(workouts)}", flush=True)
    print(f"🏋️ Total sets imported: {imported_sets}", flush=True)

if __name__ == "__main__":
    import_to_supabase()
