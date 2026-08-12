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
        print(f"⚠️ API Error ({endpoint}): {e}", flush=True)
        return None

# Exact routine definitions from user prompt
HEVY_PAYLOAD_EXACT = {
    "updated": [
        {
            "id": "f593ab2e-a608-4fad-b3d0-d452de2424c7",
            "title": "Push",
            "exercises": [
                {
                    "title": "Manquito Rotador Mancuerna",
                    "muscle_group": "shoulders",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": 5, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Press militar banda elastica",
                    "muscle_group": "shoulders",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Retraccion escapular banda elastica",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "warmup", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Flexiones Escapulares",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "warmup", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 20
                },
                {
                    "title": "Movilidad cadera",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "warmup", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Chest Fly (Machine)",
                    "es_title": "Aperturas (Máquina)",
                    "muscle_group": "chest",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 50, "reps": 14},
                        {"index": 1, "indicator": "normal", "weight_kg": 50, "reps": 7},
                        {"index": 2, "indicator": "normal", "weight_kg": 45, "reps": 7}
                    ],
                    "rest_seconds": 165
                },
                {
                    "title": "Incline Bench Press (Smith Machine)",
                    "es_title": "Press de Banca Inclinado (Máquina Smith)",
                    "muscle_group": "chest",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 32, "reps": 7},
                        {"index": 1, "indicator": "normal", "weight_kg": 27, "reps": 10},
                        {"index": 2, "indicator": "normal", "weight_kg": 27, "reps": 8}
                    ],
                    "rest_seconds": 180
                },
                {
                    "title": "Overhead Press (Smith Machine)",
                    "es_title": "Press de Hombros (Máquina Smith)",
                    "muscle_group": "shoulders",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 14, "reps": 8},
                        {"index": 1, "indicator": "normal", "weight_kg": 14, "reps": 7},
                        {"index": 2, "indicator": "normal", "weight_kg": 9, "reps": 8}
                    ],
                    "rest_seconds": 180
                },
                {
                    "title": "Seated Dip Machine",
                    "es_title": "Máquina para Fondos Sentado",
                    "muscle_group": "triceps",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 75, "reps": 9},
                        {"index": 1, "indicator": "normal", "weight_kg": 75, "reps": 9},
                        {"index": 2, "indicator": "normal", "weight_kg": 75, "reps": 8}
                    ],
                    "rest_seconds": 165
                },
                {
                    "title": "Triceps Pushdown",
                    "es_title": "Trícep con Polea",
                    "muscle_group": "triceps",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 30, "reps": 17},
                        {"index": 1, "indicator": "normal", "weight_kg": 30, "reps": 11},
                        {"index": 2, "indicator": "normal", "weight_kg": 30, "reps": 11}
                    ],
                    "rest_seconds": 120
                },
                {
                    "title": "Bicep Curl (Cable)",
                    "es_title": "Curl de Bíceps (Cable)",
                    "muscle_group": "biceps",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 31, "reps": 12},
                        {"index": 1, "indicator": "normal", "weight_kg": 31, "reps": 9}
                    ],
                    "rest_seconds": 165
                },
                {
                    "title": "Crunch (Machine)",
                    "es_title": "Abdominal Corto (Máquina)",
                    "muscle_group": "abdominals",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 70, "reps": 15},
                        {"index": 1, "indicator": "normal", "weight_kg": 70, "reps": 8},
                        {"index": 2, "indicator": "normal", "weight_kg": 70, "reps": 7}
                    ],
                    "rest_seconds": 120
                },
                {
                    "title": "Cycling",
                    "es_title": "Bicicleta",
                    "muscle_group": "cardio",
                    "sets": [{"index": 0, "indicator": "normal", "duration_seconds": 1200}],
                    "rest_seconds": 0
                }
            ]
        },
        {
            "id": "df991f19-f3bf-4f73-99be-f0f47ca90f75",
            "title": "Pull",
            "exercises": [
                {
                    "title": "Manquito Rotador Mancuerna",
                    "muscle_group": "shoulders",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": 5, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Retraccion escapular banda elastica",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Flexiones Escapulares",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Movilidad cadera",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Iso-Lateral Row (Machine)",
                    "es_title": "Remo Iso-Lateral",
                    "muscle_group": "upper_back",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 80, "reps": 14},
                        {"index": 1, "indicator": "normal", "weight_kg": 80, "reps": 10},
                        {"index": 2, "indicator": "normal", "weight_kg": 80, "reps": 9},
                        {"index": 3, "indicator": "normal", "weight_kg": 85, "reps": 8}
                    ],
                    "rest_seconds": 180
                },
                {
                    "title": "Lat Pulldown (Cable)",
                    "es_title": "Jalón al Pecho (Cable)",
                    "muscle_group": "lats",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 36, "reps": 11},
                        {"index": 1, "indicator": "normal", "weight_kg": 36, "reps": 9},
                        {"index": 2, "indicator": "normal", "weight_kg": 40, "reps": 8}
                    ],
                    "rest_seconds": 180
                },
                {
                    "title": "Rear Delt Reverse Fly (Machine)",
                    "es_title": "Vuelos Posteriores (Máquina)",
                    "muscle_group": "shoulders",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 30, "reps": 12},
                        {"index": 1, "indicator": "normal", "weight_kg": 30, "reps": 8},
                        {"index": 2, "indicator": "normal", "weight_kg": 30, "reps": 7}
                    ],
                    "rest_seconds": 150
                },
                {
                    "title": "Bicep Curl (Cable)",
                    "es_title": "Curl de Bíceps (Cable)",
                    "muscle_group": "biceps",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 36, "reps": 8},
                        {"index": 1, "indicator": "normal", "weight_kg": 31, "reps": 9},
                        {"index": 2, "indicator": "normal", "weight_kg": 31, "reps": 7}
                    ],
                    "rest_seconds": 165
                },
                {
                    "title": "Back Extension (Hyperextension)",
                    "es_title": "Extensión de Espalda (Hiperextensión)",
                    "muscle_group": "lower_back",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": None, "reps": 11},
                        {"index": 1, "indicator": "normal", "weight_kg": None, "reps": 11},
                        {"index": 2, "indicator": "normal", "weight_kg": None, "reps": 11}
                    ],
                    "rest_seconds": 120
                },
                {
                    "title": "Crunch (Machine)",
                    "es_title": "Abdominal Corto (Máquina)",
                    "muscle_group": "abdominals",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 70, "reps": 17},
                        {"index": 1, "indicator": "normal", "weight_kg": 75, "reps": 10},
                        {"index": 2, "indicator": "normal", "weight_kg": 75, "reps": 10}
                    ],
                    "rest_seconds": 120
                },
                {
                    "title": "Seated Incline Curl (Dumbbell)",
                    "es_title": "Curl de Bíceps Inclinado (Mancuerna)",
                    "muscle_group": "biceps",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": 18, "reps": 12}],
                    "rest_seconds": 150
                },
                {
                    "title": "Cycling",
                    "es_title": "Bicicleta",
                    "muscle_group": "cardio",
                    "sets": [{"index": 0, "indicator": "normal", "duration_seconds": 10}],
                    "rest_seconds": 0
                }
            ]
        },
        {
            "id": "d588ac4a-c067-4c50-8cdd-49101d5100b7",
            "title": "Legs",
            "exercises": [
                {
                    "title": "Movilidad cadera",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Movilidad Rodilla",
                    "muscle_group": "other",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Isquio pelota",
                    "muscle_group": "hamstrings",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 12}],
                    "rest_seconds": 0
                },
                {
                    "title": "Sentadilla pelota",
                    "muscle_group": "quadriceps",
                    "sets": [{"index": 0, "indicator": "normal", "weight_kg": None, "reps": 10}],
                    "rest_seconds": 0
                },
                {
                    "title": "Zancada estatico",
                    "muscle_group": "quadriceps",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 32, "reps": 15},
                        {"index": 1, "indicator": "normal", "weight_kg": 32, "reps": 15},
                        {"index": 2, "indicator": "normal", "weight_kg": 32, "reps": 12},
                        {"index": 3, "indicator": "normal", "weight_kg": 28, "reps": 12}
                    ],
                    "rest_seconds": 180
                },
                {
                    "title": "Leg Extension (Machine)",
                    "es_title": "Extensión de Pierna",
                    "muscle_group": "quadriceps",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 50, "reps": 12},
                        {"index": 1, "indicator": "normal", "weight_kg": 50, "reps": 11},
                        {"index": 2, "indicator": "normal", "weight_kg": 50, "reps": 10}
                    ],
                    "rest_seconds": 165
                },
                {
                    "title": "Seated Leg Curl (Machine)",
                    "es_title": "Curl de Pierna Sentado",
                    "muscle_group": "hamstrings",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 55, "reps": 12},
                        {"index": 1, "indicator": "normal", "weight_kg": 55, "reps": 10},
                        {"index": 2, "indicator": "normal", "weight_kg": 55, "reps": 8}
                    ],
                    "rest_seconds": 165
                },
                {
                    "title": "Hip Adduction (Machine)",
                    "es_title": "Aducción de Caderas",
                    "muscle_group": "adductors",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 79, "reps": 11},
                        {"index": 1, "indicator": "normal", "weight_kg": 79, "reps": 10}
                    ],
                    "rest_seconds": 150
                },
                {
                    "title": "Hip Abduction (Machine)",
                    "es_title": "Abducción de Caderas",
                    "muscle_group": "abductors",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 79, "reps": 11},
                        {"index": 1, "indicator": "normal", "weight_kg": 74, "reps": 13}
                    ],
                    "rest_seconds": 150
                },
                {
                    "title": "Back Extension (Weighted Hyperextension)",
                    "es_title": "Extensión de Espalda (Hiperextensión con peso)",
                    "muscle_group": "lower_back",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 0, "reps": 11},
                        {"index": 1, "indicator": "normal", "weight_kg": 11, "reps": 11},
                        {"index": 2, "indicator": "normal", "weight_kg": 11, "reps": 7}
                    ],
                    "rest_seconds": 135
                },
                {
                    "title": "Crunch (Machine)",
                    "es_title": "Abdominal Corto (Máquina)",
                    "muscle_group": "abdominals",
                    "sets": [
                        {"index": 0, "indicator": "normal", "weight_kg": 50, "reps": 14},
                        {"index": 1, "indicator": "normal", "weight_kg": 60, "reps": 10}
                    ],
                    "rest_seconds": 165
                }
            ]
        }
    ]
}

def update_warmups():
    all_exs = api_request("exercises?select=id,name,name_es") or []
    ex_map = {}
    for ex in all_exs:
        if ex.get("name"):
            ex_map[ex["name"].lower().strip()] = ex
        if ex.get("name_es"):
            ex_map[ex["name_es"].lower().strip()] = ex

    profiles = api_request("profiles?select=id&limit=1")
    profile_id = profiles[0]["id"]

    for r_item in HEVY_PAYLOAD_EXACT["updated"]:
        r_name = r_item["title"]
        parsed_exercises = []

        for ex_data in r_item["exercises"]:
            raw_title = ex_data.get("title", "")
            es_title = ex_data.get("es_title", "")
            ex_obj = ex_map.get(raw_title.lower().strip()) or ex_map.get(es_title.lower().strip())

            if not ex_obj:
                continue

            sets_list = ex_data.get("sets") or []

            parsed_exercises.append({
                "exercise_id": ex_obj["id"],
                "exercise": ex_obj,
                "target_sets": len(sets_list),
                "target_reps": str(sets_list[0].get("reps") if sets_list else 10),
                "rest_seconds": ex_data.get("rest_seconds", 90),
                "sets": [
                    {
                        "indicator": s.get("indicator", "normal"),
                        "weight_kg": s.get("weight_kg") if s.get("weight_kg") is not None else "",
                        "reps": s.get("reps") if s.get("reps") is not None else "",
                        "duration_seconds": s.get("duration_seconds")
                    }
                    for s in sets_list
                ]
            })

        existing_r = api_request(f"routines?name=eq.{urllib.parse.quote(r_name)}&profile_id=eq.{profile_id}")
        if existing_r:
            r_id = existing_r[0]["id"]
            api_request(f"routines?id=eq.{r_id}", method="PATCH", data={"exercises": parsed_exercises})
            print(f"✅ Updated routine '{r_name}' exercises with exact set indicators (warmup/normal).", flush=True)

if __name__ == "__main__":
    update_warmups()
