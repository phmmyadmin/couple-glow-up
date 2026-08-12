-- ============================================================================
-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP
-- Generated from data/hevy_workouts_sample.json (1 workouts)
-- ============================================================================

-- ── WORKOUT 1: Push Day - Chest & Shoulders ──
DO $$
DECLARE
  w_id_1 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_1, target_profile_id, 'Push Day - Chest & Shoulders', '2026-08-10T14:30:00Z'::timestamptz, '2026-08-10T15:25:00Z'::timestamptz, 55, 4200);

  -- Exercise: Bench Press
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press') OR LOWER(name_es) = LOWER('Bench Press') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press', 'Bench Press', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 1, 'warmup', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 2, 'normal', 80, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 3, 'normal', 85, 6, NULL, NULL);

  -- Exercise: Incline Dumbbell Press
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Dumbbell Press') OR LOWER(name_es) = LOWER('Incline Dumbbell Press') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Dumbbell Press', 'Incline Dumbbell Press', 'weight_reps', 'chest', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 4, 'normal', 28, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 5, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Custom Heavy Machine Fly
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Custom Heavy Machine Fly') OR LOWER(name_es) = LOWER('Custom Heavy Machine Fly') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Custom Heavy Machine Fly', 'Custom Heavy Machine Fly', 'weight_reps', 'other', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 6, 'normal', 45, 12, NULL, NULL);
END $$;
