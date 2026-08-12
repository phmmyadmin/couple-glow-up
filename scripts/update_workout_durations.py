#!/usr/bin/env python3
import json
import os
import sys
import urllib.request

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
        print(f"⚠️ API Error ({endpoint}): {e}")
        return None

def update_workout_durations():
    json_file = "data/hevy_workouts.json"
    if not os.path.exists(json_file):
        print(f"❌ File not found: {json_file}")
        return

    with open(json_file, "r", encoding="utf-8") as f:
        hevy_workouts = json.load(f)

    print(f"🔄 Updating exact workout durations in Supabase ({SUPABASE_URL})...", flush=True)

    # Fetch all workouts in Supabase
    db_workouts = api_request("workouts?select=id,name,started_at&order=started_at.desc") or []
    print(f"   Fetched {len(db_workouts)} workouts from Supabase.", flush=True)

    # Build map for fast matching
    updated_count = 0
    for w in hevy_workouts:
        st = w.get("start_time")
        et = w.get("end_time")
        
        if not st or not et or et <= st:
            continue

        dur_mins = round((et - st) / 60)
        w_name = w.get("name") or w.get("title") or ""

        # Match by name and timestamp proximity
        import datetime
        st_iso = datetime.datetime.fromtimestamp(st, datetime.timezone.utc).isoformat()

        # Find matching workout in Supabase by matching start_time timestamp or name
        for db_w in db_workouts:
            db_st = db_w.get("started_at", "")
            # Check if timestamps match (first 16 chars e.g. 2026-08-12T10:00)
            if db_w.get("name", "").strip().lower() == w_name.strip().lower() and (st_iso[:16] in db_st or str(st) in db_st):
                try:
                    api_request(f"workouts?id=eq.{db_w['id']}", method="PATCH", data={"duration_minutes": dur_mins})
                    updated_count += 1
                    break
                except Exception as e:
                    print(f"⚠️ Error updating workout {db_w['id']}: {e}")

    print(f"\n🎉 SUCCESS! Updated exact duration_minutes for {updated_count} workouts in Supabase!", flush=True)

if __name__ == "__main__":
    update_workout_durations()
