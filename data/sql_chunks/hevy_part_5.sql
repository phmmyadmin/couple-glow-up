-- ============================================================================
-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP
-- Generated from data/hevy_workouts.json (236 workouts)
-- ============================================================================

-- ── WORKOUT 201: Espalda de tor ──
DO $$
DECLARE
  w_id_201 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_201, target_profile_id, 'Espalda de tor', to_timestamp(1744652404), to_timestamp(1744657024), 30, 6768);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 1, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 2, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 3, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 4, 'normal', 49.5, 10, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 5, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 6, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 7, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 9, 'normal', 38, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 10, 'normal', 38, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 11, 'normal', 38, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 12, 'normal', 56.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 13, 'normal', 49.5, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 14, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 15, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 16, 'normal', 34.5, 10, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 17, 'normal', 15, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 18, 'normal', 15, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_201, target_exercise_id, 19, 'normal', 15, 10, NULL, NULL);
END $$;

-- ── WORKOUT 202: Pec, delt ant/med, triceps, abs ──
DO $$
DECLARE
  w_id_202 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_202, target_profile_id, 'Pec, delt ant/med, triceps, abs', to_timestamp(1744542606), to_timestamp(1744548430), 30, 10455.5);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 1, 'normal', 68, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 2, 'normal', 68, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 3, 'normal', 58, 9, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 4, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 5, 'normal', 30, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 6, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 7, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 9, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 10, 'normal', 37, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 11, 'normal', 37, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 12, 'normal', 37, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 13, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 14, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 15, 'normal', 80, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 16, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 17, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 18, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 19, 'normal', 34.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 20, 'normal', 34.5, 14, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 21, 'normal', 47, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 22, 'normal', 47, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_202, target_exercise_id, 23, 'normal', 47, 6, NULL, NULL);
END $$;

-- ── WORKOUT 203: Entreno matutino casero ──
DO $$
DECLARE
  w_id_203 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_203, target_profile_id, 'Entreno matutino casero', to_timestamp(1744442977), to_timestamp(1744445739), 30, 2800);

  -- Exercise: Romanian Deadlift (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Romanian Deadlift (Barbell)') OR LOWER(name_es) = LOWER('Romanian Deadlift (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Romanian Deadlift (Barbell)', 'Romanian Deadlift (Barbell)', 'weight_reps', 'hamstrings', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 1, 'normal', 15, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 2, 'normal', 25, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 3, 'normal', 25, 13, NULL, NULL);

  -- Exercise: Squat (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Barbell)') OR LOWER(name_es) = LOWER('Squat (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Barbell)', 'Squat (Barbell)', 'weight_reps', 'quadriceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 4, 'normal', 25, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 5, 'normal', 25, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 6, 'normal', 25, 15, NULL, NULL);

  -- Exercise: Bicep Curl (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Barbell)') OR LOWER(name_es) = LOWER('Bicep Curl (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Barbell)', 'Bicep Curl (Barbell)', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 7, 'normal', 15, 24, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 8, 'normal', 20, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_203, target_exercise_id, 9, 'normal', 20, 12, NULL, NULL);
END $$;

-- ── WORKOUT 204: Espalda de tor ──
DO $$
DECLARE
  w_id_204 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_204, target_profile_id, 'Espalda de tor', to_timestamp(1744301822), to_timestamp(1744306438), 30, 6553);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 1, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 2, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 3, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 4, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 5, 'normal', 47, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 6, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 7, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 8, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 9, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 10, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 11, 'normal', 35.5, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 12, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 13, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 14, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 15, 'normal', 41.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 16, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 17, 'normal', 34.5, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 18, 'normal', 10, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_204, target_exercise_id, 19, 'normal', 10, 8, NULL, NULL);
END $$;

-- ── WORKOUT 205: Pierna de bob ──
DO $$
DECLARE
  w_id_205 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_205, target_profile_id, 'Pierna de bob', to_timestamp(1744128479), to_timestamp(1744132681), 30, 16316);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 1, 'normal', 115, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 2, 'normal', 115, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 3, 'normal', 115, 10, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 4, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 5, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 6, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 7, 'normal', 165, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 8, 'normal', 155, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 9, 'normal', 155, 9, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 10, 'normal', 115, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 11, 'normal', 115, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 12, 'normal', 115, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 13, 'normal', 56.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 14, 'normal', 56.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_205, target_exercise_id, 15, 'normal', 54, 9, NULL, NULL);
END $$;

-- ── WORKOUT 206: Pec, delt ant/med, triceps ──
DO $$
DECLARE
  w_id_206 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_206, target_profile_id, 'Pec, delt ant/med, triceps', to_timestamp(1743935356), to_timestamp(1743941335), 30, 8965.5);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 1, 'normal', 68, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 2, 'normal', 68, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 3, 'normal', 68, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 4, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 5, 'normal', 32, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 6, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 7, 'dropset', 56.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 8, 'dropset', 49.5, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 9, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 10, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 11, 'normal', 37, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 12, 'normal', 37, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 13, 'normal', 37, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 14, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 15, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 16, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 17, 'normal', 20, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 18, 'normal', 10, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 19, 'normal', 10, 10, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 20, 'normal', 7.5, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 21, 'normal', 7.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 22, 'normal', 7.5, 11, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 23, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 24, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_206, target_exercise_id, 25, 'normal', 47, 7, NULL, NULL);
END $$;

-- ── WORKOUT 207: Express ──
DO $$
DECLARE
  w_id_207 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_207, target_profile_id, 'Express', to_timestamp(1743770514), to_timestamp(1743774066), 30, 11371.5);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 1, 'normal', 103, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 2, 'normal', 103, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 3, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 4, 'normal', 115, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 5, 'normal', 115, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 6, 'normal', 115, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 7, 'normal', 54, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 8, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 9, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 10, 'normal', 39, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 11, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 12, 'normal', 41.5, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 13, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 14, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_207, target_exercise_id, 15, 'normal', 32, 10, NULL, NULL);
END $$;

-- ── WORKOUT 208: Espalda de tor ──
DO $$
DECLARE
  w_id_208 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_208, target_profile_id, 'Espalda de tor', to_timestamp(1743694661), to_timestamp(1743699312), 30, 6402);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 1, 'normal', 52, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 2, 'normal', 52, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 3, 'normal', 52, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 4, 'normal', 52, 8, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 5, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 6, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 7, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 8, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 9, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 10, 'normal', 38, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 11, 'normal', 35.5, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 12, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 13, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 14, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 15, 'normal', 10, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 16, 'normal', 10, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 17, 'normal', 10, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 18, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 19, 'normal', 34.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_208, target_exercise_id, 20, 'normal', 34.5, 7, NULL, NULL);
END $$;

-- ── WORKOUT 209: Pierna de bob ──
DO $$
DECLARE
  w_id_209 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_209, target_profile_id, 'Pierna de bob', to_timestamp(1743516460), to_timestamp(1743521605), 30, 14652);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 1, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 2, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 3, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Press Pierna Iso Lateral
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Pierna Iso Lateral') OR LOWER(name_es) = LOWER('Press Pierna Iso Lateral') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Pierna Iso Lateral', 'Press Pierna Iso Lateral', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 4, 'normal', 100, 25, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 5, 'normal', 150, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 6, 'normal', 150, 11, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 7, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 10, 'normal', 103, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 11, 'normal', 103, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 12, 'normal', 103, 12, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 13, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_209, target_exercise_id, 14, 'normal', 54, 9, NULL, NULL);
END $$;

-- ── WORKOUT 210: Pec, delt ant/med, triceps, abs ──
DO $$
DECLARE
  w_id_210 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_210, target_profile_id, 'Pec, delt ant/med, triceps, abs', to_timestamp(1743259891), to_timestamp(1743264812), 30, 8487.5);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 1, 'normal', 68, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 2, 'normal', 73, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 3, 'dropset', 68, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 4, 'dropset', 48, 5, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 5, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 6, 'normal', 30, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 7, 'normal', 27.5, 8, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 8, 'normal', 54, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 9, 'normal', 49.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 10, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 11, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 12, 'normal', 34.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 13, 'normal', 32, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 14, 'normal', 80, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 15, 'normal', 72.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 16, 'normal', 72.5, 7, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 17, 'normal', 34.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 18, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 19, 'normal', 34.5, 7, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 20, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 21, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_210, target_exercise_id, 22, 'normal', 40, 7, NULL, NULL);
END $$;

-- ── WORKOUT 211: Pierna brazos ──
DO $$
DECLARE
  w_id_211 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_211, target_profile_id, 'Pierna brazos', to_timestamp(1743176098), to_timestamp(1743182342), 30, 17685);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 1, 'normal', 90, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 2, 'normal', 90, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 3, 'normal', 90, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 4, 'normal', 52, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 5, 'normal', 52, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 6, 'normal', 52, 10, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 7, 'normal', 120, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 8, 'normal', 120, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 9, 'normal', 120, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 10, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 11, 'normal', 37.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 12, 'normal', 35, 7, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 13, 'normal', 90, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 14, 'normal', 90, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 15, 'normal', 90, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 16, 'normal', 82.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 17, 'normal', 82.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 18, 'normal', 82.5, 10, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 19, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 20, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 21, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 22, 'normal', 7.5, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 23, 'normal', 7.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 24, 'normal', 7.5, 12, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 25, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 26, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_211, target_exercise_id, 27, 'normal', 54, 9, NULL, NULL);
END $$;

-- ── WORKOUT 212: Espalda de tor ──
DO $$
DECLARE
  w_id_212 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_212, target_profile_id, 'Espalda de tor', to_timestamp(1742998158), to_timestamp(1743003059), 30, 6916);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 1, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 2, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 3, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 4, 'normal', 35.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 5, 'normal', 38, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 6, 'normal', 38, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 7, 'normal', 38, 6, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 8, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 9, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 10, 'normal', 38, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 11, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 12, 'normal', 49.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 13, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 14, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 15, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 16, 'normal', 37.5, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 17, 'normal', 10, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 18, 'normal', 10, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 19, 'normal', 10, 7, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 20, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_212, target_exercise_id, 21, 'normal', 47, 9, NULL, NULL);
END $$;

-- ── WORKOUT 213: Pierna de bob ──
DO $$
DECLARE
  w_id_213 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_213, target_profile_id, 'Pierna de bob', to_timestamp(1742838033), to_timestamp(1742842521), 30, 11998);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 1, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 2, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 3, 'normal', 70, 9, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 4, 'normal', 100, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 5, 'normal', 100, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 6, 'normal', 100, 10, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 7, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 8, 'normal', 41.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 9, 'normal', 41.5, 7, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 10, 'normal', 90, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 11, 'normal', 85, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 12, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 13, 'normal', 90, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 14, 'normal', 87.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_213, target_exercise_id, 15, 'normal', 87.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 214: Pec, delt ant/med, triceps, abs ──
DO $$
DECLARE
  w_id_214 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_214, target_profile_id, 'Pec, delt ant/med, triceps, abs', to_timestamp(1742635898), to_timestamp(1742641253), 30, 10096.5);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 1, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 2, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 3, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Shoulder Press (Machine Plates)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Shoulder Press (Machine Plates)') OR LOWER(name_es) = LOWER('Shoulder Press (Machine Plates)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Shoulder Press (Machine Plates)', 'Shoulder Press (Machine Plates)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 5, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 6, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 7, 'normal', 82.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 8, 'normal', 82.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 9, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 10, 'normal', 37, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 11, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 12, 'normal', 34.5, 9, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 13, 'normal', 68, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 14, 'normal', 48, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 15, 'normal', 48, 6, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 16, 'normal', 34.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 17, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 18, 'normal', 34.5, 9, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 19, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 20, 'normal', 47, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 21, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 22, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_214, target_exercise_id, 23, 'normal', 39, 8, NULL, NULL);
END $$;

-- ── WORKOUT 215: Pierna brazos ──
DO $$
DECLARE
  w_id_215 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_215, target_profile_id, 'Pierna brazos', to_timestamp(1742572569), to_timestamp(1742578515), 30, 18104);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 1, 'normal', 90, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 2, 'normal', 90, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 3, 'normal', 90, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 4, 'normal', 90, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 5, 'normal', 90, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 6, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 7, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 8, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 9, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 10, 'normal', 87.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 11, 'normal', 87.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 12, 'normal', 87.5, 10, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 13, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 14, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 15, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 16, 'normal', 41.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 17, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 18, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Shrug (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Shrug (Machine)') OR LOWER(name_es) = LOWER('Shrug (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Shrug (Machine)', 'Shrug (Machine)', 'weight_reps', 'traps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 19, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 20, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 21, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 22, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 23, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 24, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 25, 'normal', 10, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 26, 'normal', 10, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 27, 'normal', 10, 7, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 28, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 29, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 30, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 31, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 32, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_215, target_exercise_id, 33, 'normal', 32, 8, NULL, NULL);
END $$;

-- ── WORKOUT 216: Crotolamo ──
DO $$
DECLARE
  w_id_216 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_216, target_profile_id, 'Crotolamo', to_timestamp(1742406895), to_timestamp(1742411042), 30, 6498.5);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 1, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 2, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 3, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 4, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 5, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 7, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 9, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 10, 'normal', 38, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 11, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 12, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 13, 'normal', 37, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 14, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 15, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 16, 'normal', 49.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_216, target_exercise_id, 17, 'normal', 49.5, 6, NULL, NULL);
END $$;

-- ── WORKOUT 217: Pierna de bob ──
DO $$
DECLARE
  w_id_217 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_217, target_profile_id, 'Pierna de bob', to_timestamp(1742318194), to_timestamp(1742322334), 30, 15041);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 1, 'normal', 124, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 2, 'normal', 124, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 3, 'normal', 124, 10, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 4, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 5, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 6, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 7, 'normal', 150, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 8, 'normal', 150, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 9, 'normal', 150, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 10, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 11, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 12, 'normal', 49.5, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 13, 'normal', 82, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 14, 'normal', 82, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_217, target_exercise_id, 15, 'normal', 82, 9, NULL, NULL);
END $$;

-- ── WORKOUT 218: Pecho delt ant/med triceps abs ──
DO $$
DECLARE
  w_id_218 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_218, target_profile_id, 'Pecho delt ant/med triceps abs', to_timestamp(1742122457), to_timestamp(1742128236), 30, 10874);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 1, 'normal', 68, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 2, 'normal', 68, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 3, 'normal', 58, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 4, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 5, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 6, 'normal', 80, 11, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 7, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 8, 'normal', 30, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 9, 'normal', 27.5, 7, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 10, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 12, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 13, 'normal', 34.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 14, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 15, 'normal', 34.5, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 16, 'normal', 41.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 17, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 18, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 19, 'normal', 34.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 20, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 21, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 22, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 23, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_218, target_exercise_id, 24, 'normal', 47, 7, NULL, NULL);
END $$;

-- ── WORKOUT 219: . ──
DO $$
DECLARE
  w_id_219 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_219, target_profile_id, '.', to_timestamp(1742033941), to_timestamp(1742040237), 30, 17023);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 1, 'normal', 117, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 2, 'normal', 124, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 3, 'normal', 124, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 4, 'normal', 82.5, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 5, 'normal', 90, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 6, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 7, 'normal', 41.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 8, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 9, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 10, 'normal', 117.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 11, 'normal', 117.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 12, 'normal', 117.5, 8, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 13, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 14, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 15, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 16, 'normal', 35, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 17, 'normal', 35, 12, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 18, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 19, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 20, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_219, target_exercise_id, 21, 'normal', 40, 7, NULL, NULL);
END $$;

-- ── WORKOUT 220: Basurillas ──
DO $$
DECLARE
  w_id_220 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_220, target_profile_id, 'Basurillas', to_timestamp(1741800587), to_timestamp(1741805255), 30, 9167);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 1, 'normal', 32, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 2, 'normal', 32, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 3, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 4, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 5, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 6, 'normal', 37, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 7, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 8, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 9, 'normal', 37, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 10, 'normal', 80, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 11, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 12, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Shrug (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Shrug (Machine)') OR LOWER(name_es) = LOWER('Shrug (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Shrug (Machine)', 'Shrug (Machine)', 'weight_reps', 'traps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 13, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 14, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 15, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 16, 'normal', 7.5, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 17, 'normal', 7.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 18, 'normal', 7.5, 13, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 19, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 20, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 21, 'normal', 20, 8, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 22, 'normal', 32, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 23, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_220, target_exercise_id, 24, 'normal', 32, 7, NULL, NULL);
END $$;

-- ── WORKOUT 221: Pierna de bob ──
DO $$
DECLARE
  w_id_221 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_221, target_profile_id, 'Pierna de bob', to_timestamp(1741697624), to_timestamp(1741701386), 30, 10061.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 1, 'normal', 85, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 2, 'normal', 82.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 3, 'normal', 82.5, 10, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 4, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 5, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 6, 'normal', 30, 11, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 7, 'normal', 175, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 8, 'normal', 105, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 9, 'normal', 135, 11, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 10, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_221, target_exercise_id, 11, 'normal', 39, 9, NULL, NULL);
END $$;

-- ── WORKOUT 222: Espalda de tor ──
DO $$
DECLARE
  w_id_222 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_222, target_profile_id, 'Espalda de tor', to_timestamp(1741626173), to_timestamp(1741630800), 30, 6063);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 1, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 2, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 3, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 5, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 6, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 7, 'normal', 42.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 8, 'normal', 42.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 9, 'normal', 42.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 10, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 11, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 12, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 13, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 14, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 15, 'normal', 37, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 16, 'normal', 37, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 17, 'normal', 7.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 18, 'normal', 7.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_222, target_exercise_id, 19, 'normal', 7.5, 6, NULL, NULL);
END $$;

-- ── WORKOUT 223: Analytics de pierna y pecho ──
DO $$
DECLARE
  w_id_223 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_223, target_profile_id, 'Analytics de pierna y pecho', to_timestamp(1741447104), to_timestamp(1741454625), 30, 17275);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 1, 'normal', 85, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 2, 'normal', 85, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 3, 'normal', 85, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 4, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 5, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 6, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 7, 'normal', 54, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 8, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 9, 'normal', 54, 11, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 10, 'normal', 110, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 11, 'normal', 110, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 12, 'normal', 110, 11, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 13, 'normal', 62, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 14, 'normal', 62, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 15, 'normal', 62, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 16, 'normal', 77.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 17, 'normal', 77.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 18, 'normal', 77.5, 9, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 19, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 20, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 21, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 22, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 23, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 24, 'normal', 39, 10, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 25, 'normal', 47, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_223, target_exercise_id, 26, 'normal', 47, 7, NULL, NULL);
END $$;

-- ── WORKOUT 224: Hombro brazos ──
DO $$
DECLARE
  w_id_224 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_224, target_profile_id, 'Hombro brazos', to_timestamp(1741280324), to_timestamp(1741285152), 30, 8705);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 1, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 2, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 3, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 4, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 5, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 6, 'normal', 34.5, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 7, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 8, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 9, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 10, 'normal', 77.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 11, 'normal', 77.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 12, 'normal', 77.5, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 13, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 14, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 15, 'normal', 34.5, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 16, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 17, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 18, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 19, 'normal', 27.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 20, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_224, target_exercise_id, 21, 'normal', 32.5, 9, NULL, NULL);
END $$;

-- ── WORKOUT 225: Espalda de tor ──
DO $$
DECLARE
  w_id_225 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_225, target_profile_id, 'Espalda de tor', to_timestamp(1741194574), to_timestamp(1741199689), 30, 6179);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 1, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 2, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 3, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 4, 'normal', 49.5, 11, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 5, 'normal', 61, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 6, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 7, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 8, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 9, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 10, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 12, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 13, 'normal', 7.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 14, 'normal', 7.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 15, 'normal', 7.5, 11, NULL, NULL);

  -- Exercise: Behind the Back Wrist Curl (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Behind the Back Wrist Curl (Barbell)') OR LOWER(name_es) = LOWER('Behind the Back Wrist Curl (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Behind the Back Wrist Curl (Barbell)', 'Behind the Back Wrist Curl (Barbell)', 'weight_reps', 'forearms', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 16, 'normal', 0, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 17, 'normal', 0, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 18, 'normal', 0, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 19, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 20, 'normal', 34.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_225, target_exercise_id, 21, 'normal', 32, 7, NULL, NULL);
END $$;

-- ── WORKOUT 226: Pierna de bob ──
DO $$
DECLARE
  w_id_226 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_226, target_profile_id, 'Pierna de bob', to_timestamp(1741022486), to_timestamp(1741026160), 30, 12951.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 1, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 2, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 3, 'normal', 82.5, 11, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 4, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 5, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 6, 'normal', 60, 11, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 7, 'normal', 175, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 8, 'normal', 175, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 9, 'normal', 175, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 10, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 11, 'normal', 52, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 12, 'normal', 52, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 13, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 14, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_226, target_exercise_id, 15, 'normal', 37, 6, NULL, NULL);
END $$;

-- ── WORKOUT 227: Pechito triceps ──
DO $$
DECLARE
  w_id_227 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_227, target_profile_id, 'Pechito triceps', to_timestamp(1740914698), to_timestamp(1740920029), 30, 9114);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 1, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 2, 'normal', 52, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 3, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 4, 'normal', 68, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 5, 'normal', 63, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 6, 'normal', 58, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 7, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 8, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 9, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 10, 'normal', 72.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 11, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 12, 'normal', 70, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 13, 'normal', 34.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 14, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 15, 'normal', 34.5, 8, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 16, 'normal', 27.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 17, 'normal', 32, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 18, 'normal', 32, 9, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 19, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 20, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_227, target_exercise_id, 21, 'normal', 47, 7, NULL, NULL);
END $$;

-- ── WORKOUT 228: Rey del phonk ──
DO $$
DECLARE
  w_id_228 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_228, target_profile_id, 'Rey del phonk', to_timestamp(1740754637), to_timestamp(1740760681), 30, 8999);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 1, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 2, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 3, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 4, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 5, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 6, 'normal', 34.5, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 7, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 10, 'normal', 75, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 11, 'normal', 77.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 12, 'normal', 75, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 13, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 14, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 15, 'normal', 37, 8, NULL, NULL);

  -- Exercise: Behind the Back Wrist Curl (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Behind the Back Wrist Curl (Barbell)') OR LOWER(name_es) = LOWER('Behind the Back Wrist Curl (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Behind the Back Wrist Curl (Barbell)', 'Behind the Back Wrist Curl (Barbell)', 'weight_reps', 'forearms', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 16, 'normal', 0, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 17, 'normal', 0, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 18, 'normal', 0, 11, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 19, 'normal', 39, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 20, 'normal', 41.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 21, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 22, 'normal', 7.5, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 23, 'normal', 7.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 24, 'normal', 7.5, 12, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 25, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 26, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_228, target_exercise_id, 27, 'normal', 20, 6, NULL, NULL);
END $$;

-- ── WORKOUT 229: Barbie leg day ──
DO $$
DECLARE
  w_id_229 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_229, target_profile_id, 'Barbie leg day', to_timestamp(1740675835), to_timestamp(1740679598), 30, 10373);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 1, 'normal', 85, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 2, 'normal', 85, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 3, 'normal', 80, 8, NULL, NULL);

  -- Exercise: Press Pierna Iso Lateral
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Pierna Iso Lateral') OR LOWER(name_es) = LOWER('Press Pierna Iso Lateral') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Pierna Iso Lateral', 'Press Pierna Iso Lateral', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 5, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 6, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 7, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 8, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 9, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 10, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 11, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 12, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 13, 'normal', 105, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 14, 'normal', 105, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_229, target_exercise_id, 15, 'normal', 105, 10, NULL, NULL);
END $$;

-- ── WORKOUT 230: Duele ──
DO $$
DECLARE
  w_id_230 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_230, target_profile_id, 'Duele', to_timestamp(1740504842), to_timestamp(1740510443), 30, 7463.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 1, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 2, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 3, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 4, 'normal', 60, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 5, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 6, 'normal', 70, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 7, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 8, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 9, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 10, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 11, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 12, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 13, 'normal', 37, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 14, 'normal', 34.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 15, 'normal', 32, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 16, 'normal', 20, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 17, 'normal', 27.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_230, target_exercise_id, 18, 'normal', 27.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 231: Pierna de bob ──
DO $$
DECLARE
  w_id_231 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_231, target_profile_id, 'Pierna de bob', to_timestamp(1740415794), to_timestamp(1740420001), 30, 13557.5);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 1, 'normal', 170, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 2, 'normal', 170, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 3, 'normal', 150, 12, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 4, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 5, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 7, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 8, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 9, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 10, 'normal', 72.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 11, 'normal', 77.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 12, 'normal', 75, 7, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 13, 'normal', 95, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 14, 'normal', 107.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_231, target_exercise_id, 15, 'normal', 107.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 232: Solo cuento el peso de la máquina ──
DO $$
DECLARE
  w_id_232 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_232, target_profile_id, 'Solo cuento el peso de la máquina', to_timestamp(1740311055), to_timestamp(1740316327), 30, 8563);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 1, 'normal', 47, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 2, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 3, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 4, 'normal', 58, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 5, 'normal', 63, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 6, 'normal', 63, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 7, 'normal', 75, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 8, 'normal', 77.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 9, 'normal', 77.5, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 10, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 11, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 12, 'normal', 41.5, 7, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 13, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 14, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 15, 'normal', 47, 6, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 16, 'normal', 10, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 17, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 18, 'normal', 20, 6, NULL, NULL);

  -- Exercise: Abdominal Crunch Hammer Strength
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Hammer Strength') OR LOWER(name_es) = LOWER('Abdominal Crunch Hammer Strength') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Hammer Strength', 'Abdominal Crunch Hammer Strength', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 19, 'normal', 15, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 20, 'normal', 10, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_232, target_exercise_id, 21, 'normal', 10, 10, NULL, NULL);
END $$;

-- ── WORKOUT 233: Analiticas de pierna hombrito y brazito ──
DO $$
DECLARE
  w_id_233 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_233, target_profile_id, 'Analiticas de pierna hombrito y brazito', to_timestamp(1740069840), to_timestamp(1740075502), 30, 13613.7);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 1, 'normal', 72.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 2, 'normal', 75, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 3, 'normal', 75, 8, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 4, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 5, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 6, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 7, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 8, 'normal', 56.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 9, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Single Leg Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Single Leg Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Single Leg Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Single Leg Standing Calf Raise (Machine)', 'Single Leg Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 10, 'normal', 105, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 11, 'normal', 105, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 12, 'normal', 105, 9, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 13, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 14, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 15, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Shoulder Press (Machine Plates)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Shoulder Press (Machine Plates)') OR LOWER(name_es) = LOWER('Shoulder Press (Machine Plates)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Shoulder Press (Machine Plates)', 'Shoulder Press (Machine Plates)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 16, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 17, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 18, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 19, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 20, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 21, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 22, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 23, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 24, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 25, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 26, 'normal', 34.8, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_233, target_exercise_id, 27, 'normal', 34.8, 9, NULL, NULL);
END $$;

-- ── WORKOUT 234: Espalda de tor ──
DO $$
DECLARE
  w_id_234 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_234, target_profile_id, 'Espalda de tor', to_timestamp(1739985747), to_timestamp(1739990631), 30, 5361);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 1, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 2, 'normal', 56.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 3, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 4, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 5, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 6, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 7, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 9, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 10, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 11, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 12, 'normal', 45, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 13, 'normal', 45, 9, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 14, 'normal', 0, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 15, 'dropset', 5, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 16, 'normal', 3, 6, NULL, NULL);

  -- Exercise: Abdominal Crunch Hammer Strength
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Hammer Strength') OR LOWER(name_es) = LOWER('Abdominal Crunch Hammer Strength') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Hammer Strength', 'Abdominal Crunch Hammer Strength', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 17, 'normal', 0, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 18, 'normal', 10, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_234, target_exercise_id, 19, 'normal', 10, 10, NULL, NULL);
END $$;

-- ── WORKOUT 235: Pierna de bob ──
DO $$
DECLARE
  w_id_235 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_235, target_profile_id, 'Pierna de bob', to_timestamp(1739790000), to_timestamp(1739794232), 30, 13403.5);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 1, 'normal', 60, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 2, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 3, 'normal', 70, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 4, 'normal', 140, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 5, 'normal', 150, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 6, 'normal', 150, 9, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 7, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 8, 'normal', 75, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 9, 'normal', 72.5, 9, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 10, 'normal', 105, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 11, 'normal', 115, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 12, 'normal', 107.5, 10, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 13, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 14, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_235, target_exercise_id, 15, 'normal', 39, 8, NULL, NULL);
END $$;

-- ── WORKOUT 236: Pechito y triceps ──
DO $$
DECLARE
  w_id_236 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_236, target_profile_id, 'Pechito y triceps', to_timestamp(1739703600), to_timestamp(1739708205), 30, 7949);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 1, 'normal', 58, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 2, 'normal', 68, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 3, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 4, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 5, 'normal', 49.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 6, 'normal', 49.5, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 7, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 8, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 9, 'normal', 41.5, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 10, 'normal', 70, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 11, 'normal', 75, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 12, 'normal', 75, 11, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 13, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 14, 'normal', 45, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_236, target_exercise_id, 15, 'normal', 45, 7, NULL, NULL);
END $$;
