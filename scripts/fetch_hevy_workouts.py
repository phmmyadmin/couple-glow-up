#!/usr/bin/env python3
import json
import subprocess
import os
import argparse
import sys

def fetch_hevy_workouts(username="maximo_aurelio", token=None, output_file="data/hevy_workouts.json", limit=10, input_file=None):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    # 1. Local File Import Option
    if input_file and os.path.exists(input_file):
        print(f"📂 Reading Hevy workouts directly from local file '{input_file}'...")
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
            
        print(f"🎉 Saved {len(workouts)} workouts to {output_file}")
        return workouts

    if not token:
        print("❌ Error: No auth token provided. Specify --token or --input-file")
        return []

    clean_token = token.strip()
    if clean_token.startswith("Bearer "):
        clean_token = clean_token[7:].strip()

    print(f"🚀 Starting Hevy Workouts Importer for user '{username}'...")
    print(f"🔑 Using Token: {clean_token[:8]}...{clean_token[-4:] if len(clean_token) > 8 else ''}")

    all_workouts = []
    page = 1
    offset = 0
    page_count = None

    while True:
        # Hevy Web App Endpoint
        url = f"https://api.hevyapp.com/user_workouts_paged?username={username}&limit={limit}&offset={offset}"
        
        cmd = [
            "curl", "-s", "-X", "GET",
            "-H", f"authorization: Bearer {clean_token}",
            "-H", "x-api-key: shelobs_hevy_web",
            "-H", "hevy-platform: web",
            "-H", "Accept: application/json, text/plain, */*",
            url
        ]

        res = subprocess.run(cmd, capture_output=True, text=True)
        raw_output = res.stdout.strip()

        try:
            parsed = json.loads(raw_output)
        except Exception as e:
            print(f"❌ Error parsing response from Hevy: {e}")
            print(f"Raw Output: {raw_output[:300]}")
            break

        if isinstance(parsed, dict) and "error" in parsed:
            err_msg = parsed["error"]
            print(f"\n❌ Hevy API Error: '{err_msg}'")
            if err_msg in ["InvalidAccessToken", "Unauthorized"]:
                print("\n💡 EL ACCESS TOKEN DE HEVY ES INVÁLIDO O HA EXSPIRADO.")
                print("La cabecera web `x-api-key: shelobs_hevy_web` es correcta, pero tu token de usuario debe renovarse.")
                print("\n📌 Pasos para obtener tu token activo en 10 segundos:")
                print("  1. Abre https://hevy.com en tu navegador e inicia sesión.")
                print("  2. Abre Inspeccionar (F12) -> Red / Network.")
                print("  3. Busca cualquier llamada a 'api.hevyapp.com'.")
                print("  4. Copia el valor de la cabecera 'authorization' (Bearer ...).")
                print("  5. Vuelve a ejecutar:\n")
                print(f"     python3 scripts/fetch_hevy_workouts.py --username {username} --token \"TU_NUEVO_TOKEN\"\n")
            break

        batch_workouts = []
        if isinstance(parsed, dict):
            batch_workouts = parsed.get("workouts") or parsed.get("data") or []
            if page_count is None:
                page_count = parsed.get("page_count")
        elif isinstance(parsed, list):
            batch_workouts = parsed

        if not batch_workouts:
            print(f"ℹ️  Finished fetching at page {page} (offset {offset}).")
            break

        all_workouts.extend(batch_workouts)
        print(f"✅ Fetched batch of {len(batch_workouts)} workouts (Total: {len(all_workouts)})")

        if len(batch_workouts) < limit:
            print("🏁 Reached last page of workouts.")
            break

        page += 1
        offset += limit

    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(all_workouts, f, indent=2, ensure_ascii=False)

    print(f"🎉 Saved {len(all_workouts)} workouts to {output_file}")
    return all_workouts

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch all workouts from Hevy API with pagination")
    parser.add_argument("--username", default="maximo_aurelio", help="Hevy username")
    parser.add_argument("--token", default="rLnwMYN6nRzTe0ASuh7+nT4imn4dCQZEJrprrfy9", help="Hevy auth token / Bearer token")
    parser.add_argument("--output", default="data/hevy_workouts.json", help="Output JSON path")
    parser.add_argument("--limit", type=int, default=10, help="Page limit per request")
    parser.add_argument("--input-file", default=None, help="Optional raw JSON file path if saved manually from DevTools")

    args = parser.parse_args()
    fetch_hevy_workouts(username=args.username, token=args.token, output_file=args.output, limit=args.limit, input_file=args.input_file)
