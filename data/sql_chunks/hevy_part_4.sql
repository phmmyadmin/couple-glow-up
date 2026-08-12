-- ============================================================================
-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP
-- Generated from data/hevy_workouts.json (236 workouts)
-- ============================================================================

-- ── WORKOUT 151: Idk ──
DO $$
DECLARE
  w_id_151 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_151, target_profile_id, 'Idk', to_timestamp(1752846991), to_timestamp(1752850979), 30, 6372);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 1, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 2, 'normal', 60, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 3, 'normal', 60, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 4, 'normal', 60, 4, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 5, 'normal', 47, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 6, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 7, 'normal', 30, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 8, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 9, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 10, 'normal', 61, 10, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 11, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 12, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 13, 'normal', 41.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_151, target_exercise_id, 14, 'normal', 41.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 152: Torso ──
DO $$
DECLARE
  w_id_152 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_152, target_profile_id, 'Torso', to_timestamp(1752682261), to_timestamp(1752686268), 30, 6264.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 1, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 2, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 3, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 4, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 5, 'normal', 35.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 6, 'normal', 35.5, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 7, 'normal', 35.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 8, 'normal', 35.5, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 9, 'normal', 35.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 10, 'normal', 35.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 11, 'normal', 33, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 12, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 13, 'normal', 54, 10, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 14, 'normal', 15, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 15, 'normal', 10, 13, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 16, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_152, target_exercise_id, 17, 'normal', 20, 9, NULL, NULL);
END $$;

-- ── WORKOUT 153: Pierna ──
DO $$
DECLARE
  w_id_153 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_153, target_profile_id, 'Pierna', to_timestamp(1752597485), to_timestamp(1752601548), 30, 13785.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 1, 'normal', 97.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 2, 'normal', 90, 12, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 3, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 5, 'normal', 160, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 6, 'normal', 160, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 7, 'normal', 160, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 8, 'normal', 100, 12, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 9, 'normal', 63.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 10, 'normal', 63.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 11, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 12, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_153, target_exercise_id, 13, 'normal', 61, 10, NULL, NULL);
END $$;

-- ── WORKOUT 154: Torso ──
DO $$
DECLARE
  w_id_154 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_154, target_profile_id, 'Torso', to_timestamp(1752509326), to_timestamp(1752513741), 30, 9297.5);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 1, 'normal', 42.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 2, 'normal', 47.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 3, 'normal', 47.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 4, 'normal', 47.5, 6, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 5, 'normal', NULL, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 6, 'normal', NULL, 9, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 7, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 8, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 9, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 10, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 11, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 12, 'normal', 32, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 13, 'normal', 32, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 14, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 15, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 16, 'normal', 80, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 17, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_154, target_exercise_id, 18, 'normal', 80, 10, NULL, NULL);
END $$;

-- ── WORKOUT 155: Idk ──
DO $$
DECLARE
  w_id_155 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_155, target_profile_id, 'Idk', to_timestamp(1752314756), to_timestamp(1752320148), 30, 7854);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 1, 'normal', 40, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 2, 'normal', 40, 12, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 3, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 4, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 5, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 6, 'normal', 47, 12, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 7, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 8, 'normal', 44, 9, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 9, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 10, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 11, 'normal', 63.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 12, 'normal', 63.5, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 13, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 14, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 15, 'normal', 41.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_155, target_exercise_id, 16, 'normal', 41.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 156: Torso ──
DO $$
DECLARE
  w_id_156 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_156, target_profile_id, 'Torso', to_timestamp(1752168961), to_timestamp(1752172089), 30, 5612.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 1, 'normal', 47.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 2, 'normal', 57.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 3, 'normal', 57.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 4, 'normal', 57.5, 5, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 5, 'normal', 80, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 6, 'normal', 80, 11, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 7, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 8, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 9, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 10, 'normal', 20, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 11, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_156, target_exercise_id, 12, 'normal', 39, 11, NULL, NULL);
END $$;

-- ── WORKOUT 157: Pierna ──
DO $$
DECLARE
  w_id_157 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_157, target_profile_id, 'Pierna', to_timestamp(1751991971), to_timestamp(1751995735), 30, 12340.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 1, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 2, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 5, 'normal', 63.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 6, 'normal', 63.5, 8, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 7, 'normal', 63.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 8, 'normal', 63.5, 12, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 9, 'normal', 100, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 10, 'normal', 130, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 11, 'normal', 130, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_157, target_exercise_id, 12, 'normal', 130, 10, NULL, NULL);
END $$;

-- ── WORKOUT 158: Torso ──
DO $$
DECLARE
  w_id_158 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_158, target_profile_id, 'Torso', to_timestamp(1751902236), to_timestamp(1751906395), 30, 6532);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 1, 'normal', 40, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 2, 'normal', 45, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 3, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 4, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 5, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 6, 'normal', NULL, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 7, 'normal', NULL, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 8, 'normal', 32, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 9, 'normal', 30, 6, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 10, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 11, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 12, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 13, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_158, target_exercise_id, 14, 'normal', 47, 10, NULL, NULL);
END $$;

-- ── WORKOUT 159: Divendres ──
DO $$
DECLARE
  w_id_159 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_159, target_profile_id, 'Divendres', to_timestamp(1751633476), to_timestamp(1751637723), 30, 8345);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 1, 'normal', 45, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 2, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 3, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 4, 'normal', 55, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 5, 'normal', 52, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 6, 'normal', 52, 9, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 7, 'normal', 100, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 8, 'normal', 100, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 9, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 10, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 11, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 12, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 13, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 14, 'normal', 46, 8, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 15, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_159, target_exercise_id, 16, 'normal', 40, 10, NULL, NULL);
END $$;

-- ── WORKOUT 160: Torso ──
DO $$
DECLARE
  w_id_160 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_160, target_profile_id, 'Torso', to_timestamp(1751470549), to_timestamp(1751474411), 30, 6386);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 1, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 2, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 3, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 4, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 5, 'normal', 32, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 6, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 7, 'normal', 40, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 8, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 9, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 10, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 12, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 13, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 14, 'normal', 39, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 15, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 16, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_160, target_exercise_id, 17, 'normal', 34.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 161: Pierna ──
DO $$
DECLARE
  w_id_161 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_161, target_profile_id, 'Pierna', to_timestamp(1751387380), to_timestamp(1751391805), 30, 12506);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 1, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 5, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 6, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 7, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 8, 'normal', 150, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 9, 'normal', 150, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 10, 'normal', 150, 8, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 11, 'normal', 35, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 12, 'normal', 35, 13, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 13, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_161, target_exercise_id, 14, 'normal', 40, 10, NULL, NULL);
END $$;

-- ── WORKOUT 162: Torso ──
DO $$
DECLARE
  w_id_162 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_162, target_profile_id, 'Torso', to_timestamp(1751302958), to_timestamp(1751307035), 30, 9093);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 1, 'normal', 50, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 2, 'normal', 50, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 3, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 4, 'normal', 68, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 5, 'normal', 68, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 6, 'normal', 68, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 7, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 8, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 9, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 10, 'normal', 80, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 11, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 12, 'normal', 37, 6, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 13, 'normal', 46, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 14, 'normal', 46, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 15, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 16, 'normal', 39, 10, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 17, 'normal', 15, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_162, target_exercise_id, 18, 'normal', 15, 14, NULL, NULL);
END $$;

-- ── WORKOUT 163: Torso ──
DO $$
DECLARE
  w_id_163 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_163, target_profile_id, 'Torso', to_timestamp(1751036188), to_timestamp(1751039348), 30, 4638.5);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 1, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 2, 'normal', 38, 11, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 3, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 4, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 5, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 6, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 7, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 8, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 9, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 10, 'normal', 37, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 11, 'normal', 34.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 12, 'normal', 20, 5, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 13, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_163, target_exercise_id, 14, 'normal', 39, 9, NULL, NULL);
END $$;

-- ── WORKOUT 164: Pierna ──
DO $$
DECLARE
  w_id_164 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_164, target_profile_id, 'Pierna', to_timestamp(1750958857), to_timestamp(1750963027), 30, 10890);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 1, 'normal', 95, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 2, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 3, 'normal', 95, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 4, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 5, 'normal', 165, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 6, 'normal', 155, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 7, 'normal', 145, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 8, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 9, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 10, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 11, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 12, 'normal', 30, 10, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 13, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_164, target_exercise_id, 14, 'normal', 50, 8, NULL, NULL);
END $$;

-- ── WORKOUT 165: Torso ──
DO $$
DECLARE
  w_id_165 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_165, target_profile_id, 'Torso', to_timestamp(1750867968), to_timestamp(1750872119), 30, 6653);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 1, 'normal', 42.5, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 2, 'normal', 52.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 3, 'normal', 52.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 4, 'normal', 52.5, 6, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 5, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 6, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 7, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 9, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 10, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 11, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 12, 'normal', 80, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 13, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_165, target_exercise_id, 14, 'normal', 44, 9, NULL, NULL);
END $$;

-- ── WORKOUT 166: Torso ──
DO $$
DECLARE
  w_id_166 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_166, target_profile_id, 'Torso', to_timestamp(1750352584), to_timestamp(1750356553), 30, 7611);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 1, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 2, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 3, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 4, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 5, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 6, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 7, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 8, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 9, 'normal', 39, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 10, 'normal', 39, 12, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 11, 'normal', 38, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 12, 'normal', 38, 9, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 13, 'normal', 32, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 14, 'normal', 32, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 15, 'normal', 44, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 16, 'normal', 39, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 17, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 18, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_166, target_exercise_id, 19, 'normal', 46, 3, NULL, NULL);
END $$;

-- ── WORKOUT 167: Torso 1 ──
DO $$
DECLARE
  w_id_167 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_167, target_profile_id, 'Torso 1', to_timestamp(1750181909), to_timestamp(1750185990), 30, 6632);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 1, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 2, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 4, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 5, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 6, 'normal', 55, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 8, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 9, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 10, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 12, 'normal', 47, 6, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 13, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_167, target_exercise_id, 14, 'normal', 41.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 168: Idk ──
DO $$
DECLARE
  w_id_168 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_168, target_profile_id, 'Idk', to_timestamp(1749983583), to_timestamp(1749989035), 30, 7186);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 1, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 2, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 3, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 4, 'normal', 0, 3, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 5, 'normal', 33, 6, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 6, 'normal', 0, 3, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 7, 'normal', 33, 6, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 8, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 9, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 11, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 12, 'normal', 44, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 13, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 14, 'normal', 46, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 15, 'normal', 45, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 16, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 17, 'normal', 40, 7, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 18, 'normal', 15, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 19, 'normal', 15, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_168, target_exercise_id, 20, 'normal', 15, 7, NULL, NULL);
END $$;

-- ── WORKOUT 169: Torso ──
DO $$
DECLARE
  w_id_169 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_169, target_profile_id, 'Torso', to_timestamp(1749900313), to_timestamp(1749904214), 30, 8002);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 1, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 4, 'normal', 47.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 5, 'normal', 55, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 6, 'normal', 55, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 7, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 8, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 9, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 10, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 12, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 13, 'normal', 39, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 14, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 15, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 16, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_169, target_exercise_id, 17, 'normal', 41.5, 9, NULL, NULL);
END $$;

-- ── WORKOUT 170: Pierna ──
DO $$
DECLARE
  w_id_170 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_170, target_profile_id, 'Pierna', to_timestamp(1749832415), to_timestamp(1749836327), 30, 11199);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 1, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 2, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 4, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Press Pierna Iso Lateral
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Pierna Iso Lateral') OR LOWER(name_es) = LOWER('Press Pierna Iso Lateral') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Pierna Iso Lateral', 'Press Pierna Iso Lateral', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 5, 'normal', 140, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 6, 'normal', 140, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 7, 'normal', 140, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 8, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 9, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 10, 'normal', 30, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 11, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 12, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_170, target_exercise_id, 13, 'normal', 54, 10, NULL, NULL);
END $$;

-- ── WORKOUT 171: Torso ──
DO $$
DECLARE
  w_id_171 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_171, target_profile_id, 'Torso', to_timestamp(1749663311), to_timestamp(1749666389), 30, 5456);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 1, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 2, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 3, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 4, 'normal', 49.5, 10, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 5, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 6, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 7, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 8, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 9, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 10, 'normal', 38, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 11, 'normal', 31, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 12, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 13, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 14, 'normal', 34.5, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_171, target_exercise_id, 15, 'normal', 20, 7, NULL, NULL);
END $$;

-- ── WORKOUT 172: Pierna ──
DO $$
DECLARE
  w_id_172 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_172, target_profile_id, 'Pierna', to_timestamp(1749489173), to_timestamp(1749493686), 30, 10390);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 1, 'normal', 120, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 2, 'normal', 120, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 3, 'normal', 120, 10, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 4, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 5, 'normal', 95, 7, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 6, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 7, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 8, 'normal', 35, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 9, 'normal', 35, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 10, 'normal', 35, 12, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 11, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 12, 'normal', 40, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_172, target_exercise_id, 13, 'normal', 30, 7, NULL, NULL);
END $$;

-- ── WORKOUT 173: Torso ──
DO $$
DECLARE
  w_id_173 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_173, target_profile_id, 'Torso', to_timestamp(1749378062), to_timestamp(1749382484), 30, 8089.5);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 1, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 4, 'normal', 45, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 5, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 6, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 8, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 9, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 10, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 11, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 12, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 13, 'normal', 72.5, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 14, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 15, 'normal', 41.5, 9, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 16, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_173, target_exercise_id, 17, 'normal', 39, 10, NULL, NULL);
END $$;

-- ── WORKOUT 174: Torso ──
DO $$
DECLARE
  w_id_174 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_174, target_profile_id, 'Torso', to_timestamp(1749219145), to_timestamp(1749222441), 30, 6294.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 1, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 2, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 3, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 4, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 5, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 6, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 7, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 8, 'normal', 46, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 9, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 10, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 11, 'normal', 40, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 12, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 13, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 14, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 15, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_174, target_exercise_id, 16, 'normal', 34.5, 7, NULL, NULL);
END $$;

-- ── WORKOUT 175: Pierna b ──
DO $$
DECLARE
  w_id_175 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_175, target_profile_id, 'Pierna b', to_timestamp(1749054893), to_timestamp(1749058945), 30, 7808.5);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 1, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 2, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 3, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Press Pierna Iso Lateral
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Pierna Iso Lateral') OR LOWER(name_es) = LOWER('Press Pierna Iso Lateral') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Pierna Iso Lateral', 'Press Pierna Iso Lateral', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 4, 'normal', 105, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 5, 'normal', 105, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 6, 'normal', 105, 10, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 7, 'normal', 42.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 8, 'normal', 42.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 9, 'normal', 42.5, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 10, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_175, target_exercise_id, 11, 'normal', 54, 8, NULL, NULL);
END $$;

-- ── WORKOUT 176: Torso ──
DO $$
DECLARE
  w_id_176 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_176, target_profile_id, 'Torso', to_timestamp(1748883232), to_timestamp(1748887131), 30, 7891.5);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 1, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 3, 'normal', 40, 25, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 4, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 5, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 6, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 7, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 8, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 9, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 10, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 11, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 12, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 13, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 14, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 15, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_176, target_exercise_id, 16, 'normal', 39, 10, NULL, NULL);
END $$;

-- ── WORKOUT 177: Pierna ──
DO $$
DECLARE
  w_id_177 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_177, target_profile_id, 'Pierna', to_timestamp(1748764591), to_timestamp(1748767790), 30, 11819);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 1, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 3, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 4, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 5, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 6, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 7, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 8, 'normal', 160, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 9, 'normal', 160, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 10, 'normal', 155, 10, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 11, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_177, target_exercise_id, 12, 'normal', 40, 8, NULL, NULL);
END $$;

-- ── WORKOUT 178: Torso 2 ──
DO $$
DECLARE
  w_id_178 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_178, target_profile_id, 'Torso 2', to_timestamp(1748682325), to_timestamp(1748686452), 30, 7244);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 1, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 2, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 3, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 4, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 5, 'normal', 47, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 6, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 7, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 8, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 9, 'normal', 40, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 10, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 11, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 12, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 13, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 14, 'normal', 34.5, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 15, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 16, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 17, 'normal', 33, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_178, target_exercise_id, 18, 'normal', 33, 9, NULL, NULL);
END $$;

-- ── WORKOUT 179: Torso 1 ──
DO $$
DECLARE
  w_id_179 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_179, target_profile_id, 'Torso 1', to_timestamp(1748278722), to_timestamp(1748281618), 30, 6087);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 1, 'normal', 40, 25, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 2, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 4, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 5, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 6, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 7, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 8, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 9, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 10, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 11, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_179, target_exercise_id, 12, 'normal', 41.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 180: Pierna 1 ──
DO $$
DECLARE
  w_id_180 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_180, target_profile_id, 'Pierna 1', to_timestamp(1747934826), to_timestamp(1747939004), 30, 13349.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 1, 'normal', 90, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 2, 'normal', 95, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 5, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 6, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 7, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 8, 'normal', 165, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 9, 'normal', 155, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 10, 'normal', 155, 9, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 11, 'normal', 42.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 12, 'normal', 42.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 13, 'normal', 42.5, 10, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 14, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_180, target_exercise_id, 15, 'normal', 46, 9, NULL, NULL);
END $$;

-- ── WORKOUT 181: Torso 1 ──
DO $$
DECLARE
  w_id_181 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_181, target_profile_id, 'Torso 1', to_timestamp(1747846438), to_timestamp(1747850398), 30, 7344.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 1, 'normal', 40, 25, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 2, 'normal', 52.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 3, 'normal', 52.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 4, 'normal', 52.5, 5, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 5, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 6, 'normal', 39, 11, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 7, 'normal', 80, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 8, 'normal', 80, 11, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 9, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 10, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 11, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 12, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 13, 'normal', 44, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 14, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 15, 'normal', 20, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_181, target_exercise_id, 16, 'normal', 20, 10, NULL, NULL);
END $$;

-- ── WORKOUT 182: Pierna ──
DO $$
DECLARE
  w_id_182 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_182, target_profile_id, 'Pierna', to_timestamp(1747565446), to_timestamp(1747569250), 30, 9062.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 1, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 5, 'normal', 41.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 6, 'normal', 41.5, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 7, 'normal', 59, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 8, 'normal', 59, 9, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 9, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 10, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 11, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 12, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_182, target_exercise_id, 13, 'normal', 61, 11, NULL, NULL);
END $$;

-- ── WORKOUT 183: Torso 1 ──
DO $$
DECLARE
  w_id_183 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_183, target_profile_id, 'Torso 1', to_timestamp(1747494496), to_timestamp(1747499373), 30, 8557);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 1, 'normal', 40, 23, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 4, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 5, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 6, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 7, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 8, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 9, 'normal', 37, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 10, 'normal', 37, 12, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 11, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 12, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 13, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 14, 'normal', 46, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 15, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 16, 'normal', 44, 10, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 17, 'normal', 54, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_183, target_exercise_id, 18, 'normal', 49.5, 6, NULL, NULL);
END $$;

-- ── WORKOUT 184: Torso 2 ──
DO $$
DECLARE
  w_id_184 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_184, target_profile_id, 'Torso 2', to_timestamp(1747400820), to_timestamp(1747404475), 30, 5964);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 1, 'normal', 52, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 2, 'normal', 52, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 3, 'normal', 52, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 4, 'normal', 52, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 5, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 6, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 7, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 9, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 11, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 12, 'normal', 33, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 13, 'normal', 33, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 14, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 15, 'normal', 37, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 16, 'normal', 34.5, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_184, target_exercise_id, 17, 'normal', 20, 7, NULL, NULL);
END $$;

-- ── WORKOUT 185: Pierna 1 ──
DO $$
DECLARE
  w_id_185 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_185, target_profile_id, 'Pierna 1', to_timestamp(1747241676), to_timestamp(1747245557), 30, 13014.5);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 1, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 5, 'normal', 20, 21, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 6, 'normal', 40, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 7, 'normal', 40, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 8, 'normal', 40, 12, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 9, 'normal', 56.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 10, 'normal', 59, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 11, 'normal', 59, 8, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 12, 'normal', 165, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 13, 'normal', 165, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_185, target_exercise_id, 14, 'normal', 165, 8, NULL, NULL);
END $$;

-- ── WORKOUT 186: Torso 1 ──
DO $$
DECLARE
  w_id_186 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_186, target_profile_id, 'Torso 1', to_timestamp(1747154713), to_timestamp(1747158951), 30, 7414);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 1, 'normal', 40, 23, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 4, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 5, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 6, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 7, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 8, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 9, 'normal', 37, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 10, 'normal', 39, 10, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 11, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 12, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 13, 'normal', 10, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 14, 'normal', 10, 11, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 15, 'normal', 41.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_186, target_exercise_id, 16, 'normal', 41.5, 9, NULL, NULL);
END $$;

-- ── WORKOUT 187: Entrenamiento por la tarde 💪 ──
DO $$
DECLARE
  w_id_187 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_187, target_profile_id, 'Entrenamiento por la tarde 💪', to_timestamp(1746871090), to_timestamp(1746875502), 30, 12790);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 1, 'normal', 150, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 2, 'normal', 150, 12, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 3, 'normal', 33, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 4, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 5, 'normal', 33, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 6, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 7, 'normal', 90, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 8, 'normal', 90, 11, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 9, 'normal', 90, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 10, 'normal', 90, 11, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 11, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 12, 'normal', 41.5, 10, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 13, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_187, target_exercise_id, 14, 'normal', 95, 10, NULL, NULL);
END $$;

-- ── WORKOUT 188: Excusa pa ducharme ──
DO $$
DECLARE
  w_id_188 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_188, target_profile_id, 'Excusa pa ducharme', to_timestamp(1746726399), to_timestamp(1746729609), 30, 5427);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 1, 'normal', 55, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 2, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 3, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 4, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 5, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 6, 'normal', 20, 9, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 7, 'normal', 47, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 8, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 9, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 10, 'normal', 37, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 11, 'normal', 37, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 12, 'normal', 37, 8, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 13, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_188, target_exercise_id, 14, 'normal', 47, 7, NULL, NULL);
END $$;

-- ── WORKOUT 189: Espalda de tor ──
DO $$
DECLARE
  w_id_189 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_189, target_profile_id, 'Espalda de tor', to_timestamp(1746636579), to_timestamp(1746641483), 30, 7205.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 1, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 2, 'normal', 52, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 3, 'normal', 52, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 4, 'normal', 52, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 5, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 7, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 8, 'normal', 35.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 9, 'normal', 35.5, 8, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 10, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 11, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 12, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 13, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 14, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 15, 'normal', 41.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 16, 'normal', 41.5, 7, NULL, NULL);

  -- Exercise: Bicep Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Machine)') OR LOWER(name_es) = LOWER('Bicep Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Machine)', 'Bicep Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 17, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 18, 'normal', 30, 8, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 19, 'normal', 12.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 20, 'normal', 10, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_189, target_exercise_id, 21, 'normal', 10, 6, NULL, NULL);
END $$;

-- ── WORKOUT 190: Pierna de bob ──
DO $$
DECLARE
  w_id_190 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_190, target_profile_id, 'Pierna de bob', to_timestamp(1746464696), to_timestamp(1746467830), 30, 14981);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 1, 'normal', 170, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 2, 'normal', 170, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 3, 'normal', 170, 10, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 4, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 5, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 6, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 7, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 8, 'normal', 61, 10, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 9, 'normal', 120, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 10, 'normal', 120, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 11, 'normal', 120, 11, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 12, 'normal', 90, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_190, target_exercise_id, 13, 'normal', 90, 11, NULL, NULL);
END $$;

-- ── WORKOUT 191: Pec, delt ant/med, triceps, abs ──
DO $$
DECLARE
  w_id_191 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_191, target_profile_id, 'Pec, delt ant/med, triceps, abs', to_timestamp(1746263989), to_timestamp(1746268410), 30, 8422);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 1, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 2, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 4, 'normal', 37, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 5, 'normal', 37, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 6, 'normal', 37, 8, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 7, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 8, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 9, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 10, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 11, 'normal', 30, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 12, 'normal', 27.5, 5, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 13, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 14, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 15, 'normal', 72.5, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 16, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 17, 'normal', 39, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 18, 'normal', 34.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_191, target_exercise_id, 19, 'normal', 37, 11, NULL, NULL);
END $$;

-- ── WORKOUT 192: Espalda de tor ──
DO $$
DECLARE
  w_id_192 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_192, target_profile_id, 'Espalda de tor', to_timestamp(1746091429), to_timestamp(1746095286), 30, 5647.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 1, 'normal', 49.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 2, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 3, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 4, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 5, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 6, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 7, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 8, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 9, 'normal', 33, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 10, 'normal', 33, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 11, 'normal', 33, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 12, 'normal', 33, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 13, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 14, 'normal', 41.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 15, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_192, target_exercise_id, 16, 'normal', 34.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 193: Pierna de bob ──
DO $$
DECLARE
  w_id_193 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_193, target_profile_id, 'Pierna de bob', to_timestamp(1745932476), to_timestamp(1745936405), 30, 16064);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 1, 'normal', 124, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 2, 'normal', 124, 12, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 3, 'normal', 150, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 4, 'normal', 150, 11, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 5, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 6, 'normal', 30, 13, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 7, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 8, 'normal', 90, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 9, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 10, 'normal', 117.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 11, 'normal', 117.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 12, 'normal', 117.5, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 13, 'normal', 56.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 14, 'normal', 56.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_193, target_exercise_id, 15, 'normal', 54, 9, NULL, NULL);
END $$;

-- ── WORKOUT 194: Pec, delt ant/med, triceps, abs ──
DO $$
DECLARE
  w_id_194 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_194, target_profile_id, 'Pec, delt ant/med, triceps, abs', to_timestamp(1745836577), to_timestamp(1745841979), 30, 10345);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 1, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 2, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 3, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 4, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 5, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 6, 'normal', 27.5, 10, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 7, 'normal', 34.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 8, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 9, 'normal', 34.5, 9, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 10, 'normal', 40, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 11, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 12, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 13, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 14, 'normal', 34.5, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 15, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 16, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 17, 'normal', 72.5, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 18, 'normal', 34.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 19, 'normal', 32, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 20, 'normal', 32, 11, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 21, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 22, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_194, target_exercise_id, 23, 'normal', 39, 10, NULL, NULL);
END $$;

-- ── WORKOUT 195: Pierna de bob ──
DO $$
DECLARE
  w_id_195 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_195, target_profile_id, 'Pierna de bob', to_timestamp(1745512204), to_timestamp(1745515923), 30, 16386);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 1, 'normal', 129, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 2, 'normal', 92, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 3, 'normal', 92, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 4, 'normal', 90, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 5, 'normal', 150, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 6, 'normal', 150, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 7, 'normal', 150, 10, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 8, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 9, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 10, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 11, 'normal', 54, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 12, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 13, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 14, 'normal', 115, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 15, 'normal', 115, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_195, target_exercise_id, 16, 'normal', 115, 10, NULL, NULL);
END $$;

-- ── WORKOUT 196: Espalda ──
DO $$
DECLARE
  w_id_196 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_196, target_profile_id, 'Espalda', to_timestamp(1745426855), to_timestamp(1745430115), 30, 5940.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 1, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 2, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 3, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 4, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 5, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 6, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 7, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 9, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 10, 'normal', 38, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 11, 'normal', 38, 6, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 12, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 13, 'normal', 49.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 14, 'normal', 49.5, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 15, 'normal', 20, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 16, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_196, target_exercise_id, 17, 'normal', 20, 8, NULL, NULL);
END $$;

-- ── WORKOUT 197: Pec, delt ant/med, triceps, abs ──
DO $$
DECLARE
  w_id_197 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_197, target_profile_id, 'Pec, delt ant/med, triceps, abs', to_timestamp(1745339943), to_timestamp(1745343717), 30, 8585.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 1, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 2, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 4, 'normal', 27.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 5, 'normal', 27.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 6, 'normal', 27.5, 7, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 7, 'normal', 40, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 8, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 9, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 10, 'normal', 34.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 11, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 12, 'normal', 34.5, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 13, 'normal', 77.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 14, 'normal', 77.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 15, 'normal', 77.5, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 16, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 17, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 18, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 19, 'normal', 34.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 20, 'normal', 34.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_197, target_exercise_id, 21, 'normal', 25, 9, NULL, NULL);
END $$;

-- ── WORKOUT 198: Pierna brazos ──
DO $$
DECLARE
  w_id_198 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_198, target_profile_id, 'Pierna brazos', to_timestamp(1744973147), to_timestamp(1744977626), 30, 10292);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 1, 'normal', 59, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 2, 'normal', 59, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 3, 'normal', 56.5, 8, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 4, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 5, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 7, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 8, 'normal', 115, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 9, 'normal', 115, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 10, 'normal', 115, 11, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 11, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 12, 'normal', 61, 10, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 13, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 14, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 15, 'normal', 20, 8, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 16, 'normal', 15, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 17, 'normal', 15, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 18, 'normal', 12.5, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 19, 'normal', 34.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_198, target_exercise_id, 20, 'normal', 34.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 199: Torso ──
DO $$
DECLARE
  w_id_199 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_199, target_profile_id, 'Torso', to_timestamp(1744880264), to_timestamp(1744884400), 30, 7719);

  -- Exercise: Press Banca (Máquina)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press Banca (Máquina)') OR LOWER(name_es) = LOWER('Press Banca (Máquina)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press Banca (Máquina)', 'Press Banca (Máquina)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 1, 'normal', 68, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 2, 'normal', 68, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 3, 'normal', 58, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 4, 'normal', 30, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 5, 'normal', 25, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 6, 'normal', 25, 7, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 7, 'normal', 47, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 8, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 9, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 10, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Butterfly (Pec Deck)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Butterfly (Pec Deck)') OR LOWER(name_es) = LOWER('Butterfly (Pec Deck)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Butterfly (Pec Deck)', 'Butterfly (Pec Deck)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 11, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 12, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 13, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 14, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 15, 'normal', 72.5, 10, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 16, 'normal', 34.5, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 17, 'normal', 34.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_199, target_exercise_id, 18, 'normal', 34.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 200: Pierna de bob ──
DO $$
DECLARE
  w_id_200 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_200, target_profile_id, 'Pierna de bob', to_timestamp(1744805411), to_timestamp(1744810271), 30, 18551);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 1, 'normal', 90, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 2, 'normal', 90, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 3, 'normal', 90, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 4, 'normal', 90, 12, NULL, NULL);

  -- Exercise: Hack Squat (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hack Squat (Machine)') OR LOWER(name_es) = LOWER('Hack Squat (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hack Squat (Machine)', 'Hack Squat (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 5, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 6, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 7, 'normal', 70, 8, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 8, 'normal', 130, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 9, 'normal', 130, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 10, 'normal', 130, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 11, 'normal', 56.5, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 12, 'normal', 56.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 13, 'normal', 56.5, 8, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 14, 'normal', 115, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 15, 'normal', 115, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 16, 'normal', 115, 10, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 17, 'normal', 42.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_200, target_exercise_id, 18, 'normal', 42.5, 8, NULL, NULL);
END $$;

