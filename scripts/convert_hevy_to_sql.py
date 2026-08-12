#!/usr/bin/env python3
import json
import os
import sys
import uuid
import argparse
import re

# Existing catalog mapping dictionary (name -> muscle_group, type, equipment)
CATALOG_EXERCISES = {
    "bench press": {"name": "Bench Press", "name_es": "Press de Banca", "muscle": "chest", "type": "weight_reps", "equip": "barbell"},
    "incline bench press": {"name": "Incline Bench Press", "name_es": "Press Inclinado", "muscle": "chest", "type": "weight_reps", "equip": "barbell"},
    "decline bench press": {"name": "Decline Bench Press", "name_es": "Press Declinado", "muscle": "chest", "type": "weight_reps", "equip": "barbell"},
    "dumbbell bench press": {"name": "Dumbbell Bench Press", "name_es": "Press con Mancuernas", "muscle": "chest", "type": "weight_reps", "equip": "dumbbell"},
    "incline dumbbell press": {"name": "Incline Dumbbell Press", "name_es": "Press Inclinado Mancuernas", "muscle": "chest", "type": "weight_reps", "equip": "dumbbell"},
    "dumbbell fly": {"name": "Dumbbell Fly", "name_es": "Aperturas con Mancuernas", "muscle": "chest", "type": "weight_reps", "equip": "dumbbell"},
    "cable fly": {"name": "Cable Fly", "name_es": "Aperturas en Polea", "muscle": "chest", "type": "weight_reps", "equip": "cable"},
    "chest dip": {"name": "Chest Dip", "name_es": "Fondos en Paralelas", "muscle": "chest", "type": "weight_reps", "equip": "bodyweight"},
    "push up": {"name": "Push Up", "name_es": "Flexiones", "muscle": "chest", "type": "reps_only", "equip": "bodyweight"},
    
    "deadlift": {"name": "Deadlift", "name_es": "Peso Muerto", "muscle": "back", "type": "weight_reps", "equip": "barbell"},
    "barbell row": {"name": "Barbell Row", "name_es": "Remo con Barra", "muscle": "back", "type": "weight_reps", "equip": "barbell"},
    "dumbbell row": {"name": "Dumbbell Row", "name_es": "Remo con Mancuerna", "muscle": "back", "type": "weight_reps", "equip": "dumbbell"},
    "pull up": {"name": "Pull Up", "name_es": "Dominadas", "muscle": "back", "type": "reps_only", "equip": "bodyweight"},
    "chin up": {"name": "Chin Up", "name_es": "Dominadas Supinas", "muscle": "back", "type": "reps_only", "equip": "bodyweight"},
    "lat pulldown": {"name": "Lat Pulldown", "name_es": "Jalón al Pecho", "muscle": "back", "type": "weight_reps", "equip": "cable"},
    "seated cable row": {"name": "Seated Cable Row", "name_es": "Remo Sentado en Polea", "muscle": "back", "type": "weight_reps", "equip": "cable"},

    "barbell squat": {"name": "Barbell Squat", "name_es": "Sentadilla con Barra", "muscle": "legs", "type": "weight_reps", "equip": "barbell"},
    "squat": {"name": "Barbell Squat", "name_es": "Sentadilla con Barra", "muscle": "legs", "type": "weight_reps", "equip": "barbell"},
    "front squat": {"name": "Front Squat", "name_es": "Sentadilla Frontal", "muscle": "legs", "type": "weight_reps", "equip": "barbell"},
    "leg press": {"name": "Leg Press", "name_es": "Prensa de Piernas", "muscle": "legs", "type": "weight_reps", "equip": "machine"},
    "romanian deadlift": {"name": "Romanian Deadlift", "name_es": "Peso Muerto Rumano", "muscle": "legs", "type": "weight_reps", "equip": "barbell"},
    "leg extension": {"name": "Leg Extension", "name_es": "Extensión de Cuádriceps", "muscle": "legs", "type": "weight_reps", "equip": "machine"},
    "leg curl": {"name": "Leg Curl", "name_es": "Curl de Isquiotibiales", "muscle": "legs", "type": "weight_reps", "equip": "machine"},

    "overhead press": {"name": "Overhead Press", "name_es": "Press Militar", "muscle": "shoulders", "type": "weight_reps", "equip": "barbell"},
    "dumbbell shoulder press": {"name": "Dumbbell Shoulder Press", "name_es": "Press Hombros Mancuernas", "muscle": "shoulders", "type": "weight_reps", "equip": "dumbbell"},
    "lateral raise": {"name": "Lateral Raise", "name_es": "Elevaciones Laterales", "muscle": "shoulders", "type": "weight_reps", "equip": "dumbbell"},

    "barbell curl": {"name": "Barbell Curl", "name_es": "Curl con Barra", "muscle": "biceps", "type": "weight_reps", "equip": "barbell"},
    "dumbbell curl": {"name": "Dumbbell Curl", "name_es": "Curl con Mancuernas", "muscle": "biceps", "type": "weight_reps", "equip": "dumbbell"},
    "hammer curl": {"name": "Hammer Curl", "name_es": "Curl Martillo", "muscle": "biceps", "type": "weight_reps", "equip": "dumbbell"},

    "tricep dip": {"name": "Tricep Dip", "name_es": "Fondos de Tríceps", "muscle": "triceps", "type": "reps_only", "equip": "bodyweight"},
    "triceps pushdown": {"name": "Triceps Pushdown", "name_es": "Tríceps con Polea", "muscle": "triceps", "type": "weight_reps", "equip": "cable"},

    "plank": {"name": "Plank", "name_es": "Plancha", "muscle": "abdominals", "type": "duration_only", "equip": "bodyweight"},
}

def clean_str(val):
    if not val:
        return ""
    return str(val).replace("'", "''").strip()

def normalize_name(title):
    t = str(title).lower().strip()
    t = re.sub(r'\s*\([^)]*\)', '', t).strip()
    return t

def convert_hevy_json_to_sql(input_json="data/hevy_workouts.json", output_sql="data/hevy_migration.sql", profile_id=None):
    if not os.path.exists(input_json):
        print(f"⚠️  Input file '{input_json}' not found. Please run fetch_hevy_workouts.py first or specify valid JSON file.")
        return

    with open(input_json, "r", encoding="utf-8") as f:
        workouts_data = json.load(f)

    if not isinstance(workouts_data, list):
        print("⚠️  Invalid JSON format: expected a list of workouts.")
        return

    sql_statements = []
    sql_statements.append("-- ============================================================================")
    sql_statements.append("-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP")
    sql_statements.append(f"-- Generated from {input_json} ({len(workouts_data)} workouts)")
    sql_statements.append("-- ============================================================================\n")

    created_custom_exercises = set()

    for w_idx, workout in enumerate(workouts_data):
        w_title = clean_str(workout.get("title") or workout.get("name") or f"Hevy Workout #{w_idx+1}")
        started_at = workout.get("start_time") or workout.get("started_at") or workout.get("created_at") or "now()"
        finished_at = workout.get("end_time") or workout.get("finished_at") or workout.get("completed_at") or started_at
        
        duration_mins = workout.get("duration_minutes") or workout.get("duration") or 30
        if duration_mins and isinstance(duration_mins, int) and duration_mins > 600:
            duration_mins = max(1, round(duration_mins / 60))

        estimated_vol = workout.get("estimated_volume_kg") or workout.get("volume_kg") or 0

        w_id_var = f"w_id_{w_idx+1}"

        sql_statements.append(f"-- ── WORKOUT {w_idx+1}: {w_title} ──")
        sql_statements.append("DO $$")
        sql_statements.append("DECLARE")
        sql_statements.append(f"  {w_id_var} UUID := gen_random_uuid();")
        sql_statements.append("  target_profile_id UUID;")
        sql_statements.append("  target_exercise_id UUID;")
        sql_statements.append("BEGIN")

        if profile_id:
            sql_statements.append(f"  target_profile_id := '{profile_id}';")
        else:
            sql_statements.append("  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;")

        # Insert Workout row
        prof_val = "target_profile_id"
        start_val = f"'{started_at}'::timestamptz" if started_at != "now()" else "now()"
        finish_val = f"'{finished_at}'::timestamptz" if finished_at != "now()" else "now()"

        sql_statements.append(f"""  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES ({w_id_var}, {prof_val}, '{w_title}', {start_val}, {finish_val}, {duration_mins}, {estimated_vol});""")

        # Process exercises inside workout
        exercises_list = workout.get("exercises") or workout.get("workout_exercises") or []
        
        set_counter = 0
        for ex_item in exercises_list:
            ex_title = ex_item.get("title") or ex_item.get("name") or ex_item.get("exercise_title") or "Custom Exercise"
            norm_ex_title = normalize_name(ex_title)

            # Match exercise or insert custom exercise if missing
            cat_match = CATALOG_EXERCISES.get(norm_ex_title)
            ex_clean_name = clean_str(ex_title)

            sql_statements.append(f"\n  -- Exercise: {ex_clean_name}")
            sql_statements.append(f"  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('{ex_clean_name}') OR LOWER(name_es) = LOWER('{ex_clean_name}') LIMIT 1;")
            
            sql_statements.append("  IF target_exercise_id IS NULL THEN")
            muscle_g = cat_match["muscle"] if cat_match else "other"
            ex_t = cat_match["type"] if cat_match else "weight_reps"
            equip_cat = cat_match["equip"] if cat_match else "dumbbell"

            sql_statements.append(f"""    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('{ex_clean_name}', '{ex_clean_name}', '{ex_t}', '{muscle_g}', '{equip_cat}', true)
    RETURNING id INTO target_exercise_id;""")
            sql_statements.append("  END IF;")

            sets_list = ex_item.get("sets") or []
            for s_idx, s_item in enumerate(sets_list):
                set_counter += 1
                indicator = s_item.get("set_type") or s_item.get("indicator") or "normal"
                if indicator not in ["normal", "warmup", "dropset", "failure"]:
                    indicator = "normal"

                weight = s_item.get("weight_kg") or s_item.get("weight") or 0
                reps = s_item.get("reps") or 0
                duration = s_item.get("duration_seconds") or s_item.get("duration") or "NULL"
                distance = s_item.get("distance_meters") or s_item.get("distance") or "NULL"

                sql_statements.append(f"""  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES ({w_id_var}, target_exercise_id, {set_counter}, '{indicator}', {weight}, {reps}, {duration}, {distance});""")

        sql_statements.append("END $$;\n")

    os.makedirs(os.path.dirname(output_sql), exist_ok=True)
    with open(output_sql, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_statements))

    print(f"🎉 Successfully generated SQL migration script at '{output_sql}' with {len(workouts_data)} workouts!")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert Hevy JSON workouts to Supabase SQL migration")
    parser.add_argument("--input", default="data/hevy_workouts.json", help="Input JSON file path")
    parser.add_argument("--output", default="data/hevy_migration.sql", help="Output SQL script path")
    parser.add_argument("--profile-id", default=None, help="Optional UUID profile_id for Supabase")

    args = parser.parse_args()
    convert_hevy_json_to_sql(input_json=args.input, output_sql=args.output, profile_id=args.profile_id)
