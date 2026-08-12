#!/usr/bin/env python3
import json
import urllib.request
import urllib.parse
import urllib.error
import sys
import os
import argparse

def fetch_hevy_workouts(username="maximo_aurelio", token=None, output_file="data/hevy_workouts.json", limit=10, input_file=None):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    # If user provided a raw JSON file exported from browser/postman
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
    raw_token = clean_token
    if clean_token.startswith("Bearer "):
        raw_token = clean_token[7:].strip()

    print(f"🚀 Starting Hevy Workouts Importer for user '{username}'...")
    print(f"🔑 Using Token: {raw_token[:8]}...{raw_token[-4:] if len(raw_token) > 8 else ''}")
    
    headers_to_try = [
        {"Authorization": f"Bearer {raw_token}", "User-Agent": "Hevy/1.0"},
        {"Authorization": raw_token, "User-Agent": "Hevy/1.0"},
        {"auth-token": raw_token, "User-Agent": "Hevy/1.0"},
        {"api-key": raw_token, "User-Agent": "Hevy/1.0"},
        {"x-api-key": raw_token, "User-Agent": "Hevy/1.0"},
    ]

    all_workouts = []
    offset = 0
    page = 1
    last_error = None

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
                    
                    if isinstance(parsed, dict):
                        batch_workouts = parsed.get("workouts") or parsed.get("data") or []
                    elif isinstance(parsed, list):
                        batch_workouts = parsed
                        
                    success = True
                    break
            except urllib.error.HTTPError as err:
                last_error = f"HTTP {err.code}: {err.reason}"
                continue
            except Exception as e:
                last_error = str(e)
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
                except urllib.error.HTTPError as err:
                    last_error = f"HTTP {err.code}: {err.reason}"
                    continue
                except Exception as e:
                    last_error = str(e)
                    continue

        if not success or not batch_workouts:
            if offset == 0 and last_error:
                print(f"\n❌ Error de Autenticación en Hevy API: {last_error}")
                print("\nEl servidor de Hevy rechaza este token con error 401 (Unauthorized).")
                print("Esto ocurre cuando el token de sesión ha expirado en los servidores de Hevy.\n")
                print("📌 Pasos para obtener tu token activo en 15 segundos:")
                print("  1. Entra en https://www.hevyapp.com en tu navegador e inicia sesión.")
                print("  2. Abre Inspeccionar -> Consola / Red (Network).")
                print("  3. Busca cualquier llamada a 'api.hevyapp.com' y copia el valor exacto de 'auth-token' o 'Authorization'.")
                print("  4. Vuelve a ejecutar:\n")
                print(f"     python3 scripts/fetch_hevy_workouts.py --username {username} --token \"TU_NUEVO_TOKEN\"\n")
                print("  (Alternativamente, si copias la respuesta JSON directamente en Chrome, puedes guardarla como 'data/hevy_raw.json' y ejecutar):")
                print("     python3 scripts/fetch_hevy_workouts.py --input-file data/hevy_raw.json\n")
            else:
                print(f"ℹ️  Finished fetching at offset {offset} (page {page}).")
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
