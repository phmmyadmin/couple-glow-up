-- ============================================================================
-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP
-- Generated from data/hevy_workouts.json (236 workouts)
-- ============================================================================

-- ── WORKOUT 101: Porto ──
DO $$
DECLARE
  w_id_101 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_101, target_profile_id, 'Porto', to_timestamp(1759727724), to_timestamp(1759749360), 30, 0);

  -- Exercise: Walking
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Walking') OR LOWER(name_es) = LOWER('Walking') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Walking', 'Walking', 'distance_duration', 'cardio', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_101, target_exercise_id, 1, 'normal', NULL, NULL, 21600, 21000);
END $$;

-- ── WORKOUT 102: Torso pecho 2 ──
DO $$
DECLARE
  w_id_102 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_102, target_profile_id, 'Torso pecho 2', to_timestamp(1759336709), to_timestamp(1759339815), 30, 5196);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 1, 'normal', 47.5, 21, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 2, 'normal', 65, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 3, 'normal', 65, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 4, 'normal', 65, 2, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 5, 'normal', 32, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 6, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 7, 'normal', 47, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 8, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 9, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 10, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 11, 'normal', NULL, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 12, 'normal', 46, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_102, target_exercise_id, 13, 'normal', 46, 10, NULL, NULL);
END $$;

-- ── WORKOUT 103: Pierna 1 ──
DO $$
DECLARE
  w_id_103 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_103, target_profile_id, 'Pierna 1', to_timestamp(1759249402), to_timestamp(1759252616), 30, 12040);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 1, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 2, 'normal', 95, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 3, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 4, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 5, 'normal', 125, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 6, 'normal', 125, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 7, 'normal', 115, 10, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 8, 'normal', 110, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 9, 'normal', 110, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 10, 'normal', 100, 6, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 11, 'normal', 75, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_103, target_exercise_id, 12, 'normal', 75, 10, NULL, NULL);
END $$;

-- ── WORKOUT 104: Torso espalda 1 ──
DO $$
DECLARE
  w_id_104 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_104, target_profile_id, 'Torso espalda 1', to_timestamp(1759164063), to_timestamp(1759168052), 30, 6472);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 1, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 2, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 3, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 4, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 5, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 6, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 7, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 8, 'normal', 38, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 9, 'normal', 38, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 10, 'normal', 50, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 11, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 12, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Three Angle Biceps
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Three Angle Biceps') OR LOWER(name_es) = LOWER('Three Angle Biceps') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Three Angle Biceps', 'Three Angle Biceps', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 13, 'normal', 20, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_104, target_exercise_id, 14, 'normal', 20, 10, NULL, NULL);
END $$;

-- ── WORKOUT 105: Torso pecho 1 ──
DO $$
DECLARE
  w_id_105 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_105, target_profile_id, 'Torso pecho 1', to_timestamp(1758969131), to_timestamp(1758973565), 30, 5243);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 1, 'normal', 42.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 2, 'normal', 52.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 3, 'normal', 52.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 4, 'normal', 52.5, 4, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 5, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 6, 'normal', 54, 11, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 7, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 8, 'normal', 80, 11, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 9, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_105, target_exercise_id, 10, 'normal', 41.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 106: Torso espalda 1 ──
DO $$
DECLARE
  w_id_106 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_106, target_profile_id, 'Torso espalda 1', to_timestamp(1758819057), to_timestamp(1758823078), 30, 5983);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 1, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 2, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 3, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 4, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 5, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 6, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 7, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 8, 'normal', 54, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 10, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 11, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 12, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 13, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_106, target_exercise_id, 14, 'normal', 37, 8, NULL, NULL);
END $$;

-- ── WORKOUT 107: Pierna 1 ──
DO $$
DECLARE
  w_id_107 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_107, target_profile_id, 'Pierna 1', to_timestamp(1758731451), to_timestamp(1758735061), 30, 8369);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 1, 'normal', 100, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 2, 'normal', 100, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 3, 'normal', 100, 9, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 4, 'normal', 130, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 5, 'normal', 130, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 6, 'normal', 100, 12, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 7, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 8, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_107, target_exercise_id, 9, 'normal', 54, 9, NULL, NULL);
END $$;

-- ── WORKOUT 108: Torso pecho 2 ──
DO $$
DECLARE
  w_id_108 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_108, target_profile_id, 'Torso pecho 2', to_timestamp(1758629160), to_timestamp(1758632265), 30, 5183);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 1, 'normal', 45, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 2, 'normal', 62.5, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 3, 'normal', 62.5, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 4, 'normal', 62.5, 4, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 5, 'normal', 49.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 6, 'normal', 49.5, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 7, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 8, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 9, 'normal', 85, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 10, 'normal', 80, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 11, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_108, target_exercise_id, 12, 'normal', 41.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 109: Pierna + espalda ──
DO $$
DECLARE
  w_id_109 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_109, target_profile_id, 'Pierna + espalda', to_timestamp(1758359764), to_timestamp(1758362679), 30, 6003);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 1, 'normal', 90, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 2, 'normal', 90, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 3, 'normal', 90, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 4, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 5, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 6, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 7, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 8, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 9, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_109, target_exercise_id, 10, 'normal', 20, 8, NULL, NULL);
END $$;

-- ── WORKOUT 110: Torso pecho 1 ──
DO $$
DECLARE
  w_id_110 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_110, target_profile_id, 'Torso pecho 1', to_timestamp(1758292043), to_timestamp(1758296005), 30, 5174);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 1, 'normal', 40, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 2, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 3, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 4, 'normal', 50, 5, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 5, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 6, 'normal', 47, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 7, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 8, 'normal', 80, 11, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 9, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 10, 'normal', 30, 10, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 11, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_110, target_exercise_id, 12, 'normal', 20, 7, NULL, NULL);
END $$;

-- ── WORKOUT 111: Torso espalda 1 ──
DO $$
DECLARE
  w_id_111 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_111, target_profile_id, 'Torso espalda 1', to_timestamp(1758220373), to_timestamp(1758223310), 30, 5661);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 1, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 2, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 3, 'normal', 47, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 4, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 5, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 6, 'normal', 61, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 7, 'normal', 61, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 8, 'normal', 38, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 9, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 10, 'normal', 38, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 11, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 12, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_111, target_exercise_id, 13, 'normal', 39, 7, NULL, NULL);
END $$;

-- ── WORKOUT 112: Pierna 1 ──
DO $$
DECLARE
  w_id_112 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_112, target_profile_id, 'Pierna 1', to_timestamp(1758128691), to_timestamp(1758131301), 30, 7201);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 1, 'normal', 120, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 2, 'normal', 120, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 3, 'normal', 120, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 4, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 5, 'normal', 61, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 6, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 7, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_112, target_exercise_id, 8, 'normal', 61, 20, NULL, NULL);
END $$;

-- ── WORKOUT 113: Torso pecho 2 ──
DO $$
DECLARE
  w_id_113 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_113, target_profile_id, 'Torso pecho 2', to_timestamp(1757953597), to_timestamp(1757955544), 30, 3190);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_113, target_exercise_id, 1, 'normal', 42.5, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_113, target_exercise_id, 2, 'normal', 60, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_113, target_exercise_id, 3, 'normal', 60, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_113, target_exercise_id, 4, 'normal', 60, 5, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_113, target_exercise_id, 5, 'normal', 60, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_113, target_exercise_id, 6, 'normal', 60, 12, NULL, NULL);
END $$;

-- ── WORKOUT 114: Idk ──
DO $$
DECLARE
  w_id_114 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_114, target_profile_id, 'Idk', to_timestamp(1757669328), to_timestamp(1757672309), 30, 7806.5);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 1, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 2, 'normal', 80, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 3, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 4, 'normal', 63.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 5, 'normal', 63.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 6, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 7, 'normal', 75, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 8, 'normal', 75, 12, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 9, 'normal', 59, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 10, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_114, target_exercise_id, 11, 'normal', 54, 7, NULL, NULL);
END $$;

-- ── WORKOUT 115: Torso pecho 1 ──
DO $$
DECLARE
  w_id_115 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_115, target_profile_id, 'Torso pecho 1', to_timestamp(1757586541), to_timestamp(1757590444), 30, 6141.5);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 1, 'normal', 47.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 2, 'normal', 57.5, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 3, 'normal', 57.5, 3, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 4, 'normal', 57.5, 3, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 5, 'normal', NULL, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 6, 'normal', NULL, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 7, 'normal', NULL, 5, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 8, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 9, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 10, 'normal', 47, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 11, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 12, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 13, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_115, target_exercise_id, 14, 'normal', 41.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 116: Torso espalda 1 ──
DO $$
DECLARE
  w_id_116 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_116, target_profile_id, 'Torso espalda 1', to_timestamp(1757493654), to_timestamp(1757496576), 30, 5329.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 1, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 2, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 3, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 4, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 5, 'normal', 56.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 6, 'normal', 56.5, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 7, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 8, 'normal', 38, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 9, 'normal', 38, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 10, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 11, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_116, target_exercise_id, 12, 'normal', 39, 7, NULL, NULL);
END $$;

-- ── WORKOUT 117: Pierna 1 ──
DO $$
DECLARE
  w_id_117 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_117, target_profile_id, 'Pierna 1', to_timestamp(1757407058), to_timestamp(1757410736), 30, 12224);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 1, 'normal', 100, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 2, 'normal', 100, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 3, 'normal', 100, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 4, 'normal', 100, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 5, 'normal', 100, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 6, 'normal', 100, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 7, 'normal', 120, 9, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 8, 'normal', 70, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 9, 'normal', 70, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 10, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 11, 'normal', 61, 9, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_117, target_exercise_id, 12, 'normal', 75, 13, NULL, NULL);
END $$;

-- ── WORKOUT 118: Torso pecho 2 ──
DO $$
DECLARE
  w_id_118 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_118, target_profile_id, 'Torso pecho 2', to_timestamp(1757319110), to_timestamp(1757322676), 30, 6751.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 1, 'normal', 40, 27, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 2, 'normal', 57.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 3, 'normal', 57.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 4, 'normal', 57.5, 5, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 5, 'normal', 52, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 6, 'normal', 52, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 7, 'normal', 85, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 8, 'normal', 85, 10, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 9, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 10, 'normal', 41.5, 9, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 11, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 12, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 13, 'normal', 32, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 14, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_118, target_exercise_id, 15, 'normal', 41.5, 12, NULL, NULL);
END $$;

-- ── WORKOUT 119: Culo ──
DO $$
DECLARE
  w_id_119 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_119, target_profile_id, 'Culo', to_timestamp(1757153716), to_timestamp(1757157201), 30, 5729);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 1, 'normal', 70, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 2, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 3, 'normal', 70, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 4, 'normal', 44, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 5, 'normal', 44, 9, NULL, NULL);

  -- Exercise: Lunge (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lunge (Dumbbell)') OR LOWER(name_es) = LOWER('Lunge (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lunge (Dumbbell)', 'Lunge (Dumbbell)', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 6, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 7, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 8, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 9, 'normal', 20, 11, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 10, 'normal', 61, 11, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 11, 'normal', 33, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 12, 'normal', 33, 6, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 13, 'normal', 15, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 14, 'normal', 12.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_119, target_exercise_id, 15, 'normal', 12.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 120: Torso espalda 1 ──
DO $$
DECLARE
  w_id_120 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_120, target_profile_id, 'Torso espalda 1', to_timestamp(1757059683), to_timestamp(1757064370), 30, 6956.5);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 1, 'normal', 45, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 2, 'normal', 55, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 3, 'normal', 55, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 4, 'normal', 55, 3, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 5, 'normal', 54, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 6, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 7, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 8, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 9, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 10, 'normal', 56.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 11, 'normal', 56.5, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 12, 'normal', 38, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 13, 'normal', 38, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 14, 'normal', 38, 8, NULL, NULL);

  -- Exercise: Bicep Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Bicep Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Dumbbell)', 'Bicep Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 15, 'normal', 24, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 16, 'normal', 24, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 17, 'normal', 15, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_120, target_exercise_id, 18, 'normal', 15, 13, NULL, NULL);
END $$;

-- ── WORKOUT 121: Pierna 1 ──
DO $$
DECLARE
  w_id_121 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_121, target_profile_id, 'Pierna 1', to_timestamp(1756886766), to_timestamp(1756890666), 30, 11830);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 1, 'normal', 120, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 2, 'normal', 120, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 3, 'normal', 120, 7, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 4, 'normal', 100, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 5, 'normal', 100, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 6, 'normal', 100, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 7, 'normal', 100, 7, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 8, 'normal', 52.5, 10, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 9, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 10, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 11, 'normal', 54, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 12, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 13, 'normal', 75, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_121, target_exercise_id, 14, 'normal', 75, 12, NULL, NULL);
END $$;

-- ── WORKOUT 122: Torso pecho 2 ──
DO $$
DECLARE
  w_id_122 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_122, target_profile_id, 'Torso pecho 2', to_timestamp(1756799572), to_timestamp(1756803236), 30, 5541.5);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 1, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 2, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 3, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 4, 'normal', 55, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 5, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 6, 'normal', 49.5, 8, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 7, 'normal', NULL, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 8, 'normal', NULL, 6, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 9, 'normal', 32, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 10, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 11, 'normal', 41.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 12, 'normal', 41.5, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 13, 'normal', 48.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_122, target_exercise_id, 14, 'normal', 48.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 123: Pierna + espalda ──
DO $$
DECLARE
  w_id_123 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_123, target_profile_id, 'Pierna + espalda', to_timestamp(1756549726), to_timestamp(1756554367), 30, 6067.5);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 1, 'normal', 57.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 2, 'normal', 57.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 3, 'normal', 57.5, 8, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 4, 'normal', 44, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 5, 'normal', 44, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 6, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 7, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 8, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 9, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 10, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 11, 'normal', 61, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 12, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 13, 'normal', 16, 18, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 14, 'normal', 20, 9, NULL, NULL);

  -- Exercise: Bicep Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Bicep Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Dumbbell)', 'Bicep Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 15, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_123, target_exercise_id, 16, 'normal', 16, 8, NULL, NULL);
END $$;

-- ── WORKOUT 124: Torso pecho 1 ──
DO $$
DECLARE
  w_id_124 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_124, target_profile_id, 'Torso pecho 1', to_timestamp(1756454495), to_timestamp(1756458273), 30, 5678);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 1, 'normal', 42.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 2, 'normal', 52.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 3, 'normal', 52.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 4, 'normal', 52.5, 5, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 5, 'normal', 85, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 6, 'normal', 85, 10, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 7, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 8, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 9, 'normal', 39, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 10, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 11, 'normal', 32, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 12, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 13, 'normal', 20, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_124, target_exercise_id, 14, 'normal', 10, 7, NULL, NULL);
END $$;

-- ── WORKOUT 125: Torso espalda 1 ──
DO $$
DECLARE
  w_id_125 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_125, target_profile_id, 'Torso espalda 1', to_timestamp(1756282592), to_timestamp(1756286221), 30, 5838);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 1, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 2, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 3, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 4, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 5, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 6, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 7, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 8, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 9, 'normal', 38, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 10, 'normal', 38, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 11, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 12, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 13, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 14, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_125, target_exercise_id, 15, 'normal', 20, 7, NULL, NULL);
END $$;

-- ── WORKOUT 126: Pierna 1 ──
DO $$
DECLARE
  w_id_126 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_126, target_profile_id, 'Pierna 1', to_timestamp(1756196130), to_timestamp(1756199783), 30, 11350);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 1, 'normal', 100, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 2, 'normal', 100, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 3, 'normal', 100, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 4, 'normal', 100, 9, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 5, 'normal', 130, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 6, 'normal', 130, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 7, 'normal', 130, 7, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 8, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 9, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 10, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 11, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 12, 'normal', 65, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_126, target_exercise_id, 13, 'normal', 65, 10, NULL, NULL);
END $$;

-- ── WORKOUT 127: Torso pecho 2 ──
DO $$
DECLARE
  w_id_127 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_127, target_profile_id, 'Torso pecho 2', to_timestamp(1756141252), to_timestamp(1756144555), 30, 6006);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 1, 'normal', 47.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 2, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 3, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 4, 'normal', 55, 6, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 5, 'normal', NULL, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 6, 'normal', NULL, 6, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 7, 'normal', 44, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 8, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 9, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 10, 'normal', 47, 9, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 11, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 12, 'normal', 32, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 13, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_127, target_exercise_id, 14, 'normal', 46, 8, NULL, NULL);
END $$;

-- ── WORKOUT 128: Pierna + espalda ──
DO $$
DECLARE
  w_id_128 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_128, target_profile_id, 'Pierna + espalda', to_timestamp(1755943643), to_timestamp(1755948997), 30, 6101);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 1, 'normal', 65, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 2, 'normal', 55, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 3, 'normal', 55, 7, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 4, 'normal', 36, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 5, 'normal', 36, 8, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 6, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 7, 'normal', 61, 12, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 8, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 9, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 10, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 11, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 12, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_128, target_exercise_id, 13, 'normal', 32, 8, NULL, NULL);
END $$;

-- ── WORKOUT 129: Torso pecho 1 ──
DO $$
DECLARE
  w_id_129 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_129, target_profile_id, 'Torso pecho 1', to_timestamp(1755779024), to_timestamp(1755782172), 30, 6051);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 1, 'normal', 40, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 2, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 3, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 4, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 5, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 6, 'normal', 54, 6, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 7, 'normal', 44, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 8, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 9, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 10, 'normal', 85, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 11, 'normal', 80, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 12, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 13, 'normal', 46, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_129, target_exercise_id, 14, 'normal', 39, 9, NULL, NULL);
END $$;

-- ── WORKOUT 130: Torso espalda 1 ──
DO $$
DECLARE
  w_id_130 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_130, target_profile_id, 'Torso espalda 1', to_timestamp(1755706783), to_timestamp(1755710565), 30, 6747);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 1, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 2, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 3, 'normal', 61, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 4, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 5, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 6, 'normal', 60, 11, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 7, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 8, 'normal', 54, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 10, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 11, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 12, 'normal', 20, 10, NULL, NULL);

  -- Exercise: Three Angle Biceps
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Three Angle Biceps') OR LOWER(name_es) = LOWER('Three Angle Biceps') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Three Angle Biceps', 'Three Angle Biceps', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 13, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 14, 'normal', 30, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 15, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_130, target_exercise_id, 16, 'normal', 39, 6, NULL, NULL);
END $$;

-- ── WORKOUT 131: Pierna 1 ──
DO $$
DECLARE
  w_id_131 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_131, target_profile_id, 'Pierna 1', to_timestamp(1755623285), to_timestamp(1755626638), 30, 10180);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 1, 'normal', 95, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 3, 'normal', 100, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 4, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 5, 'normal', 63.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 6, 'normal', 63.5, 9, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 7, 'normal', 45, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 8, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Standing Calf Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Standing Calf Raise (Machine)') OR LOWER(name_es) = LOWER('Standing Calf Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Standing Calf Raise (Machine)', 'Standing Calf Raise (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 9, 'normal', 55, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 10, 'normal', 55, 10, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 11, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_131, target_exercise_id, 12, 'normal', 105, 10, NULL, NULL);
END $$;

-- ── WORKOUT 132: Torso pecho 2 ──
DO $$
DECLARE
  w_id_132 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_132, target_profile_id, 'Torso pecho 2', to_timestamp(1755418752), to_timestamp(1755423006), 30, 6006);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 1, 'normal', 52.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 2, 'normal', 62.5, 3, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 3, 'normal', 62.5, 3, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 4, 'normal', 62.5, 3, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 5, 'normal', 49.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 6, 'normal', 49.5, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 7, 'normal', 85, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 8, 'normal', 85, 9, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 9, 'normal', 32, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 10, 'normal', 32, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 11, 'normal', 41.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 12, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 13, 'normal', 46, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_132, target_exercise_id, 14, 'normal', 46, 9, NULL, NULL);
END $$;

-- ── WORKOUT 133: Torso espalda 1 ──
DO $$
DECLARE
  w_id_133 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_133, target_profile_id, 'Torso espalda 1', to_timestamp(1755265234), to_timestamp(1755269121), 30, 6188);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 1, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 2, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 3, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 4, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 5, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 6, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 7, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 8, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 9, 'normal', 38, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 10, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 11, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 12, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 13, 'normal', 20, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_133, target_exercise_id, 14, 'normal', 20, 11, NULL, NULL);
END $$;

-- ── WORKOUT 134: Pierna 1 ──
DO $$
DECLARE
  w_id_134 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_134, target_profile_id, 'Pierna 1', to_timestamp(1755017342), to_timestamp(1755020014), 30, 10403);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 1, 'normal', 95, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 2, 'normal', 95, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 3, 'normal', 95, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 5, 'normal', 150, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 6, 'normal', 150, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 7, 'normal', 150, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 8, 'normal', 100, 5, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 9, 'normal', 63.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_134, target_exercise_id, 10, 'normal', 63.5, 7, NULL, NULL);
END $$;

-- ── WORKOUT 135: Torso pecho 1 ──
DO $$
DECLARE
  w_id_135 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_135, target_profile_id, 'Torso pecho 1', to_timestamp(1754928405), to_timestamp(1754932128), 30, 5797);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 1, 'normal', 45, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 2, 'normal', 55, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 3, 'normal', 55, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 4, 'normal', 55, 4, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 5, 'normal', NULL, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 6, 'normal', NULL, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 7, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 8, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 9, 'normal', 44, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 10, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 11, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 12, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 13, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_135, target_exercise_id, 14, 'normal', 46, 8, NULL, NULL);
END $$;

-- ── WORKOUT 136: Pierna + espalda ──
DO $$
DECLARE
  w_id_136 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_136, target_profile_id, 'Pierna + espalda', to_timestamp(1754725059), to_timestamp(1754728745), 30, 6248);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 1, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 2, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 3, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 4, 'normal', 35.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 5, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 6, 'normal', 35.5, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 7, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 8, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 9, 'normal', 61, 10, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 10, 'normal', 44, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 11, 'normal', 44, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 12, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 13, 'normal', 39, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_136, target_exercise_id, 14, 'normal', 32, 8, NULL, NULL);
END $$;

-- ── WORKOUT 137: Torso pecho 2 ──
DO $$
DECLARE
  w_id_137 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_137, target_profile_id, 'Torso pecho 2', to_timestamp(1754582597), to_timestamp(1754586354), 30, 6391);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 1, 'normal', 50, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 2, 'normal', 60, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 3, 'normal', 60, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 4, 'normal', 60, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 5, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 6, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 7, 'normal', 85, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 8, 'normal', 85, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 9, 'normal', 44, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 10, 'normal', 44, 9, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 11, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 12, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 13, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_137, target_exercise_id, 14, 'normal', 46, 9, NULL, NULL);
END $$;

-- ── WORKOUT 138: Torso espalda 1 ──
DO $$
DECLARE
  w_id_138 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_138, target_profile_id, 'Torso espalda 1', to_timestamp(1754499059), to_timestamp(1754503087), 30, 7784);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 1, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 2, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 3, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 4, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 5, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 6, 'normal', 38, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 7, 'normal', 38, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 8, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 9, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 10, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Three Angle Biceps
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Three Angle Biceps') OR LOWER(name_es) = LOWER('Three Angle Biceps') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Three Angle Biceps', 'Three Angle Biceps', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 11, 'normal', 20, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 12, 'normal', 20, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 13, 'normal', 20, 13, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 14, 'normal', 39, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 15, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 16, 'normal', 39, 7, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 17, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_138, target_exercise_id, 18, 'normal', 39, 8, NULL, NULL);
END $$;

-- ── WORKOUT 139: Pierna 1 ──
DO $$
DECLARE
  w_id_139 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_139, target_profile_id, 'Pierna 1', to_timestamp(1754414955), to_timestamp(1754419425), 30, 13477);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 1, 'normal', 95, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 3, 'normal', 95, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 4, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 5, 'normal', 130, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 6, 'normal', 130, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 7, 'normal', 130, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 8, 'normal', 130, 8, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 9, 'normal', 44, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 10, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 11, 'normal', 42.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 12, 'normal', 42.5, 11, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 13, 'normal', 85, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_139, target_exercise_id, 14, 'normal', 85, 11, NULL, NULL);
END $$;

-- ── WORKOUT 140: Torso pecho 1 ──
DO $$
DECLARE
  w_id_140 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_140, target_profile_id, 'Torso pecho 1', to_timestamp(1754324384), to_timestamp(1754328474), 30, 6297);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 1, 'normal', 42.5, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 2, 'normal', 52.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 3, 'normal', 52.5, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 4, 'normal', 52.5, 5, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 5, 'normal', NULL, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 6, 'normal', NULL, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 7, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 8, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 9, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 10, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 11, 'normal', 44, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 12, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 13, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_140, target_exercise_id, 14, 'normal', 46, 8, NULL, NULL);
END $$;

-- ── WORKOUT 141: Idk ──
DO $$
DECLARE
  w_id_141 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_141, target_profile_id, 'Idk', to_timestamp(1754126744), to_timestamp(1754130592), 30, 5883);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 1, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 2, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 3, 'normal', 70, 8, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 4, 'normal', 61, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 5, 'normal', 61, 9, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 6, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 7, 'normal', 61, 9, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 8, 'normal', 35.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 9, 'normal', 35.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 10, 'normal', 35.5, 5, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 11, 'normal', 15, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 12, 'normal', 15, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_141, target_exercise_id, 13, 'normal', 13, 8, NULL, NULL);
END $$;

-- ── WORKOUT 142: Torso ──
DO $$
DECLARE
  w_id_142 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_142, target_profile_id, 'Torso', to_timestamp(1754066714), to_timestamp(1754070547), 30, 6508);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 1, 'normal', 47.5, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 2, 'normal', 57.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 3, 'normal', 57.5, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 4, 'normal', 57.5, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 5, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 6, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 7, 'normal', 85, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 8, 'normal', 85, 10, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 9, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 10, 'normal', 44, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 11, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 12, 'normal', 30, 6, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 13, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_142, target_exercise_id, 14, 'normal', 20, 7, NULL, NULL);
END $$;

-- ── WORKOUT 143: Torso ──
DO $$
DECLARE
  w_id_143 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_143, target_profile_id, 'Torso', to_timestamp(1753981501), to_timestamp(1753985474), 30, 6490.5);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 1, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 2, 'normal', 61, 9, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 3, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 4, 'normal', 54, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 5, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 6, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 7, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 8, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 9, 'normal', 35.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 10, 'normal', 35.5, 9, NULL, NULL);

  -- Exercise: EZ Bar Biceps Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('EZ Bar Biceps Curl') OR LOWER(name_es) = LOWER('EZ Bar Biceps Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('EZ Bar Biceps Curl', 'EZ Bar Biceps Curl', 'weight_reps', 'biceps', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 11, 'normal', 10, 18, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 12, 'normal', 10, 14, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 13, 'normal', 39, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 14, 'normal', 32, 9, NULL, NULL);

  -- Exercise: Abdominal Crunch Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Abdominal Crunch Máquina') OR LOWER(name_es) = LOWER('Abdominal Crunch Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Abdominal Crunch Máquina', 'Abdominal Crunch Máquina', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 15, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_143, target_exercise_id, 16, 'normal', 41.5, 10, NULL, NULL);
END $$;

-- ── WORKOUT 144: Pierna ──
DO $$
DECLARE
  w_id_144 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_144, target_profile_id, 'Pierna', to_timestamp(1753897016), to_timestamp(1753900512), 30, 13231);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 1, 'normal', 95, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 2, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 4, 'normal', 95, 10, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 5, 'normal', 170, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 6, 'normal', 170, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 7, 'normal', 170, 12, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 8, 'normal', 75, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 9, 'normal', 75, 11, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 10, 'normal', 44, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 11, 'normal', 44, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_144, target_exercise_id, 12, 'normal', 41.5, 8, NULL, NULL);
END $$;

-- ── WORKOUT 145: Torso ──
DO $$
DECLARE
  w_id_145 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_145, target_profile_id, 'Torso', to_timestamp(1753722107), to_timestamp(1753725905), 30, 7356);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 1, 'normal', 40, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 2, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 3, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 4, 'normal', 50, 5, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 5, 'normal', NULL, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 6, 'normal', NULL, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 7, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 8, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 9, 'normal', 41.5, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 10, 'normal', 41.5, 9, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 11, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 12, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 13, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 14, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 15, 'normal', 46, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_145, target_exercise_id, 16, 'normal', 46, 8, NULL, NULL);
END $$;

-- ── WORKOUT 146: Idk ──
DO $$
DECLARE
  w_id_146 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_146, target_profile_id, 'Idk', to_timestamp(1753623543), to_timestamp(1753627779), 30, 7284.5);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 1, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 2, 'normal', 54, 11, NULL, NULL);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 3, 'normal', 35.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 4, 'normal', 35.5, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 5, 'normal', 35.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 6, 'normal', 35.5, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 7, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 8, 'normal', 61, 9, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 9, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 10, 'normal', 61, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 11, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 12, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 13, 'normal', 42.5, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_146, target_exercise_id, 14, 'normal', 42.5, 11, NULL, NULL);
END $$;

-- ── WORKOUT 147: Torso ──
DO $$
DECLARE
  w_id_147 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_147, target_profile_id, 'Torso', to_timestamp(1753373644), to_timestamp(1753377354), 30, 4743);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 1, 'normal', 45, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 2, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 3, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 4, 'normal', 55, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 5, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 6, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Chest Dip
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Dip') OR LOWER(name_es) = LOWER('Chest Dip') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Dip', 'Chest Dip', 'reps_only', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 7, 'normal', NULL, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 8, 'normal', NULL, 6, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 9, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 10, 'normal', 30, 8, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 11, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_147, target_exercise_id, 12, 'normal', 20, 6, NULL, NULL);
END $$;

-- ── WORKOUT 148: Torso ──
DO $$
DECLARE
  w_id_148 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_148, target_profile_id, 'Torso', to_timestamp(1753289704), to_timestamp(1753294038), 30, 6281.5);

  -- Exercise: Pull Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Pull Up (Assisted)') OR LOWER(name_es) = LOWER('Pull Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Pull Up (Assisted)', 'Pull Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 1, 'normal', 35.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 2, 'normal', 35.5, 8, NULL, NULL);

  -- Exercise: Chin Up (Assisted)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chin Up (Assisted)') OR LOWER(name_es) = LOWER('Chin Up (Assisted)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chin Up (Assisted)', 'Chin Up (Assisted)', 'bodyweight_assisted_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 3, 'normal', 35.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 4, 'normal', 35.5, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 5, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 6, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 7, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 8, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 9, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 10, 'normal', 54, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 11, 'normal', 35.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 12, 'normal', 35.5, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 13, 'normal', 20, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 14, 'normal', 20, 11, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 15, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_148, target_exercise_id, 16, 'normal', 39, 6, NULL, NULL);
END $$;

-- ── WORKOUT 149: Pierna ──
DO $$
DECLARE
  w_id_149 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_149, target_profile_id, 'Pierna', to_timestamp(1753203255), to_timestamp(1753207686), 30, 12018);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 1, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 2, 'normal', 95, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 3, 'normal', 95, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 4, 'normal', 95, 11, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 5, 'normal', 150, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 6, 'normal', 150, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 7, 'normal', 130, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 8, 'normal', 130, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 9, 'normal', 61, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 10, 'normal', 61, 10, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 11, 'normal', 35, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_149, target_exercise_id, 12, 'normal', 40, 11, NULL, NULL);
END $$;

-- ── WORKOUT 150: Torso ──
DO $$
DECLARE
  w_id_150 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_150, target_profile_id, 'Torso', to_timestamp(1753118014), to_timestamp(1753122203), 30, 7838);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 1, 'warmup', 35, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 2, 'normal', 45, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 3, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 4, 'normal', 50, 5, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 5, 'normal', 50, 5, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 6, 'normal', 47, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 7, 'normal', 49.5, 10, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 8, 'normal', 85, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 9, 'normal', 85, 10, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 10, 'normal', 46, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 11, 'normal', 46, 8, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 12, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 13, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 14, 'normal', 54, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 15, 'normal', 54, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_150, target_exercise_id, 16, 'normal', 39, 7, NULL, NULL);
END $$;

