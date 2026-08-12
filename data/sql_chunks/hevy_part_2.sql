-- ============================================================================
-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP
-- Generated from data/hevy_workouts.json (236 workouts)
-- ============================================================================

-- ── WORKOUT 51: Torso espalda 1 ──
DO $$
DECLARE
  w_id_51 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_51, target_profile_id, 'Torso espalda 1', to_timestamp(1771590668), to_timestamp(1771594628), 30, 6858);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 1, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 2, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 3, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 5, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 6, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 7, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 8, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 9, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 10, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 11, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 12, 'normal', 60, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 13, 'normal', 16, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 14, 'normal', 16, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 15, 'normal', 16, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 16, 'normal', 16, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_51, target_exercise_id, 17, 'normal', 16, 9, NULL, NULL);
END $$;

-- ── WORKOUT 52: Torso pecho 2 ──
DO $$
DECLARE
  w_id_52 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_52, target_profile_id, 'Torso pecho 2', to_timestamp(1771330141), to_timestamp(1771333837), 30, 7536.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 1, 'normal', 65, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 2, 'normal', 60, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 3, 'normal', 60, 5, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 4, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 5, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 6, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 7, 'normal', 75, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 8, 'normal', 75, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 9, 'normal', 75, 10, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 10, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 11, 'normal', 34.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 12, 'normal', 34.5, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 13, 'normal', 39, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 14, 'normal', 41.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_52, target_exercise_id, 15, 'normal', 41.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 53: Torso ──
DO $$
DECLARE
  w_id_53 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_53, target_profile_id, 'Torso', to_timestamp(1771064873), to_timestamp(1771070351), 30, 9173.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 1, 'normal', 55, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 2, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 3, 'normal', 55, 5, NULL, NULL);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 4, 'normal', 60, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 5, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 6, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 7, 'normal', 72.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 8, 'normal', 72.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 9, 'normal', 72.5, 11, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 10, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 12, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 13, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 14, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 15, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 16, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 17, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 18, 'normal', 20, 6, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 19, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 20, 'normal', 20, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 21, 'normal', 20, 5, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_53, target_exercise_id, 22, 'normal', 32, 9, NULL, NULL);
END $$;

-- ── WORKOUT 54: Torso espalda 1 ──
DO $$
DECLARE
  w_id_54 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_54, target_profile_id, 'Torso espalda 1', to_timestamp(1770726360), to_timestamp(1770729757), 30, 5603);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 1, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 3, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 4, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 5, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 6, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 7, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 8, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 9, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 10, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 11, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 12, 'normal', 20, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_54, target_exercise_id, 13, 'normal', 20, 5, NULL, NULL);
END $$;

-- ── WORKOUT 55: Torso pecho 1 ──
DO $$
DECLARE
  w_id_55 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_55, target_profile_id, 'Torso pecho 1', to_timestamp(1770545584), to_timestamp(1770549189), 30, 6882.5);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 1, 'normal', 45, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 2, 'normal', 45, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 3, 'normal', 45, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 4, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 5, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 6, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 7, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 8, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 9, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 10, 'normal', 48, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 11, 'normal', 48, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 12, 'normal', 72.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 13, 'normal', 72.5, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 14, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 15, 'normal', 41.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_55, target_exercise_id, 16, 'normal', 41.5, 7, NULL, NULL);
END $$;

-- ── WORKOUT 56: Torso espalda 1 ──
DO $$
DECLARE
  w_id_56 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_56, target_profile_id, 'Torso espalda 1', to_timestamp(1770186102), to_timestamp(1770189620), 30, 6634);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 1, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 3, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 4, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 5, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 6, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 8, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 9, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 11, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 12, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 13, 'normal', 54, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 14, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 15, 'normal', 20, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_56, target_exercise_id, 16, 'normal', 20, 5, NULL, NULL);
END $$;

-- ── WORKOUT 57: Torso pecho 2 ──
DO $$
DECLARE
  w_id_57 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_57, target_profile_id, 'Torso pecho 2', to_timestamp(1770099940), to_timestamp(1770103161), 30, 5658);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 1, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 2, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 4, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 5, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 6, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 7, 'normal', 72.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 8, 'normal', 72.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 9, 'normal', 72.5, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 10, 'normal', 27.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 11, 'normal', 27.5, 5, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 12, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_57, target_exercise_id, 13, 'normal', 39, 8, NULL, NULL);
END $$;

-- ── WORKOUT 58: Torso espalda 1 ──
DO $$
DECLARE
  w_id_58 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_58, target_profile_id, 'Torso espalda 1', to_timestamp(1767619215), to_timestamp(1767622436), 30, 5668);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 1, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 3, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 4, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 5, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 6, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 7, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 8, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 9, 'normal', 54, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 10, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 11, 'normal', 20, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_58, target_exercise_id, 12, 'normal', 20, 5, NULL, NULL);
END $$;

-- ── WORKOUT 59: Torso pecho 2 ──
DO $$
DECLARE
  w_id_59 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_59, target_profile_id, 'Torso pecho 2', to_timestamp(1767527236), to_timestamp(1767530790), 30, 6713);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 1, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 2, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 3, 'normal', 60, 6, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 4, 'normal', 75, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 5, 'normal', 75, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 6, 'normal', 75, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 7, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 9, 'normal', 47, 6, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 10, 'normal', 32, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 11, 'normal', 32, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 12, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 13, 'normal', 39, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 14, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_59, target_exercise_id, 15, 'normal', 39, 8, NULL, NULL);
END $$;

-- ── WORKOUT 60: Torso espalda 1 ──
DO $$
DECLARE
  w_id_60 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_60, target_profile_id, 'Torso espalda 1', to_timestamp(1767174789), to_timestamp(1767179302), 30, 6104);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 1, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 3, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 4, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 5, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 6, 'normal', 60, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 7, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 8, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 9, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 10, 'normal', 25, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 11, 'normal', 25, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 12, 'normal', 25, 5, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 13, 'normal', 32, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_60, target_exercise_id, 14, 'normal', 32, 8, NULL, NULL);
END $$;

-- ── WORKOUT 61: Torso pecho 2 ──
DO $$
DECLARE
  w_id_61 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_61, target_profile_id, 'Torso pecho 2', to_timestamp(1767090604), to_timestamp(1767093298), 30, 4960);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 1, 'normal', 52.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 2, 'normal', 62.5, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 3, 'normal', 62.5, 4, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 4, 'normal', 72.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 5, 'normal', 72.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 6, 'normal', 72.5, 11, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 7, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 8, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_61, target_exercise_id, 9, 'normal', 41.5, 9, NULL, NULL);
END $$;

-- ── WORKOUT 62: Entrenamiento por la tarde 💪 ──
DO $$
DECLARE
  w_id_62 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_62, target_profile_id, 'Entrenamiento por la tarde 💪', to_timestamp(1766839041), to_timestamp(1766842754), 30, 6822);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 1, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 2, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 3, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 4, 'normal', 45, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 5, 'normal', 45, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 6, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 7, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 9, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 10, 'normal', 60, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 11, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 12, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 13, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 14, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_62, target_exercise_id, 15, 'normal', 20, 6, NULL, NULL);
END $$;

-- ── WORKOUT 63: Pierna 1 ──
DO $$
DECLARE
  w_id_63 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_63, target_profile_id, 'Pierna 1', to_timestamp(1766591495), to_timestamp(1766594584), 30, 6245);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 1, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 3, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 5, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 6, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 8, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 9, 'normal', 35, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_63, target_exercise_id, 10, 'normal', 35, 8, NULL, NULL);
END $$;

-- ── WORKOUT 64: Torso pecho 2 ──
DO $$
DECLARE
  w_id_64 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_64, target_profile_id, 'Torso pecho 2', to_timestamp(1766513788), to_timestamp(1766517231), 30, 4679.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 1, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 2, 'normal', 60, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 3, 'normal', 60, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 4, 'normal', 60, 4, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 5, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 6, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 7, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 8, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 9, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 10, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 11, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 12, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 13, 'normal', 72.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_64, target_exercise_id, 14, 'normal', 72.5, 7, NULL, NULL);
END $$;

-- ── WORKOUT 65: Torso espalda 1 ──
DO $$
DECLARE
  w_id_65 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_65, target_profile_id, 'Torso espalda 1', to_timestamp(1766425111), to_timestamp(1766428699), 30, 5429);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 1, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 2, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 3, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 4, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 5, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 6, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 7, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 9, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 10, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 11, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 12, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 13, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 14, 'normal', 16, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_65, target_exercise_id, 15, 'normal', 16, 10, NULL, NULL);
END $$;

-- ── WORKOUT 66: Entrenamiento Matutino ☀️ ──
DO $$
DECLARE
  w_id_66 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_66, target_profile_id, 'Entrenamiento Matutino ☀️', to_timestamp(1766225436), to_timestamp(1766229090), 30, 8256.5);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 1, 'normal', 87.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 2, 'normal', 87.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 3, 'normal', 87.5, 8, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 4, 'normal', 87.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 5, 'normal', 87.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 6, 'normal', 87.5, 10, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 7, 'normal', 30, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 8, 'normal', 30, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 9, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 10, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 11, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 12, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 13, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_66, target_exercise_id, 14, 'normal', 48, 12, NULL, NULL);
END $$;

-- ── WORKOUT 67: Torso espalda 1 ──
DO $$
DECLARE
  w_id_67 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_67, target_profile_id, 'Torso espalda 1', to_timestamp(1765907342), to_timestamp(1765911263), 30, 7083.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 1, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 2, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 3, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 4, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 5, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 6, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 7, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 8, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 9, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 10, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 11, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 12, 'normal', 60, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 13, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 14, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 15, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 16, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 17, 'normal', 15, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_67, target_exercise_id, 18, 'normal', 15, 7, NULL, NULL);
END $$;

-- ── WORKOUT 68: Torso pecho 2 ──
DO $$
DECLARE
  w_id_68 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_68, target_profile_id, 'Torso pecho 2', to_timestamp(1765819679), to_timestamp(1765823232), 30, 6288.5);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 1, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 2, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 3, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 4, 'normal', 45, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 5, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 6, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 7, 'normal', 55, 4, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 8, 'normal', 72.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 9, 'normal', 72.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 10, 'normal', 72.5, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 11, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 12, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_68, target_exercise_id, 13, 'normal', 39, 9, NULL, NULL);
END $$;

-- ── WORKOUT 69: Pierna 1 ──
DO $$
DECLARE
  w_id_69 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_69, target_profile_id, 'Pierna 1', to_timestamp(1765559168), to_timestamp(1765562321), 30, 2940);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 1, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 2, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 4, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 5, 'normal', 30, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 6, 'normal', 30, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 7, 'normal', 30, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_69, target_exercise_id, 8, 'normal', 20, 11, NULL, NULL);
END $$;

-- ── WORKOUT 70: Torso espalda 1 ──
DO $$
DECLARE
  w_id_70 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_70, target_profile_id, 'Torso espalda 1', to_timestamp(1765389669), to_timestamp(1765393569), 30, 5908);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 1, 'normal', 70, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 2, 'normal', 70, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 3, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 4, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 5, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 6, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 7, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 9, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 10, 'normal', 15, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 11, 'normal', 15, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 12, 'normal', 15, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 13, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 14, 'normal', 39, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_70, target_exercise_id, 15, 'normal', 32, 7, NULL, NULL);
END $$;

-- ── WORKOUT 71: Torso pecho 2 ──
DO $$
DECLARE
  w_id_71 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_71, target_profile_id, 'Torso pecho 2', to_timestamp(1765302540), to_timestamp(1765305101), 30, 5767.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 1, 'normal', 40, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 2, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 4, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 5, 'normal', 72.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 6, 'normal', 72.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 7, 'normal', 72.5, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 8, 'normal', 30, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 9, 'normal', 30, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 10, 'normal', 30, 16, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 11, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_71, target_exercise_id, 12, 'normal', 20, 9, NULL, NULL);
END $$;

-- ── WORKOUT 72: Torso pecho 2 ──
DO $$
DECLARE
  w_id_72 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_72, target_profile_id, 'Torso pecho 2', to_timestamp(1764266385), to_timestamp(1764269986), 30, 10034.5);

  -- Exercise: Scapular Pull Ups
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Scapular Pull Ups') OR LOWER(name_es) = LOWER('Scapular Pull Ups') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Scapular Pull Ups', 'Scapular Pull Ups', 'reps_only', 'upper_back', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 4, 'normal', 5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 5, 'normal', 5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 6, 'normal', 5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 7, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Cal Hombro 2 Mancuernas
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cal Hombro 2 Mancuernas') OR LOWER(name_es) = LOWER('Cal Hombro 2 Mancuernas') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cal Hombro 2 Mancuernas', 'Cal Hombro 2 Mancuernas', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 8, 'normal', 10, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 9, 'normal', 10, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 10, 'normal', 10, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 11, 'normal', 10, 12, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 12, 'normal', 48, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 13, 'normal', 48, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 14, 'normal', 48, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 15, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 16, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 17, 'normal', 72.5, 11, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 18, 'normal', 45, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 19, 'normal', 45, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 20, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 21, 'normal', 39, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 22, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_72, target_exercise_id, 23, 'normal', 39, 10, NULL, NULL);
END $$;

-- ── WORKOUT 73: Pierna 1 ──
DO $$
DECLARE
  w_id_73 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_73, target_profile_id, 'Pierna 1', to_timestamp(1764180083), to_timestamp(1764182702), 30, 2793);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 1, 'normal', 60, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 3, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 4, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 5, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 6, 'normal', 46, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_73, target_exercise_id, 7, 'normal', 39, 9, NULL, NULL);
END $$;

-- ── WORKOUT 74: Torso espalda 1 ──
DO $$
DECLARE
  w_id_74 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_74, target_profile_id, 'Torso espalda 1', to_timestamp(1764093285), to_timestamp(1764096806), 30, 6310);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 1, 'normal', 70, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 3, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 4, 'normal', 80, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 5, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 6, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 7, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 8, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 9, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Three Angle Biceps
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Three Angle Biceps') OR LOWER(name_es) = LOWER('Three Angle Biceps') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Three Angle Biceps', 'Three Angle Biceps', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 10, 'normal', 30, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 11, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 12, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 13, 'normal', 15, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 14, 'normal', 15, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_74, target_exercise_id, 15, 'normal', 15, 12, NULL, NULL);
END $$;

-- ── WORKOUT 75: Pecho + espalda ──
DO $$
DECLARE
  w_id_75 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_75, target_profile_id, 'Pecho + espalda', to_timestamp(1763810255), to_timestamp(1763813975), 30, 5326);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 1, 'normal', 68, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 2, 'normal', 68, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 3, 'normal', 68, 6, NULL, NULL);

  -- Exercise: Pull Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up') OR LOWER(name_es) = LOWER('Pull Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up', 'Pull Up', 'reps_only', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 4, 'normal', NULL, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 5, 'normal', NULL, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 6, 'normal', NULL, 4, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 7, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 9, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 10, 'normal', 15, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 11, 'normal', 15, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 12, 'normal', 15, 13, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 13, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 14, 'normal', 20, 9, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 15, 'normal', 15, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_75, target_exercise_id, 16, 'normal', 15, 13, NULL, NULL);
END $$;

-- ── WORKOUT 76: Pierna 1 ──
DO $$
DECLARE
  w_id_76 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_76, target_profile_id, 'Pierna 1', to_timestamp(1763748274), to_timestamp(1763752174), 30, 3480);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 1, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 2, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 4, 'normal', 60, 5, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 5, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 6, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 7, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 8, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 9, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 10, 'normal', 15, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 11, 'normal', 35, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 12, 'normal', 35, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_76, target_exercise_id, 13, 'normal', 35, 7, NULL, NULL);
END $$;

-- ── WORKOUT 77: Torso espalda 1 ──
DO $$
DECLARE
  w_id_77 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_77, target_profile_id, 'Torso espalda 1', to_timestamp(1763661382), to_timestamp(1763664262), 30, 5459);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 1, 'normal', 60, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 2, 'normal', 80, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 3, 'normal', 70, 7, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 5, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 6, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 7, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 8, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 9, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 10, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 11, 'normal', 41.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_77, target_exercise_id, 12, 'normal', 39, 7, NULL, NULL);
END $$;

-- ── WORKOUT 78: Torso pecho 2 ──
DO $$
DECLARE
  w_id_78 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_78, target_profile_id, 'Torso pecho 2', to_timestamp(1763573807), to_timestamp(1763577170), 30, 5246);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 1, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 2, 'normal', 60, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 3, 'normal', 60, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 4, 'normal', 60, 4, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 5, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 6, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 7, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 8, 'normal', 30, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 9, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 10, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 11, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_78, target_exercise_id, 12, 'normal', 39, 10, NULL, NULL);
END $$;

-- ── WORKOUT 79: Pierna 1 ──
DO $$
DECLARE
  w_id_79 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_79, target_profile_id, 'Pierna 1', to_timestamp(1763485769), to_timestamp(1763490182), 30, 10378);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 1, 'normal', 110, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 2, 'normal', 110, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 3, 'normal', 110, 15, NULL, NULL);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 4, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 5, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 6, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 8, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 9, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 10, 'normal', 50, 12, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 11, 'normal', 54, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 12, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_79, target_exercise_id, 13, 'normal', 54, 8, NULL, NULL);
END $$;

-- ── WORKOUT 80: Pecho + espalda ──
DO $$
DECLARE
  w_id_80 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_80, target_profile_id, 'Pecho + espalda', to_timestamp(1763199230), to_timestamp(1763203072), 30, 6449);

  -- Exercise: Pull Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up') OR LOWER(name_es) = LOWER('Pull Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up', 'Pull Up', 'reps_only', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 1, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 2, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 3, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 4, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 5, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 6, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 7, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 8, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 9, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 10, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 11, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 12, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 13, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 14, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 15, 'normal', NULL, 2, NULL, NULL);

  -- Exercise: Chin Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up') OR LOWER(name_es) = LOWER('Chin Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up', 'Chin Up', 'reps_only', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 16, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 17, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 18, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 19, 'normal', NULL, 2, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 20, 'normal', 68, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 21, 'normal', 68, 7, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 22, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 23, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 24, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 25, 'normal', 15, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 26, 'normal', 15, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 27, 'normal', 15, 10, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 28, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 29, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 30, 'normal', 20, 9, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 31, 'normal', 15, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 32, 'normal', 15, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_80, target_exercise_id, 33, 'normal', 15, 11, NULL, NULL);
END $$;

-- ── WORKOUT 81: Pierna 1 ──
DO $$
DECLARE
  w_id_81 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_81, target_profile_id, 'Pierna 1', to_timestamp(1763141399), to_timestamp(1763145440), 30, 5000);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 1, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 2, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 3, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 4, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Lunge (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lunge (Dumbbell)') OR LOWER(name_es) = LOWER('Lunge (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lunge (Dumbbell)', 'Lunge (Dumbbell)', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 5, 'normal', 20, 22, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 6, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 7, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 8, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 9, 'normal', 20, 11, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 11, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 12, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 13, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_81, target_exercise_id, 14, 'normal', 54, 8, NULL, NULL);
END $$;

-- ── WORKOUT 82: Torso espalda 1 ──
DO $$
DECLARE
  w_id_82 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_82, target_profile_id, 'Torso espalda 1', to_timestamp(1763057055), to_timestamp(1763061359), 30, 6153);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 1, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 3, 'normal', 50, 9, NULL, NULL);

  -- Exercise: T Bar Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('T Bar Row') OR LOWER(name_es) = LOWER('T Bar Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('T Bar Row', 'T Bar Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 4, 'normal', 38, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 5, 'normal', 38, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 6, 'normal', 38, 10, NULL, NULL);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 7, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 8, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 11, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 12, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 13, 'normal', 30, 11, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 14, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 15, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_82, target_exercise_id, 16, 'normal', 15, 11, NULL, NULL);
END $$;

-- ── WORKOUT 83: Torso pecho 2 ──
DO $$
DECLARE
  w_id_83 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_83, target_profile_id, 'Torso pecho 2', to_timestamp(1762969328), to_timestamp(1762973587), 30, 6943.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 1, 'normal', 47.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 2, 'normal', 57.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 3, 'normal', 57.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 4, 'normal', 57.5, 6, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 5, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 6, 'normal', 72.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 7, 'normal', 72.5, 11, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 8, 'normal', 20, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 9, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 10, 'normal', 20, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 11, 'normal', 45, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 12, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 13, 'normal', 39, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 14, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_83, target_exercise_id, 15, 'normal', 39, 9, NULL, NULL);
END $$;

-- ── WORKOUT 84: Pierna 1 ──
DO $$
DECLARE
  w_id_84 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_84, target_profile_id, 'Pierna 1', to_timestamp(1762883544), to_timestamp(1762887834), 30, 9675);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 1, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 2, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 3, 'normal', 95, 13, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 4, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 5, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 6, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 7, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 8, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 9, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 10, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 11, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 12, 'normal', 15, 11, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 13, 'normal', 25, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 14, 'normal', 25, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 15, 'normal', 25, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 16, 'normal', 25, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 17, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 18, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_84, target_exercise_id, 19, 'normal', 35, 6, NULL, NULL);
END $$;

-- ── WORKOUT 85: Entrenamiento por la tarde 💪 ──
DO $$
DECLARE
  w_id_85 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_85, target_profile_id, 'Entrenamiento por la tarde 💪', to_timestamp(1762603927), to_timestamp(1762608687), 30, 5989.5);

  -- Exercise: Pull Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up') OR LOWER(name_es) = LOWER('Pull Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up', 'Pull Up', 'reps_only', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 1, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 2, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 3, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 4, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 5, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 6, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 7, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 8, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 9, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 10, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 11, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 12, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 13, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 14, 'normal', NULL, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 15, 'normal', NULL, 1, NULL, NULL);

  -- Exercise: Chin Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up') OR LOWER(name_es) = LOWER('Chin Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up', 'Chin Up', 'reps_only', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 16, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 17, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 18, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 19, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 20, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 21, 'normal', NULL, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 22, 'normal', NULL, 2, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 23, 'normal', 68, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 24, 'normal', 68, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 25, 'normal', 68, 5, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 26, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 27, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 28, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 29, 'normal', 15, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 30, 'normal', 15, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 31, 'normal', 15, 10, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 32, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 33, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 34, 'normal', 20, 9, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 35, 'normal', 15, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 36, 'normal', 15, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_85, target_exercise_id, 37, 'normal', 15, 11, NULL, NULL);
END $$;

-- ── WORKOUT 86: Pierna 1 ──
DO $$
DECLARE
  w_id_86 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_86, target_profile_id, 'Pierna 1', to_timestamp(1762536788), to_timestamp(1762541444), 30, 9645);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 1, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 2, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 3, 'normal', 95, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 4, 'normal', 24, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 5, 'normal', 24, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 6, 'normal', 24, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 7, 'normal', 24, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 8, 'normal', 24, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 9, 'normal', 24, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 10, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 11, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 12, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 13, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 14, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 15, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 16, 'normal', 15, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 17, 'normal', 15, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 18, 'normal', 15, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 19, 'normal', 15, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 20, 'normal', 15, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 21, 'normal', 15, 7, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 22, 'normal', 27.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 23, 'normal', 27.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 24, 'normal', 27.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_86, target_exercise_id, 25, 'normal', 27.5, 11, NULL, NULL);
END $$;

-- ── WORKOUT 87: Torso espalda 1 ──
DO $$
DECLARE
  w_id_87 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_87, target_profile_id, 'Torso espalda 1', to_timestamp(1762451455), to_timestamp(1762454940), 30, 5398);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 1, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 2, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 3, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 4, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 5, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 6, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 7, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 8, 'normal', 38, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 9, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 10, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 11, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 12, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_87, target_exercise_id, 13, 'normal', 34.5, 9, NULL, NULL);
END $$;

-- ── WORKOUT 88: Torso pecho 2 ──
DO $$
DECLARE
  w_id_88 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_88, target_profile_id, 'Torso pecho 2', to_timestamp(1762275454), to_timestamp(1762278815), 30, 5785);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 1, 'normal', 45, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 2, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 3, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 4, 'normal', 55, 6, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 5, 'normal', 40, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 6, 'normal', 40, 5, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 7, 'normal', 25, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 8, 'normal', 25, 10, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 9, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 10, 'normal', 40, 5, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 11, 'normal', 57.5, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 12, 'normal', 57.5, 13, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 13, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_88, target_exercise_id, 14, 'normal', 41.5, 9, NULL, NULL);
END $$;

-- ── WORKOUT 89: Torso pecho 1 ──
DO $$
DECLARE
  w_id_89 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_89, target_profile_id, 'Torso pecho 1', to_timestamp(1761930645), to_timestamp(1761934401), 30, 6534);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 1, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 2, 'normal', 45, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 3, 'normal', 45, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 4, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 5, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 6, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 7, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 8, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 10, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 11, 'normal', 41.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 12, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 13, 'normal', 37, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 14, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_89, target_exercise_id, 15, 'normal', 37, 8, NULL, NULL);
END $$;

-- ── WORKOUT 90: Pierna 1 ──
DO $$
DECLARE
  w_id_90 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_90, target_profile_id, 'Pierna 1', to_timestamp(1761843785), to_timestamp(1761847448), 30, 7506);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 1, 'normal', 96, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 2, 'normal', 103, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 3, 'normal', 103, 13, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 5, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 6, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 7, 'normal', 15, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 8, 'normal', 15, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 9, 'normal', 15, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 10, 'normal', 15, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 11, 'normal', 15, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 12, 'normal', 15, 5, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 13, 'normal', 19, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 14, 'normal', 19, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 15, 'normal', 19, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 16, 'normal', 19, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 17, 'normal', 19, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_90, target_exercise_id, 18, 'normal', 19, 10, NULL, NULL);
END $$;

-- ── WORKOUT 91: Torso espalda 1 ──
DO $$
DECLARE
  w_id_91 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_91, target_profile_id, 'Torso espalda 1', to_timestamp(1761670732), to_timestamp(1761674397), 30, 5437);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 1, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 3, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 4, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 5, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 6, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 7, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 9, 'normal', 38, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 10, 'normal', 38, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 11, 'normal', 33, 6, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 12, 'normal', 15, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 13, 'normal', 20, 10, NULL, NULL);

  -- Exercise: Bicep Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Bicep Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Dumbbell)', 'Bicep Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 14, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_91, target_exercise_id, 15, 'normal', 20, 8, NULL, NULL);
END $$;

-- ── WORKOUT 92: Torso pecho 2 ──
DO $$
DECLARE
  w_id_92 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_92, target_profile_id, 'Torso pecho 2', to_timestamp(1761586313), to_timestamp(1761588923), 30, 5132);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 1, 'normal', 42.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 2, 'normal', 52.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 3, 'normal', 52.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 4, 'normal', 52.5, 6, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 5, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 6, 'normal', 80, 8, NULL, NULL);

  -- Exercise: Shoulder Press (Machine Plates)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Shoulder Press (Machine Plates)') OR LOWER(name_es) = LOWER('Shoulder Press (Machine Plates)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Shoulder Press (Machine Plates)', 'Shoulder Press (Machine Plates)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 7, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 8, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 9, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 10, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 11, 'normal', 41.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_92, target_exercise_id, 12, 'normal', 41.5, 7, NULL, NULL);
END $$;

-- ── WORKOUT 93: Casa ──
DO $$
DECLARE
  w_id_93 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_93, target_profile_id, 'Casa', to_timestamp(1761471147), to_timestamp(1761473298), 30, 560);

  -- Exercise: Push Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Push Up') OR LOWER(name_es) = LOWER('Push Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Push Up', 'Push Up', 'reps_only', 'chest', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 1, 'normal', NULL, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Push Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Push Up') OR LOWER(name_es) = LOWER('Push Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Push Up', 'Push Up', 'reps_only', 'chest', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 3, 'normal', NULL, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Diamond Push Up
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Diamond Push Up') OR LOWER(name_es) = LOWER('Diamond Push Up') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Diamond Push Up', 'Diamond Push Up', 'reps_only', 'triceps', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 5, 'normal', NULL, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 6, 'normal', NULL, 9, NULL, NULL);

  -- Exercise: Bicep Curl (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Barbell)') OR LOWER(name_es) = LOWER('Bicep Curl (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Barbell)', 'Bicep Curl (Barbell)', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 7, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 8, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_93, target_exercise_id, 9, 'normal', 20, 8, NULL, NULL);
END $$;

-- ── WORKOUT 94: Pierna 1 ──
DO $$
DECLARE
  w_id_94 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_94, target_profile_id, 'Pierna 1', to_timestamp(1761406074), to_timestamp(1761409759), 30, 6787);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 1, 'normal', 90, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 2, 'normal', 90, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 3, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 4, 'normal', 19, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 5, 'normal', 19, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 6, 'normal', 19, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 7, 'normal', 19, 11, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 8, 'normal', 19, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 9, 'normal', 19, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 10, 'normal', 19, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 11, 'normal', 19, 11, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 12, 'normal', 65, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 13, 'normal', 65, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_94, target_exercise_id, 14, 'normal', 65, 11, NULL, NULL);
END $$;

-- ── WORKOUT 95: Torso espalda 1 ──
DO $$
DECLARE
  w_id_95 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_95, target_profile_id, 'Torso espalda 1', to_timestamp(1761235432), to_timestamp(1761238552), 30, 5867.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 1, 'normal', 50, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 2, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 3, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 4, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 5, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 6, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 7, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 8, 'normal', 34.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 9, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 10, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 11, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 12, 'normal', 35.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_95, target_exercise_id, 13, 'normal', 35.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 96: Torso pecho 2 ──
DO $$
DECLARE
  w_id_96 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_96, target_profile_id, 'Torso pecho 2', to_timestamp(1761149167), to_timestamp(1761151999), 30, 5172);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 1, 'normal', 40, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 2, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 4, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 5, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 6, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 7, 'normal', 32, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 8, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 9, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 10, 'normal', 80, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 11, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_96, target_exercise_id, 12, 'normal', 39, 10, NULL, NULL);
END $$;

-- ── WORKOUT 97: Rubiães ──
DO $$
DECLARE
  w_id_97 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_97, target_profile_id, 'Rubiães', to_timestamp(1760147016), to_timestamp(1760160233), 30, 0);

  -- Exercise: Walking
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Walking') OR LOWER(name_es) = LOWER('Walking') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Walking', 'Walking', 'distance_duration', 'cardio', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_97, target_exercise_id, 1, 'normal', NULL, NULL, 13200, 20000);
END $$;

-- ── WORKOUT 98: Ponte de lima ──
DO $$
DECLARE
  w_id_98 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_98, target_profile_id, 'Ponte de lima', to_timestamp(1759986999), to_timestamp(1760012218), 30, 0);

  -- Exercise: Walking
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Walking') OR LOWER(name_es) = LOWER('Walking') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Walking', 'Walking', 'distance_duration', 'cardio', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_98, target_exercise_id, 1, 'normal', NULL, NULL, 25200, 24000);
END $$;

-- ── WORKOUT 99: Tamel ──
DO $$
DECLARE
  w_id_99 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_99, target_profile_id, 'Tamel', to_timestamp(1759900563), to_timestamp(1759925775), 30, 0);

  -- Exercise: Walking
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Walking') OR LOWER(name_es) = LOWER('Walking') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Walking', 'Walking', 'distance_duration', 'cardio', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_99, target_exercise_id, 1, 'normal', NULL, NULL, 25200, 25000);
END $$;

-- ── WORKOUT 100: Rates ──
DO $$
DECLARE
  w_id_100 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_100, target_profile_id, 'Rates', to_timestamp(1759828584), to_timestamp(1759857402), 30, 0);

  -- Exercise: Walking
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Walking') OR LOWER(name_es) = LOWER('Walking') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Walking', 'Walking', 'distance_duration', 'cardio', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_100, target_exercise_id, 1, 'normal', NULL, NULL, 28800, 33000);
END $$;

