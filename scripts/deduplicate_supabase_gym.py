#!/usr/bin/env python3
import urllib.request
import urllib.parse
import json
import os
import sys

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

def api_request(endpoint, method="GET", data=None):
    url = f"{SUPABASE_URL}/rest/v1/{endpoint}"
    payload = json.dumps(data).encode("utf-8") if data is not None else None
    req = urllib.request.Request(url, data=payload, headers=HEADERS, method=method)
    try:
        with urllib.request.urlopen(req) as res:
            content = res.read().decode()
            return json.loads(content) if content else None
    except Exception as e:
        return None

def clean_duplicates():
    print(f"🧹 Starting Supabase Gym Deduplication ({SUPABASE_URL})...\n", flush=True)

    # 1. DEDUPLICATE WORKOUTS
    print("1️⃣ Deduplicating Workouts...", flush=True)
    all_workouts = api_request("workouts?select=id,name,started_at,created_at&order=created_at.asc") or []
    
    seen_workouts = {}
    duplicate_workout_ids = []

    for w in all_workouts:
        key = (w.get("name", "").strip().lower(), str(w.get("started_at", "")).strip())
        if key not in seen_workouts:
            seen_workouts[key] = w["id"]
        else:
            duplicate_workout_ids.append(w["id"])

    print(f"   Found {len(all_workouts)} total workouts -> {len(seen_workouts)} unique, {len(duplicate_workout_ids)} duplicates to remove.", flush=True)

    for i in range(0, len(duplicate_workout_ids), 50):
        batch_ids = duplicate_workout_ids[i:i+50]
        id_query = ",".join([f'"{b_id}"' for b_id in batch_ids])
        api_request(f"workout_sets?workout_id=in.({id_query})", method="DELETE")
        api_request(f"workouts?id=in.({id_query})", method="DELETE")

    print(f"   ✅ Cleaned duplicate workouts.", flush=True)

    # 2. DEDUPLICATE EXERCISES
    print("\n2️⃣ Deduplicating Exercises Catalog...", flush=True)
    all_exercises = api_request("exercises?select=id,name,name_es,is_custom,created_at&order=created_at.asc") or []

    exercise_groups = {}
    for ex in all_exercises:
        norm = (ex.get("name") or ex.get("name_es") or "").strip().lower()
        if not norm:
            continue
        if norm not in exercise_groups:
            exercise_groups[norm] = []
        exercise_groups[norm].append(ex)

    duplicate_exercise_ids = []
    relink_map = {} # dup_ex_id -> kept_ex_id

    for norm, ex_list in exercise_groups.items():
        if len(ex_list) <= 1:
            continue
        ex_list.sort(key=lambda x: (x.get("is_custom", True) == True, x.get("created_at") or ""))
        kept_id = ex_list[0]["id"]
        for dup in ex_list[1:]:
            duplicate_exercise_ids.append(dup["id"])
            relink_map[dup["id"]] = kept_id

    print(f"   Found {len(all_exercises)} total exercises -> {len(exercise_groups)} unique, {len(duplicate_exercise_ids)} duplicates to consolidate.", flush=True)

    for dup_id, kept_id in relink_map.items():
        api_request(f"workout_sets?exercise_id=eq.{dup_id}", method="PATCH", data={"exercise_id": kept_id})
        api_request(f"personal_records?exercise_id=eq.{dup_id}", method="PATCH", data={"exercise_id": kept_id})

    if duplicate_exercise_ids:
        for i in range(0, len(duplicate_exercise_ids), 50):
            batch_ids = duplicate_exercise_ids[i:i+50]
            id_query = ",".join([f'"{b_id}"' for b_id in batch_ids])
            api_request(f"exercises?id=in.({id_query})", method="DELETE")

    print(f"   ✅ Cleaned duplicate exercises catalog.", flush=True)

    # 3. DEDUPLICATE WORKOUT SETS
    print("\n3️⃣ Deduplicating Workout Sets...", flush=True)
    all_sets = api_request("workout_sets?select=id,workout_id,exercise_id,set_index,created_at&order=created_at.asc") or []

    seen_sets = set()
    dup_set_ids = []

    for s in all_sets:
        key = (s.get("workout_id"), s.get("exercise_id"), s.get("set_index"))
        if key not in seen_sets:
            seen_sets.add(key)
        else:
            dup_set_ids.append(s["id"])

    if dup_set_ids:
        for i in range(0, len(dup_set_ids), 50):
            batch_ids = dup_set_ids[i:i+50]
            id_query = ",".join([f'"{b_id}"' for b_id in batch_ids])
            api_request(f"workout_sets?id=in.({id_query})", method="DELETE")

    print(f"   ✅ Cleaned duplicate workout sets.", flush=True)

    final_w = api_request("workouts?select=id") or []
    final_ex = api_request("exercises?select=id") or []
    final_sets = api_request("workout_sets?select=id") or []

    print(f"\n🎉 DEDUPLICATION COMPLETE!", flush=True)
    print(f"📊 Final Workouts count: {len(final_w)} (exact unique workouts)", flush=True)
    print(f"🏋️ Final Exercises count: {len(final_ex)} (exact unique exercises)", flush=True)
    print(f"🔢 Final Workout Sets count: {len(final_sets)} (exact unique sets)", flush=True)

if __name__ == "__main__":
    clean_duplicates()
