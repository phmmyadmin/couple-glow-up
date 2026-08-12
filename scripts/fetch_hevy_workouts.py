#!/usr/bin/env python3
import json
import subprocess
import os
import argparse
import sys

def fetch_hevy_workouts(username="maximo_aurelio", token=None, output_file="data/hevy_workouts.json", limit=5, input_file=None):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    # 1. Local File Import Option
    if input_file and os.path.exists(input_file):
        print(f"📂 Reading Hevy workouts directly from local file '{input_file}'...", flush=True)
        with open(input_file, "r", encoding="utf-8") as f:
            parsed = json.load(f)
            if isinstance(parsed, dict):
                workouts = parsed.get("workouts") or parsed.get("data") or [parsed]
            elif isinstance(parsed, list):
                workouts = parsed
            else:
                workouts = []
                
        with open(output_file, "w", encoding="utf-8") as out_f:
            json.dump(workouts, out_f, indent=2, ensure_ascii=False)
            
        print(f"🎉 Saved {len(workouts)} workouts to {output_file}", flush=True)
        return workouts

    if not token:
        print("❌ Error: No auth token provided. Specify --token or --input-file", flush=True)
        return []

    clean_token = token.strip()
    if clean_token.startswith("Bearer "):
        clean_token = clean_token[7:].strip()

    print(f"🚀 Starting Hevy Workouts Importer for user '{username}'...", flush=True)
    print(f"🔑 Using Token: {clean_token[:8]}...{clean_token[-4:] if len(clean_token) > 8 else ''}", flush=True)

    all_workouts = []
    page = 1
    offset = 0

    while True:
        url = f"https://api.hevyapp.com/user_workouts_paged?username={username}&limit={limit}&offset={offset}"
        
        cmd = [
            "curl", "-s", "-X", "GET",
            "-H", f"authorization: Bearer {clean_token}",
            "-H", "x-api-key: shelobs_hevy_web",
            "-H", "hevy-platform: web",
            "-H", "Accept: application/json, text/plain, */*",
            url
        ]

        res = subprocess.run(cmd, capture_output=True)
        raw_output = res.stdout.decode("utf-8", errors="ignore").strip()

        try:
            parsed = json.loads(raw_output)
        except Exception as e:
            print(f"❌ Error parsing response at offset {offset}: {e}", flush=True)
            print(f"Raw Output: {raw_output[:300]}", flush=True)
            break

        if isinstance(parsed, dict) and "error" in parsed:
            err_msg = parsed["error"]
            print(f"\n❌ Hevy API Error: '{err_msg}'", flush=True)
            break

        batch_workouts = []
        if isinstance(parsed, dict):
            batch_workouts = parsed.get("workouts") or parsed.get("data") or []
        elif isinstance(parsed, list):
            batch_workouts = parsed

        if not batch_workouts:
            print(f"ℹ️  Finished fetching at page {page} (offset {offset}).", flush=True)
            break

        all_workouts.extend(batch_workouts)
        print(f"✅ Fetched batch of {len(batch_workouts)} workouts (Total: {len(all_workouts)})", flush=True)

        if len(batch_workouts) < limit:
            print("🏁 Reached last page of workouts.", flush=True)
            break

        page += 1
        offset += limit

    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(all_workouts, f, indent=2, ensure_ascii=False)

    print(f"\n🎉 SUCCESS! Saved {len(all_workouts)} workouts to {output_file}", flush=True)
    return all_workouts

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch all workouts from Hevy API with pagination")
    parser.add_argument("--username", default="maximo_aurelio", help="Hevy username")
    parser.add_argument("--token", default="Bearer DoDgHq762HOJoFylKgNBL7kKlS/80oyVTq1+pxSG", help="Hevy auth token / Bearer token")
    parser.add_argument("--output", default="data/hevy_workouts.json", help="Output JSON path")
    parser.add_argument("--limit", type=int, default=5, help="Page limit per request")
    parser.add_argument("--input-file", default=None, help="Optional raw JSON file path if saved manually from DevTools")

    args = parser.parse_args()
    fetch_hevy_workouts(username=args.username, token=args.token, output_file=args.output, limit=args.limit, input_file=args.input_file)
