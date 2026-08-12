#!/usr/bin/env python3
import json
import urllib.request
import urllib.parse
import sys
import os
import argparse

def fetch_hevy_workouts(username="maximo_aurelio", token="rLnwMYN6nRzTe0ASuh7+nT4imn4dCQZEJrprrfy9", output_file="data/hevy_workouts.json", limit=10):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    all_workouts = []
    offset = 0
    page = 1
    
    print(f"🚀 Starting Hevy Workouts Importer for user '{username}'...")
    
    headers_to_try = [
        {"auth-token": token, "User-Agent": "Hevy/1.0"},
        {"Authorization": f"Bearer {token}", "User-Agent": "Hevy/1.0"},
        {"api-key": token, "User-Agent": "Hevy/1.0"},
    ]

    while True:
        fetched_in_batch = 0
        batch_workouts = []
        
        # Endpoint 1: user_workouts_paged (Hevy Web App)
        url = f"https://api.hevyapp.com/user_workouts_paged?username={username}&limit={limit}&offset={offset}"
        
        success = False
        for headers in headers_to_try:
            req = urllib.request.Request(url, headers=headers)
            try:
                with urllib.request.urlopen(req, timeout=10) as res:
                    raw_data = res.read().decode("utf-8")
                    parsed = json.loads(raw_data)
                    
                    # Extract workouts list from response
                    if isinstance(parsed, dict):
                        batch_workouts = parsed.get("workouts") or parsed.get("data") or []
                    elif isinstance(parsed, list):
                        batch_workouts = parsed
                        
                    success = True
                    break
            except Exception as e:
                continue

        # Endpoint 2 Fallback: /v1/workouts (Hevy Official API)
        if not success:
            v1_url = f"https://api.hevyapp.com/v1/workouts?page={page}&pageSize={limit}"
            for headers in headers_to_try:
                req = urllib.request.Request(v1_url, headers=headers)
                try:
                    with urllib.request.urlopen(req, timeout=10) as res:
                        raw_data = res.read().decode("utf-8")
                        parsed = json.loads(raw_data)
                        if isinstance(parsed, dict):
                            batch_workouts = parsed.get("workouts") or parsed.get("data") or []
                        elif isinstance(parsed, list):
                            batch_workouts = parsed
                        success = True
                        break
                except Exception as e:
                    continue

        if not success or not batch_workouts:
            print(f"ℹ️  Finished fetching or reached end of pagination at offset {offset} (page {page}).")
            break

        all_workouts.extend(batch_workouts)
        fetched_in_batch = len(batch_workouts)
        print(f"✅ Fetched batch of {fetched_in_batch} workouts (Total so far: {len(all_workouts)})")
        
        if fetched_in_batch < limit:
            print("🏁 Last page reached.")
            break
            
        offset += limit
        page += 1

    # Write output to JSON
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(all_workouts, f, indent=2, ensure_ascii=False)
        
    print(f"🎉 Done! Saved {len(all_workouts)} workouts to {output_file}")
    return all_workouts

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch all workouts from Hevy API with pagination")
    parser.add_argument("--username", default="maximo_aurelio", help="Hevy username")
    parser.add_argument("--token", default="rLnwMYN6nRzTe0ASuh7+nT4imn4dCQZEJrprrfy9", help="Hevy auth token / Bearer token")
    parser.add_argument("--output", default="data/hevy_workouts.json", help="Output JSON path")
    parser.add_argument("--limit", type=int, default=10, help="Page limit per request")
    
    args = parser.parse_args()
    fetch_hevy_workouts(username=args.username, token=args.token, output_file=args.output, limit=args.limit)
