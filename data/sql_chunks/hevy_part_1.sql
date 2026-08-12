-- ============================================================================
-- HEVY WORKOUTS MIGRATION SCRIPT FOR COUPLE GLOW UP
-- Generated from data/hevy_workouts.json (236 workouts)
-- ============================================================================

-- ── WORKOUT 1: Pull ──
DO $$
DECLARE
  w_id_1 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_1, target_profile_id, 'Pull', to_timestamp(1786529006), to_timestamp(1786533388), 30, 7559);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 4, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Chest Supported T Bar Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Supported T Bar Row') OR LOWER(name_es) = LOWER('Chest Supported T Bar Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Supported T Bar Row', 'Chest Supported T Bar Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 5, 'normal', 35, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 6, 'normal', 35, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 7, 'normal', 80, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 8, 'normal', 80, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 9, 'normal', 80, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Cable)') OR LOWER(name_es) = LOWER('Lat Pulldown (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Cable)', 'Lat Pulldown (Cable)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 10, 'normal', 36, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 11, 'normal', 36, 9, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 12, 'normal', 36, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 13, 'normal', 31, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 14, 'normal', 31, 7, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 15, 'normal', 70, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 16, 'normal', 75, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 17, 'normal', 75, 10, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_1, target_exercise_id, 18, 'normal', NULL, NULL, 10, 0);
END $$;

-- ── WORKOUT 2: Push ──
DO $$
DECLARE
  w_id_2 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_2, target_profile_id, 'Push', to_timestamp(1786354274), to_timestamp(1786359653), 30, 7553);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Press militar banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press militar banda elastica') OR LOWER(name_es) = LOWER('Press militar banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press militar banda elastica', 'Press militar banda elastica', 'reps_only', 'shoulders', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 3, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 4, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 5, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 6, 'normal', 50, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 8, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 9, 'normal', 35, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 10, 'normal', 35, 11, NULL, NULL);

  -- Exercise: Seated Shoulder Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Shoulder Press (Machine)') OR LOWER(name_es) = LOWER('Seated Shoulder Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Shoulder Press (Machine)', 'Seated Shoulder Press (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 11, 'normal', 30, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 12, 'normal', 30, 6, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 13, 'normal', 75, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 14, 'normal', 75, 9, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 15, 'normal', 70, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 16, 'normal', 70, 8, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 17, 'normal', 30, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 18, 'normal', 30, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 19, 'normal', 30, 11, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 20, 'normal', 31, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 21, 'normal', 31, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 22, 'normal', 31, 7, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_2, target_exercise_id, 23, 'normal', NULL, NULL, 1200, 0);
END $$;

-- ── WORKOUT 3: Legs ──
DO $$
DECLARE
  w_id_3 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_3, target_profile_id, 'Legs', to_timestamp(1786096011), to_timestamp(1786098651), 30, 1344);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad Rodilla
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad Rodilla') OR LOWER(name_es) = LOWER('Movilidad Rodilla') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad Rodilla', 'Movilidad Rodilla', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Isquio pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Isquio pelota') OR LOWER(name_es) = LOWER('Isquio pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Isquio pelota', 'Isquio pelota', 'reps_only', 'hamstrings', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Sentadilla pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Sentadilla pelota') OR LOWER(name_es) = LOWER('Sentadilla pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Sentadilla pelota', 'Sentadilla pelota', 'reps_only', 'quadriceps', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Zancada estatico
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Zancada estatico') OR LOWER(name_es) = LOWER('Zancada estatico') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Zancada estatico', 'Zancada estatico', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 5, 'normal', 32, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 6, 'normal', 32, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 7, 'normal', 32, 12, NULL, NULL);

  -- Exercise: Squat (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Squat (Smith Machine)') OR LOWER(name_es) = LOWER('Squat (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Squat (Smith Machine)', 'Squat (Smith Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 8, 'normal', 0, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_3, target_exercise_id, 9, 'normal', 0, 10, NULL, NULL);
END $$;

-- ── WORKOUT 4: Pull ──
DO $$
DECLARE
  w_id_4 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_4, target_profile_id, 'Pull', to_timestamp(1785839474), to_timestamp(1785843956), 30, 8734);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 4, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 5, 'normal', 85, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 6, 'normal', 85, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 7, 'normal', 85, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 8, 'normal', 85, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 9, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 10, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 11, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 12, 'normal', 30, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 13, 'normal', 30, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 14, 'normal', 30, 7, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 15, 'normal', 31, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 16, 'normal', 31, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 17, 'normal', 31, 7, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 18, 'normal', 70, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 19, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 20, 'normal', 70, 10, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_4, target_exercise_id, 21, 'normal', NULL, NULL, 10, 0);
END $$;

-- ── WORKOUT 5: Push ──
DO $$
DECLARE
  w_id_5 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_5, target_profile_id, 'Push', to_timestamp(1785722867), to_timestamp(1785728833), 30, 8475);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Press militar banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press militar banda elastica') OR LOWER(name_es) = LOWER('Press militar banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press militar banda elastica', 'Press militar banda elastica', 'reps_only', 'shoulders', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 3, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 4, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 5, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 6, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 8, 'normal', 45, 8, NULL, NULL);

  -- Exercise: Incline Bench Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Smith Machine)') OR LOWER(name_es) = LOWER('Incline Bench Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Smith Machine)', 'Incline Bench Press (Smith Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 9, 'normal', 32, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 10, 'normal', 27, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 11, 'normal', 27, 8, NULL, NULL);

  -- Exercise: Overhead Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Overhead Press (Smith Machine)') OR LOWER(name_es) = LOWER('Overhead Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Overhead Press (Smith Machine)', 'Overhead Press (Smith Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 12, 'normal', 14, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 13, 'normal', 14, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 14, 'normal', 9, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 15, 'normal', 75, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 16, 'normal', 75, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 17, 'normal', 75, 8, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 18, 'normal', 31, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 19, 'normal', 31, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 20, 'normal', 31, 11, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 21, 'normal', 31, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 22, 'normal', 31, 9, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 23, 'normal', 70, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 24, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 25, 'normal', 70, 7, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_5, target_exercise_id, 26, 'normal', NULL, NULL, 1200, 0);
END $$;

-- ── WORKOUT 6: Legs ──
DO $$
DECLARE
  w_id_6 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_6, target_profile_id, 'Legs', to_timestamp(1785638323), to_timestamp(1785642367), 30, 6550);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad Rodilla
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad Rodilla') OR LOWER(name_es) = LOWER('Movilidad Rodilla') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad Rodilla', 'Movilidad Rodilla', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Isquio pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Isquio pelota') OR LOWER(name_es) = LOWER('Isquio pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Isquio pelota', 'Isquio pelota', 'reps_only', 'hamstrings', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Sentadilla pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Sentadilla pelota') OR LOWER(name_es) = LOWER('Sentadilla pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Sentadilla pelota', 'Sentadilla pelota', 'reps_only', 'quadriceps', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Zancada estatico
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Zancada estatico') OR LOWER(name_es) = LOWER('Zancada estatico') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Zancada estatico', 'Zancada estatico', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 5, 'normal', 28, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 6, 'normal', 28, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 7, 'normal', 28, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 8, 'normal', 28, 12, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 9, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 10, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 11, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 12, 'normal', 55, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 13, 'normal', 55, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 14, 'normal', 55, 8, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 15, 'normal', 79, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_6, target_exercise_id, 16, 'normal', 79, 11, NULL, NULL);
END $$;

-- ── WORKOUT 7: Pull ──
DO $$
DECLARE
  w_id_7 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_7, target_profile_id, 'Pull', to_timestamp(1785406520), to_timestamp(1785410720), 30, 6481);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 4, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 5, 'normal', 80, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 6, 'normal', 80, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 7, 'normal', 80, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 8, 'normal', 80, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 9, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 10, 'normal', 45, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 11, 'normal', 40, 11, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 12, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 13, 'normal', 25, 10, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 14, 'normal', 31, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 15, 'normal', 31, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 16, 'normal', 31, 7, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 17, 'normal', NULL, NULL, 1080, 0);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_7, target_exercise_id, 18, 'normal', 70, 5, NULL, NULL);
END $$;

-- ── WORKOUT 8: Push ──
DO $$
DECLARE
  w_id_8 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_8, target_profile_id, 'Push', to_timestamp(1785293359), to_timestamp(1785299659), 30, 6767);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Press militar banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press militar banda elastica') OR LOWER(name_es) = LOWER('Press militar banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press militar banda elastica', 'Press militar banda elastica', 'reps_only', 'shoulders', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 3, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 4, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 5, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 7, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 8, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Incline Bench Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Smith Machine)') OR LOWER(name_es) = LOWER('Incline Bench Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Smith Machine)', 'Incline Bench Press (Smith Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 9, 'normal', 32, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 10, 'normal', 27, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 11, 'normal', 27, 7, NULL, NULL);

  -- Exercise: Overhead Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Overhead Press (Smith Machine)') OR LOWER(name_es) = LOWER('Overhead Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Overhead Press (Smith Machine)', 'Overhead Press (Smith Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 12, 'normal', 14, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 13, 'normal', 14, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 14, 'normal', 14, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 15, 'normal', 70, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 16, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 17, 'normal', 70, 9, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 18, 'normal', 27, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 19, 'normal', 31, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 20, 'normal', 31, 10, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 21, 'normal', 31, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 22, 'normal', 31, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 23, 'normal', 31, 11, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_8, target_exercise_id, 24, 'normal', NULL, NULL, 1200, 0);
END $$;

-- ── WORKOUT 9: Legs ──
DO $$
DECLARE
  w_id_9 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_9, target_profile_id, 'Legs', to_timestamp(1785123885), to_timestamp(1785128826), 30, 7195);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad Rodilla
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad Rodilla') OR LOWER(name_es) = LOWER('Movilidad Rodilla') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad Rodilla', 'Movilidad Rodilla', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Isquio pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Isquio pelota') OR LOWER(name_es) = LOWER('Isquio pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Isquio pelota', 'Isquio pelota', 'reps_only', 'hamstrings', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Sentadilla pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Sentadilla pelota') OR LOWER(name_es) = LOWER('Sentadilla pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Sentadilla pelota', 'Sentadilla pelota', 'reps_only', 'quadriceps', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Zancada estatico
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Zancada estatico') OR LOWER(name_es) = LOWER('Zancada estatico') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Zancada estatico', 'Zancada estatico', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 5, 'normal', 22, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 6, 'normal', 22, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 7, 'normal', 22, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 8, 'normal', 22, 12, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 9, 'normal', 45, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 10, 'normal', 45, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 11, 'normal', 45, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 12, 'normal', 50, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 13, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 14, 'normal', 65, 6, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 15, 'normal', 79, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 16, 'normal', 79, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_9, target_exercise_id, 17, 'normal', 79, 10, NULL, NULL);
END $$;

-- ── WORKOUT 10: Pull ──
DO $$
DECLARE
  w_id_10 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_10, target_profile_id, 'Pull', to_timestamp(1785039602), to_timestamp(1785044342), 30, 9019);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 4, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 5, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 6, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 7, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 8, 'normal', 75, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 9, 'normal', 75, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 10, 'normal', 75, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 11, 'normal', 75, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 12, 'normal', 30, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 13, 'normal', 30, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 14, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 15, 'normal', 27, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 16, 'normal', 27, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 17, 'normal', 27, 11, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 18, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 19, 'normal', 65, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 20, 'normal', 65, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 21, 'normal', 18, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_10, target_exercise_id, 22, 'normal', 18, 10, NULL, NULL);
END $$;

-- ── WORKOUT 11: Push ──
DO $$
DECLARE
  w_id_11 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_11, target_profile_id, 'Push', to_timestamp(1784780604), to_timestamp(1784785917), 30, 7199);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Press militar banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press militar banda elastica') OR LOWER(name_es) = LOWER('Press militar banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press militar banda elastica', 'Press militar banda elastica', 'reps_only', 'shoulders', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 3, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 4, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 5, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 6, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 7, 'normal', 45, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 8, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Incline Bench Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Smith Machine)') OR LOWER(name_es) = LOWER('Incline Bench Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Smith Machine)', 'Incline Bench Press (Smith Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 9, 'normal', 27, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 10, 'normal', 22, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 11, 'normal', 22, 10, NULL, NULL);

  -- Exercise: Overhead Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Overhead Press (Smith Machine)') OR LOWER(name_es) = LOWER('Overhead Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Overhead Press (Smith Machine)', 'Overhead Press (Smith Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 12, 'normal', 9, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 13, 'normal', 9, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 14, 'normal', 9, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 15, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 16, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 17, 'normal', 70, 7, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 18, 'normal', 22, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 19, 'normal', 27, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 20, 'normal', 27, 8, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 21, 'normal', 27, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 22, 'normal', 27, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 23, 'normal', 27, 8, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 24, 'normal', 65, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_11, target_exercise_id, 25, 'normal', 65, 9, NULL, NULL);
END $$;

-- ── WORKOUT 12: Legs ──
DO $$
DECLARE
  w_id_12 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_12, target_profile_id, 'Legs', to_timestamp(1784628514), to_timestamp(1784633975), 30, 9871);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad Rodilla
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad Rodilla') OR LOWER(name_es) = LOWER('Movilidad Rodilla') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad Rodilla', 'Movilidad Rodilla', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Isquio pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Isquio pelota') OR LOWER(name_es) = LOWER('Isquio pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Isquio pelota', 'Isquio pelota', 'reps_only', 'hamstrings', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Sentadilla pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Sentadilla pelota') OR LOWER(name_es) = LOWER('Sentadilla pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Sentadilla pelota', 'Sentadilla pelota', 'reps_only', 'quadriceps', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Zancada estatico
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Zancada estatico') OR LOWER(name_es) = LOWER('Zancada estatico') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Zancada estatico', 'Zancada estatico', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 5, 'normal', 18, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 6, 'normal', 18, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 7, 'normal', 18, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 8, 'normal', 18, 12, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 9, 'normal', 75, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 10, 'normal', 90, 11, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 11, 'normal', 45, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 12, 'normal', 45, 12, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 13, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 14, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 15, 'normal', 45, 11, NULL, NULL);

  -- Exercise: Back Extension (Weighted Hyperextension)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Back Extension (Weighted Hyperextension)') OR LOWER(name_es) = LOWER('Back Extension (Weighted Hyperextension)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Back Extension (Weighted Hyperextension)', 'Back Extension (Weighted Hyperextension)', 'bodyweight_reps', 'lower_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 16, 'normal', 0, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 17, 'normal', 0, 11, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 18, 'normal', 74, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 19, 'normal', 74, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 20, 'normal', 74, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_12, target_exercise_id, 21, 'normal', 74, 13, NULL, NULL);
END $$;

-- ── WORKOUT 13: Pull ──
DO $$
DECLARE
  w_id_13 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_13, target_profile_id, 'Pull', to_timestamp(1784541546), to_timestamp(1784547294), 30, 8076);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 4, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Back Extension (Hyperextension)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Back Extension (Hyperextension)') OR LOWER(name_es) = LOWER('Back Extension (Hyperextension)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Back Extension (Hyperextension)', 'Back Extension (Hyperextension)', 'reps_only', 'lower_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 5, 'normal', NULL, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 6, 'normal', NULL, 11, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 7, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 8, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 9, 'normal', 40, 7, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 10, 'normal', 70, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 11, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 12, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 13, 'normal', 70, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 14, 'normal', 25, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 15, 'normal', 25, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 16, 'normal', 25, 10, NULL, NULL);

  -- Exercise: Bicep Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Bicep Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Dumbbell)', 'Bicep Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 17, 'normal', 18, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 18, 'normal', 18, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 19, 'normal', 18, 9, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 20, 'normal', 60, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 21, 'normal', 60, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 22, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_13, target_exercise_id, 23, 'normal', NULL, NULL, 600, 0);
END $$;

-- ── WORKOUT 14: Push ──
DO $$
DECLARE
  w_id_14 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_14, target_profile_id, 'Push', to_timestamp(1784421258), to_timestamp(1784427893), 30, 4590);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Press militar banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press militar banda elastica') OR LOWER(name_es) = LOWER('Press militar banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press militar banda elastica', 'Press militar banda elastica', 'reps_only', 'shoulders', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 3, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 4, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 5, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 7, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 8, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Incline Bench Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Smith Machine)') OR LOWER(name_es) = LOWER('Incline Bench Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Smith Machine)', 'Incline Bench Press (Smith Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 9, 'normal', 22, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 10, 'normal', 22, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 11, 'normal', 22, 7, NULL, NULL);

  -- Exercise: Overhead Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Overhead Press (Smith Machine)') OR LOWER(name_es) = LOWER('Overhead Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Overhead Press (Smith Machine)', 'Overhead Press (Smith Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 12, 'normal', 9, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 13, 'normal', 9, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 14, 'normal', 9, 9, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 15, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 16, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 17, 'normal', 70, 6, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 18, 'normal', 22, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 19, 'normal', 27, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 20, 'normal', 22, 7, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_14, target_exercise_id, 21, 'normal', NULL, NULL, 1800, 0);
END $$;

-- ── WORKOUT 15: Legs ──
DO $$
DECLARE
  w_id_15 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_15, target_profile_id, 'Legs', to_timestamp(1784195832), to_timestamp(1784200882), 30, 7908);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad Rodilla
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad Rodilla') OR LOWER(name_es) = LOWER('Movilidad Rodilla') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad Rodilla', 'Movilidad Rodilla', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Isquio pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Isquio pelota') OR LOWER(name_es) = LOWER('Isquio pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Isquio pelota', 'Isquio pelota', 'reps_only', 'hamstrings', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Sentadilla pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Sentadilla pelota') OR LOWER(name_es) = LOWER('Sentadilla pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Sentadilla pelota', 'Sentadilla pelota', 'reps_only', 'quadriceps', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Zancada estatico
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Zancada estatico') OR LOWER(name_es) = LOWER('Zancada estatico') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Zancada estatico', 'Zancada estatico', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 5, 'normal', 14, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 6, 'normal', 14, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 7, 'normal', 14, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 8, 'normal', 14, 12, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 9, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 11, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 12, 'normal', 40, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 13, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 14, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 15, 'normal', 74, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 16, 'normal', 74, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 17, 'normal', 74, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 18, 'normal', 74, 12, NULL, NULL);

  -- Exercise: Back Extension (Weighted Hyperextension)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Back Extension (Weighted Hyperextension)') OR LOWER(name_es) = LOWER('Back Extension (Weighted Hyperextension)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Back Extension (Weighted Hyperextension)', 'Back Extension (Weighted Hyperextension)', 'bodyweight_reps', 'lower_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 19, 'normal', 0, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 20, 'normal', 0, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 21, 'normal', 0, 7, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 22, 'normal', 50, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_15, target_exercise_id, 23, 'normal', 60, 10, NULL, NULL);
END $$;

-- ── WORKOUT 16: Pull ──
DO $$
DECLARE
  w_id_16 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_16, target_profile_id, 'Pull', to_timestamp(1784085854), to_timestamp(1784091984), 30, 7290);

  -- Exercise: Manquito Rotador Mancuerna
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Manquito Rotador Mancuerna') OR LOWER(name_es) = LOWER('Manquito Rotador Mancuerna') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Manquito Rotador Mancuerna', 'Manquito Rotador Mancuerna', 'weight_reps', 'shoulders', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 1, 'normal', 5, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 3, 'normal', 70, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 4, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 5, 'normal', 70, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 6, 'normal', 70, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Cable)') OR LOWER(name_es) = LOWER('Lat Pulldown (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Cable)', 'Lat Pulldown (Cable)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 7, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 8, 'normal', 40, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 9, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 10, 'normal', 20, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 11, 'normal', 20, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 12, 'normal', 20, 11, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 13, 'normal', 27, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 14, 'normal', 27, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 15, 'normal', 27, 8, NULL, NULL);

  -- Exercise: Back Extension (Hyperextension)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Back Extension (Hyperextension)') OR LOWER(name_es) = LOWER('Back Extension (Hyperextension)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Back Extension (Hyperextension)', 'Back Extension (Hyperextension)', 'reps_only', 'lower_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 16, 'normal', NULL, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 17, 'normal', NULL, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 18, 'normal', NULL, 11, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 19, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 20, 'normal', 55, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 21, 'normal', 55, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 22, 'normal', 24, 5, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_16, target_exercise_id, 23, 'normal', NULL, NULL, 1200, 0);
END $$;

-- ── WORKOUT 17: Push ──
DO $$
DECLARE
  w_id_17 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_17, target_profile_id, 'Push', to_timestamp(1783936922), to_timestamp(1783944182), 30, 5939);

  -- Exercise: Press militar banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Press militar banda elastica') OR LOWER(name_es) = LOWER('Press militar banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Press militar banda elastica', 'Press militar banda elastica', 'reps_only', 'shoulders', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Retraccion escapular banda elastica
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Retraccion escapular banda elastica') OR LOWER(name_es) = LOWER('Retraccion escapular banda elastica') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Retraccion escapular banda elastica', 'Retraccion escapular banda elastica', 'reps_only', 'other', 'resistance_band', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 2, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Flexiones Escapulares
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Flexiones Escapulares') OR LOWER(name_es) = LOWER('Flexiones Escapulares') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Flexiones Escapulares', 'Flexiones Escapulares', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 3, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 4, 'warmup', NULL, 12, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 5, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 6, 'normal', 50, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 7, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 8, 'normal', 65, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 9, 'normal', 65, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 10, 'normal', 65, 9, NULL, NULL);

  -- Exercise: Incline Bench Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Smith Machine)') OR LOWER(name_es) = LOWER('Incline Bench Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Smith Machine)', 'Incline Bench Press (Smith Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 11, 'normal', 22, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 12, 'normal', 22, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 13, 'normal', 22, 9, NULL, NULL);

  -- Exercise: Overhead Press (Smith Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Overhead Press (Smith Machine)') OR LOWER(name_es) = LOWER('Overhead Press (Smith Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Overhead Press (Smith Machine)', 'Overhead Press (Smith Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 14, 'normal', 9, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 15, 'normal', 9, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 16, 'normal', 9, 7, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 17, 'normal', 27, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 18, 'normal', 22, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 19, 'normal', 22, 8, NULL, NULL);

  -- Exercise: Cycling
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Cycling') OR LOWER(name_es) = LOWER('Cycling') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Cycling', 'Cycling', 'distance_duration', 'cardio', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 20, 'normal', NULL, NULL, 1800, 0);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 21, 'normal', 55, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_17, target_exercise_id, 22, 'normal', 55, 11, NULL, NULL);
END $$;

-- ── WORKOUT 18: Legs ──
DO $$
DECLARE
  w_id_18 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_18, target_profile_id, 'Legs', to_timestamp(1783587956), to_timestamp(1783594882), 30, 8531);

  -- Exercise: Movilidad cadera
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad cadera') OR LOWER(name_es) = LOWER('Movilidad cadera') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad cadera', 'Movilidad cadera', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 1, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Movilidad Rodilla
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Movilidad Rodilla') OR LOWER(name_es) = LOWER('Movilidad Rodilla') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Movilidad Rodilla', 'Movilidad Rodilla', 'reps_only', 'other', 'none', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 2, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Isquio pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Isquio pelota') OR LOWER(name_es) = LOWER('Isquio pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Isquio pelota', 'Isquio pelota', 'reps_only', 'hamstrings', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 3, 'normal', NULL, 12, NULL, NULL);

  -- Exercise: Sentadilla pelota
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Sentadilla pelota') OR LOWER(name_es) = LOWER('Sentadilla pelota') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Sentadilla pelota', 'Sentadilla pelota', 'reps_only', 'quadriceps', 'other', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 4, 'normal', NULL, 10, NULL, NULL);

  -- Exercise: Zancada estatico
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Zancada estatico') OR LOWER(name_es) = LOWER('Zancada estatico') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Zancada estatico', 'Zancada estatico', 'weight_reps', 'quadriceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 5, 'normal', 30, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 6, 'normal', 30, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 7, 'normal', 30, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 8, 'normal', 30, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 9, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 10, 'normal', 45, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 11, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 12, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 13, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 14, 'normal', 40, 8, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 15, 'normal', 74, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 16, 'normal', 74, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 17, 'normal', 74, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 18, 'normal', 74, 9, NULL, NULL);

  -- Exercise: Crunch (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Crunch (Machine)') OR LOWER(name_es) = LOWER('Crunch (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Crunch (Machine)', 'Crunch (Machine)', 'weight_reps', 'abdominals', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 19, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 20, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 21, 'normal', 55, 10, NULL, NULL);

  -- Exercise: Back Extension (Weighted Hyperextension)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Back Extension (Weighted Hyperextension)') OR LOWER(name_es) = LOWER('Back Extension (Weighted Hyperextension)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Back Extension (Weighted Hyperextension)', 'Back Extension (Weighted Hyperextension)', 'bodyweight_reps', 'lower_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 22, 'normal', 0, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 23, 'normal', 11, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_18, target_exercise_id, 24, 'normal', 11, 7, NULL, NULL);
END $$;

-- ── WORKOUT 19: Entrenamiento Matutino ☀️ ──
DO $$
DECLARE
  w_id_19 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_19, target_profile_id, 'Entrenamiento Matutino ☀️', to_timestamp(1778925682), to_timestamp(1778929047), 30, 2005.3999999999999);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 1, 'normal', 28, 2, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 2, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 3, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 4, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 5, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 6, 'normal', 20, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 7, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 8, 'normal', 23, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 9, 'normal', 18, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 10, 'normal', 18, 7, NULL, NULL);

  -- Exercise: Bicep Curl (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bicep Curl (Cable)') OR LOWER(name_es) = LOWER('Bicep Curl (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bicep Curl (Cable)', 'Bicep Curl (Cable)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 11, 'normal', 13.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 12, 'normal', 15.8, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 13, 'normal', 13.5, 8, NULL, NULL);

  -- Exercise: Overhead Triceps Extension (Cable)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Overhead Triceps Extension (Cable)') OR LOWER(name_es) = LOWER('Overhead Triceps Extension (Cable)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Overhead Triceps Extension (Cable)', 'Overhead Triceps Extension (Cable)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 14, 'normal', 11.3, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 15, 'normal', 11.3, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_19, target_exercise_id, 16, 'normal', 11.3, 7, NULL, NULL);
END $$;

-- ── WORKOUT 20: Entrenamiento Matutino ☀️ ──
DO $$
DECLARE
  w_id_20 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_20, target_profile_id, 'Entrenamiento Matutino ☀️', to_timestamp(1778864793), to_timestamp(1778868153), 30, 2348);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_20, target_exercise_id, 1, 'normal', 50, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_20, target_exercise_id, 2, 'normal', 70, 1, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_20, target_exercise_id, 3, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Incline Bench Press (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Dumbbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Dumbbell)', 'Incline Bench Press (Dumbbell)', 'weight_reps', 'chest', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_20, target_exercise_id, 4, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_20, target_exercise_id, 5, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_20, target_exercise_id, 6, 'normal', 32, 9, NULL, NULL);
END $$;

-- ── WORKOUT 21: Vv ──
DO $$
DECLARE
  w_id_21 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_21, target_profile_id, 'Vv', to_timestamp(1778411698), to_timestamp(1778414380), 30, 3624);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 1, 'normal', 60, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 3, 'normal', 60, 7, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 4, 'normal', 63, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 5, 'normal', 63, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 6, 'normal', 63, 5, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 7, 'normal', 24, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 8, 'normal', 20, 6, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 9, 'normal', 18, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_21, target_exercise_id, 10, 'normal', 18, 6, NULL, NULL);
END $$;

-- ── WORKOUT 22: Vv ──
DO $$
DECLARE
  w_id_22 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_22, target_profile_id, 'Vv', to_timestamp(1778347547), to_timestamp(1778350050), 30, 8783);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 1, 'normal', 50, 21, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 3, 'normal', 68, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 4, 'normal', 68, 15, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 5, 'normal', 155, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 6, 'normal', 136, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 7, 'normal', 136, 9, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 8, 'normal', 55, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_22, target_exercise_id, 9, 'normal', 55, 9, NULL, NULL);
END $$;

-- ── WORKOUT 23: Vv ──
DO $$
DECLARE
  w_id_23 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_23, target_profile_id, 'Vv', to_timestamp(1778172333), to_timestamp(1778175878), 30, 4598);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 1, 'normal', 50, 17, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 2, 'normal', 50, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 3, 'normal', 12, 13, NULL, NULL);

  -- Exercise: Bench Press (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Dumbbell)') OR LOWER(name_es) = LOWER('Bench Press (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Dumbbell)', 'Bench Press (Dumbbell)', 'weight_reps', 'chest', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 4, 'normal', 36, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 5, 'normal', 36, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 6, 'normal', 36, 10, NULL, NULL);

  -- Exercise: Incline Bench Press (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Dumbbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Dumbbell)', 'Incline Bench Press (Dumbbell)', 'weight_reps', 'chest', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 7, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 8, 'normal', 32, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 9, 'normal', 32, 10, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 10, 'normal', 16, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 11, 'normal', 24, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 12, 'normal', 16, 11, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_23, target_exercise_id, 13, 'normal', 16, 11, NULL, NULL);
END $$;

-- ── WORKOUT 24: Vv ──
DO $$
DECLARE
  w_id_24 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_24, target_profile_id, 'Vv', to_timestamp(1777825418), to_timestamp(1777830388), 30, 7588);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 1, 'normal', 50, 18, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 2, 'normal', 50, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 3, 'normal', 50, 13, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 4, 'normal', 36, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 5, 'normal', 36, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 6, 'normal', 36, 10, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 7, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 8, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 9, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 10, 'normal', 50, 12, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 11, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 12, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 13, 'normal', 20, 6, NULL, NULL);

  -- Exercise: Incline Bench Press (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Dumbbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Dumbbell)', 'Incline Bench Press (Dumbbell)', 'weight_reps', 'chest', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 14, 'normal', 24, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 15, 'normal', 28, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 16, 'normal', 32, 8, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 17, 'normal', 16, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 18, 'normal', 16, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_24, target_exercise_id, 19, 'normal', 16, 9, NULL, NULL);
END $$;

-- ── WORKOUT 25: Vv ──
DO $$
DECLARE
  w_id_25 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_25, target_profile_id, 'Vv', to_timestamp(1777630115), to_timestamp(1777634555), 30, 5496);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 1, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 2, 'normal', 40, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 3, 'normal', 40, 9, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 4, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 5, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 6, 'normal', 60, 5, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 7, 'normal', 46, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 8, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 9, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 10, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 11, 'normal', 20, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 12, 'normal', 20, 6, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 13, 'normal', 12, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 14, 'normal', 12, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 15, 'normal', 12, 11, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 16, 'normal', 18, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 17, 'normal', 18, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_25, target_exercise_id, 18, 'normal', 18, 8, NULL, NULL);
END $$;

-- ── WORKOUT 26: Indus ──
DO $$
DECLARE
  w_id_26 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_26, target_profile_id, 'Indus', to_timestamp(1777399841), to_timestamp(1777403542), 30, 10817);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 1, 'normal', 75, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 2, 'normal', 75, 14, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 3, 'normal', 60, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 4, 'normal', 60, 13, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 5, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 6, 'normal', 45, 7, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 7, 'normal', 160, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 8, 'normal', 160, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 9, 'normal', 196, 7, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 10, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 11, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_26, target_exercise_id, 12, 'normal', 40, 11, NULL, NULL);
END $$;

-- ── WORKOUT 27: Vv ──
DO $$
DECLARE
  w_id_27 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_27, target_profile_id, 'Vv', to_timestamp(1777202779), to_timestamp(1777207206), 30, 5406.4);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 1, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 2, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 3, 'normal', 60, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 4, 'normal', 60, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 5, 'normal', 60, 6, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 6, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 7, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 8, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 9, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 10, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 11, 'normal', 20, 6, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 12, 'normal', 14, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 13, 'normal', 14, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 14, 'normal', 14, 11, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 15, 'normal', 18, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 16, 'normal', 20.3, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_27, target_exercise_id, 17, 'normal', 18, 8, NULL, NULL);
END $$;

-- ── WORKOUT 28: Pierna 1 ──
DO $$
DECLARE
  w_id_28 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_28, target_profile_id, 'Pierna 1', to_timestamp(1777134026), to_timestamp(1777137029), 30, 8099);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 1, 'normal', 130, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 2, 'normal', 130, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 3, 'normal', 130, 8, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 4, 'normal', 50, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 5, 'normal', 50, 12, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 6, 'normal', 64, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 7, 'normal', 64, 15, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 8, 'normal', 59, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_28, target_exercise_id, 9, 'normal', 59, 10, NULL, NULL);
END $$;

-- ── WORKOUT 29: Vv alba ──
DO $$
DECLARE
  w_id_29 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_29, target_profile_id, 'Vv alba', to_timestamp(1776939540), to_timestamp(1776944947), 30, 6055);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 1, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 2, 'normal', 55, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 3, 'normal', 59, 11, NULL, NULL);

  -- Exercise: T Bar Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('T Bar Row') OR LOWER(name_es) = LOWER('T Bar Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('T Bar Row', 'T Bar Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 4, 'normal', 30, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 5, 'normal', 35, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 6, 'normal', 35, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 7, 'normal', 64, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 8, 'normal', 64, 10, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 9, 'normal', 36, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 10, 'normal', 36, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 11, 'normal', 36, 8, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 12, 'normal', 12, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 13, 'normal', 12, 10, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 14, 'normal', 16, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_29, target_exercise_id, 15, 'normal', 16, 11, NULL, NULL);
END $$;

-- ── WORKOUT 30: Vv ──
DO $$
DECLARE
  w_id_30 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_30, target_profile_id, 'Vv', to_timestamp(1776792437), to_timestamp(1776795796), 30, 5610.599999999999);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 1, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 2, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 3, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 4, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 5, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 6, 'normal', 50, 12, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 7, 'normal', 35, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 8, 'normal', 35, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 9, 'normal', 35, 11, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 10, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 11, 'normal', 20, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 12, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 13, 'normal', 15.8, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 14, 'normal', 15.8, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_30, target_exercise_id, 15, 'normal', 15.8, 8, NULL, NULL);
END $$;

-- ── WORKOUT 31: Vv ──
DO $$
DECLARE
  w_id_31 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_31, target_profile_id, 'Vv', to_timestamp(1776596186), to_timestamp(1776598997), 30, 9368);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 1, 'normal', 110, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 2, 'normal', 110, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 3, 'normal', 110, 7, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 4, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 5, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 6, 'normal', 68, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 7, 'normal', 68, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 8, 'normal', 59, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 9, 'normal', 59, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 10, 'normal', 59, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 11, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 12, 'normal', 55, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_31, target_exercise_id, 13, 'normal', 55, 10, NULL, NULL);
END $$;

-- ── WORKOUT 32: Vg ──
DO $$
DECLARE
  w_id_32 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_32, target_profile_id, 'Vg', to_timestamp(1776509536), to_timestamp(1776514023), 30, 7269);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 1, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 2, 'normal', 55, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 3, 'normal', 55, 5, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 4, 'normal', 55, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 5, 'normal', 59, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 6, 'normal', 59, 9, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 7, 'normal', 46, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 8, 'normal', 50, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 9, 'normal', 50, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 10, 'normal', 60, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 11, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 12, 'normal', 60, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 13, 'normal', 16, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 14, 'normal', 16, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 15, 'normal', 16, 11, NULL, NULL);

  -- Exercise: Iso-Lateral Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Chest Press (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Chest Press (Machine)', 'Iso-Lateral Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 16, 'normal', 30, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 17, 'normal', 20, 10, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 18, 'normal', 16, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 19, 'normal', 12, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_32, target_exercise_id, 20, 'normal', 12, 11, NULL, NULL);
END $$;

-- ── WORKOUT 33: Viva ──
DO $$
DECLARE
  w_id_33 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_33, target_profile_id, 'Viva', to_timestamp(1776263380), to_timestamp(1776266985), 30, 4610);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 1, 'normal', 50, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 2, 'normal', 50, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 3, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 4, 'normal', 16, 16, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 5, 'normal', 16, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 6, 'normal', 16, 10, NULL, NULL);

  -- Exercise: Skullcrusher (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Skullcrusher (Dumbbell)') OR LOWER(name_es) = LOWER('Skullcrusher (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Skullcrusher (Dumbbell)', 'Skullcrusher (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 7, 'normal', 16, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 8, 'normal', 16, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 9, 'normal', 16, 7, NULL, NULL);

  -- Exercise: Concentration Curl
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Concentration Curl') OR LOWER(name_es) = LOWER('Concentration Curl') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Concentration Curl', 'Concentration Curl', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 10, 'normal', 16, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 11, 'normal', 16, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 12, 'normal', 16, 8, NULL, NULL);

  -- Exercise: Triceps Kickback (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Kickback (Dumbbell)') OR LOWER(name_es) = LOWER('Triceps Kickback (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Kickback (Dumbbell)', 'Triceps Kickback (Dumbbell)', 'weight_reps', 'triceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 13, 'normal', 8, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 14, 'normal', 12, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 15, 'normal', 12, 10, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 16, 'normal', 46, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 17, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_33, target_exercise_id, 18, 'normal', 46, 7, NULL, NULL);
END $$;

-- ── WORKOUT 34: Mierda gym ──
DO $$
DECLARE
  w_id_34 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_34, target_profile_id, 'Mierda gym', to_timestamp(1776184577), to_timestamp(1776186599), 30, 3168);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_34, target_exercise_id, 1, 'normal', 64, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_34, target_exercise_id, 2, 'normal', 64, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_34, target_exercise_id, 3, 'normal', 64, 9, NULL, NULL);

  -- Exercise: Iso-Lateral Low Row
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Low Row') OR LOWER(name_es) = LOWER('Iso-Lateral Low Row') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Low Row', 'Iso-Lateral Low Row', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_34, target_exercise_id, 4, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_34, target_exercise_id, 5, 'normal', 40, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_34, target_exercise_id, 6, 'normal', 40, 8, NULL, NULL);
END $$;

-- ── WORKOUT 35: Por hacer algo viva gym ──
DO $$
DECLARE
  w_id_35 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_35, target_profile_id, 'Por hacer algo viva gym', to_timestamp(1775666261), to_timestamp(1775669725), 30, 4583);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 1, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 2, 'normal', 60, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 3, 'normal', 60, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 4, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 5, 'normal', 46, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 6, 'normal', 46, 7, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 7, 'normal', 55, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 8, 'normal', 55, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 9, 'normal', 55, 9, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 10, 'normal', 24, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 11, 'normal', 24, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_35, target_exercise_id, 12, 'normal', 24, 7, NULL, NULL);
END $$;

-- ── WORKOUT 36: Viva gym petao ──
DO $$
DECLARE
  w_id_36 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_36, target_profile_id, 'Viva gym petao', to_timestamp(1775578059), to_timestamp(1775579932), 30, 6810);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_36, target_exercise_id, 1, 'normal', 120, 20, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_36, target_exercise_id, 2, 'normal', 136, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_36, target_exercise_id, 3, 'normal', 155, 7, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_36, target_exercise_id, 4, 'normal', 59, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_36, target_exercise_id, 5, 'normal', 59, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_36, target_exercise_id, 6, 'normal', 59, 9, NULL, NULL);
END $$;

-- ── WORKOUT 37: España indus ──
DO $$
DECLARE
  w_id_37 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_37, target_profile_id, 'España indus', to_timestamp(1775384951), to_timestamp(1775389355), 30, 5595);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 1, 'normal', 59, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 2, 'normal', 54, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 3, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 4, 'normal', 64, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 5, 'normal', 64, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 6, 'normal', 64, 8, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 7, 'normal', 17, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 8, 'normal', 17, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 9, 'normal', 17, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 10, 'normal', 41, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 11, 'normal', 41, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 12, 'normal', 41, 7, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 13, 'normal', 15, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 14, 'normal', 15, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_37, target_exercise_id, 15, 'normal', 15, 8, NULL, NULL);
END $$;

-- ── WORKOUT 38: Viva gym ──
DO $$
DECLARE
  w_id_38 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_38, target_profile_id, 'Viva gym', to_timestamp(1775210684), to_timestamp(1775213487), 30, 4566);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 1, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 2, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 3, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 4, 'normal', 36, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 5, 'normal', 36, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 6, 'normal', 36, 8, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 7, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 8, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 9, 'normal', 46, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 10, 'normal', 46, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 11, 'normal', 46, 9, NULL, NULL);

  -- Exercise: Triceps Pushdown
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Pushdown') OR LOWER(name_es) = LOWER('Triceps Pushdown') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Pushdown', 'Triceps Pushdown', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 12, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 13, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_38, target_exercise_id, 14, 'normal', 20, 8, NULL, NULL);
END $$;

-- ── WORKOUT 39: Entrenamiento por la tarde 💪 ──
DO $$
DECLARE
  w_id_39 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_39, target_profile_id, 'Entrenamiento por la tarde 💪', to_timestamp(1775132392), to_timestamp(1775135977), 30, 10937);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 1, 'normal', 50, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 2, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 3, 'normal', 50, 9, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 4, 'normal', 59, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 5, 'normal', 59, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 6, 'normal', 59, 9, NULL, NULL);

  -- Exercise: Lying Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lying Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Lying Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lying Leg Curl (Machine)', 'Lying Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 7, 'normal', 30, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 8, 'normal', 35, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 9, 'normal', 35, 9, NULL, NULL);

  -- Exercise: Leg Press Horizontal (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press Horizontal (Machine)') OR LOWER(name_es) = LOWER('Leg Press Horizontal (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press Horizontal (Machine)', 'Leg Press Horizontal (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 10, 'normal', 82, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 11, 'normal', 100, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 12, 'normal', 100, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 13, 'normal', 118, 8, NULL, NULL);

  -- Exercise: Patada Gluteo Máquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Patada Gluteo Máquina') OR LOWER(name_es) = LOWER('Patada Gluteo Máquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Patada Gluteo Máquina', 'Patada Gluteo Máquina', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 14, 'normal', 32, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 15, 'normal', 32, 9, NULL, NULL);

  -- Exercise: Leg Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Extension (Machine)') OR LOWER(name_es) = LOWER('Leg Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Extension (Machine)', 'Leg Extension (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 16, 'normal', 55, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_39, target_exercise_id, 17, 'normal', 55, 9, NULL, NULL);
END $$;

-- ── WORKOUT 40: Viva gym espalda ──
DO $$
DECLARE
  w_id_40 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_40, target_profile_id, 'Viva gym espalda', to_timestamp(1775031695), to_timestamp(1775034717), 30, 5016);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 1, 'normal', 64, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 2, 'normal', 64, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 3, 'normal', 64, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 4, 'normal', 46, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 5, 'normal', 46, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 6, 'normal', 46, 8, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 7, 'normal', 36, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 8, 'normal', 36, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 9, 'normal', 36, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 10, 'normal', 16, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 11, 'normal', 16, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 12, 'normal', 16, 8, NULL, NULL);

  -- Exercise: Hammer Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hammer Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Hammer Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hammer Curl (Dumbbell)', 'Hammer Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 13, 'normal', 16, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 14, 'normal', 16, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_40, target_exercise_id, 15, 'normal', 16, 7, NULL, NULL);
END $$;

-- ── WORKOUT 41: Vivagym ──
DO $$
DECLARE
  w_id_41 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_41, target_profile_id, 'Vivagym', to_timestamp(1774776480), to_timestamp(1774779802), 30, 4863);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 1, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 2, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 3, 'normal', 50, 6, NULL, NULL);

  -- Exercise: Chest Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Press (Machine)') OR LOWER(name_es) = LOWER('Chest Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Press (Machine)', 'Chest Press (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 4, 'normal', 36, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 5, 'normal', 36, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 6, 'normal', 36, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 7, 'normal', 41, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 8, 'normal', 46, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 9, 'normal', 41, 8, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 10, 'normal', 36, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 11, 'normal', 36, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 12, 'normal', 36, 11, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 13, 'normal', 16, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 14, 'normal', 16, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_41, target_exercise_id, 15, 'normal', 16, 8, NULL, NULL);
END $$;

-- ── WORKOUT 42: Torso espalda 1 ──
DO $$
DECLARE
  w_id_42 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_42, target_profile_id, 'Torso espalda 1', to_timestamp(1772822652), to_timestamp(1772826448), 30, 7387);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 1, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 2, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 3, 'normal', 70, 7, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 4, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 5, 'normal', 40, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 6, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 7, 'normal', 60, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 8, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 9, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 10, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 11, 'normal', 39, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 12, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 13, 'normal', 16, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 14, 'normal', 16, 6, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 15, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_42, target_exercise_id, 16, 'normal', 38, 9, NULL, NULL);
END $$;

-- ── WORKOUT 43: Torso pecho 2 ──
DO $$
DECLARE
  w_id_43 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_43, target_profile_id, 'Torso pecho 2', to_timestamp(1772712329), to_timestamp(1772716158), 30, 7381);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 1, 'normal', 60, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 2, 'normal', 60, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 3, 'normal', 60, 5, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 4, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 5, 'normal', 54, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 6, 'normal', 54, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 7, 'normal', 75, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 8, 'normal', 75, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 9, 'normal', 75, 7, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 10, 'normal', 39, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 11, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 12, 'normal', 39, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 13, 'normal', 46, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 14, 'normal', 46, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_43, target_exercise_id, 15, 'normal', 46, 7, NULL, NULL);
END $$;

-- ── WORKOUT 44: Pierna 1 ──
DO $$
DECLARE
  w_id_44 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_44, target_profile_id, 'Pierna 1', to_timestamp(1772541045), to_timestamp(1772544825), 30, 13231);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 1, 'normal', 129, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 2, 'normal', 129, 15, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 3, 'normal', 160, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 4, 'normal', 160, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 5, 'normal', 160, 4, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 6, 'normal', 61, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 7, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 8, 'normal', 61, 9, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 9, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 10, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 11, 'normal', 70, 11, NULL, NULL);

  -- Exercise: Calf Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Calf Extension (Machine)') OR LOWER(name_es) = LOWER('Calf Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Calf Extension (Machine)', 'Calf Extension (Machine)', 'weight_reps', 'calves', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 12, 'normal', 100, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 13, 'normal', 100, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_44, target_exercise_id, 14, 'normal', 100, 10, NULL, NULL);
END $$;

-- ── WORKOUT 45: . ──
DO $$
DECLARE
  w_id_45 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_45, target_profile_id, '.', to_timestamp(1772366744), to_timestamp(1772373329), 30, 14044);

  -- Exercise: Iso-Lateral Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral Row (Machine)', 'Iso-Lateral Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 1, 'normal', 70, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 2, 'normal', 70, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 3, 'normal', 70, 9, NULL, NULL);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 4, 'normal', 40, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 5, 'normal', 40, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 6, 'normal', 40, 10, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 7, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 8, 'normal', 49.5, 8, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 9, 'normal', 49.5, 7, NULL, NULL);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 10, 'normal', 124, 19, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 11, 'normal', 124, 15, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 12, 'normal', 150, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 13, 'normal', 150, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 14, 'normal', 150, 4, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 15, 'normal', 20, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 16, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 17, 'normal', 20, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 18, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 19, 'normal', 20, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 20, 'normal', 20, 7, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 21, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 22, 'normal', 60, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_45, target_exercise_id, 23, 'normal', 60, 12, NULL, NULL);
END $$;

-- ── WORKOUT 46: Torso espalda 1 ──
DO $$
DECLARE
  w_id_46 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_46, target_profile_id, 'Torso espalda 1', to_timestamp(1772108393), to_timestamp(1772111234), 30, 6384.5);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 1, 'normal', 70, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 2, 'normal', 60, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 3, 'normal', 60, 10, NULL, NULL);

  -- Exercise: Lat Pulldown (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lat Pulldown (Machine)') OR LOWER(name_es) = LOWER('Lat Pulldown (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lat Pulldown (Machine)', 'Lat Pulldown (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 4, 'normal', 56.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 5, 'normal', 56.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 6, 'normal', 54, 8, NULL, NULL);

  -- Exercise: Seated Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Row (Machine)') OR LOWER(name_es) = LOWER('Seated Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Row (Machine)', 'Seated Row (Machine)', 'weight_reps', 'upper_back', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 7, 'normal', 49.5, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 8, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 9, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 10, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 11, 'normal', 38, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 12, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 13, 'normal', 39, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_46, target_exercise_id, 14, 'normal', 39, 7, NULL, NULL);
END $$;

-- ── WORKOUT 47: Torso pecho 2 ──
DO $$
DECLARE
  w_id_47 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_47, target_profile_id, 'Torso pecho 2', to_timestamp(1772027875), to_timestamp(1772031866), 30, 6581);

  -- Exercise: Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Bench Press (Barbell)', 'Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 1, 'normal', 50, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 2, 'normal', 55, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 3, 'normal', 55, 6, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 4, 'normal', 55, 4, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 5, 'normal', 47, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 6, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 7, 'normal', 47, 7, NULL, NULL);

  -- Exercise: Seated Dip Machine
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Dip Machine') OR LOWER(name_es) = LOWER('Seated Dip Machine') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Dip Machine', 'Seated Dip Machine', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 8, 'normal', 75, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 9, 'normal', 72.5, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 10, 'normal', 72.5, 8, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 11, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 12, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 13, 'normal', 20, 8, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 14, 'normal', 39, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 15, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_47, target_exercise_id, 16, 'normal', 9, 8, NULL, NULL);
END $$;

-- ── WORKOUT 48: Pierna 1 ──
DO $$
DECLARE
  w_id_48 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_48, target_profile_id, 'Pierna 1', to_timestamp(1771936277), to_timestamp(1771939889), 30, 11036);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 1, 'normal', 124, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 2, 'normal', 124, 15, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 3, 'normal', 96, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 4, 'normal', 96, 12, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 5, 'normal', 140, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 6, 'normal', 140, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 7, 'normal', 140, 4, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 8, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 9, 'normal', 50, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 10, 'normal', 50, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 11, 'normal', 61, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 12, 'normal', 61, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_48, target_exercise_id, 13, 'normal', 61, 7, NULL, NULL);
END $$;

-- ── WORKOUT 49: Torso pecho 1 ──
DO $$
DECLARE
  w_id_49 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_49, target_profile_id, 'Torso pecho 1', to_timestamp(1771765515), to_timestamp(1771772501), 30, 9793.5);

  -- Exercise: Incline Bench Press (Barbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Incline Bench Press (Barbell)') OR LOWER(name_es) = LOWER('Incline Bench Press (Barbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Incline Bench Press (Barbell)', 'Incline Bench Press (Barbell)', 'weight_reps', 'chest', 'barbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 1, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 2, 'normal', 50, 7, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 3, 'normal', 50, 7, NULL, NULL);

  -- Exercise: Chest Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Chest Fly (Machine)') OR LOWER(name_es) = LOWER('Chest Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Chest Fly (Machine)', 'Chest Fly (Machine)', 'weight_reps', 'chest', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 4, 'normal', 47, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 5, 'normal', 47, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 6, 'normal', 47, 8, NULL, NULL);

  -- Exercise: Lateral Raise (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Lateral Raise (Machine)') OR LOWER(name_es) = LOWER('Lateral Raise (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Lateral Raise (Machine)', 'Lateral Raise (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 7, 'normal', 39, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 8, 'normal', 39, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 9, 'normal', 39, 10, NULL, NULL);

  -- Exercise: Iso-Lateral High Row (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Iso-Lateral High Row (Machine)') OR LOWER(name_es) = LOWER('Iso-Lateral High Row (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Iso-Lateral High Row (Machine)', 'Iso-Lateral High Row (Machine)', 'weight_reps', 'lats', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 10, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 11, 'normal', 60, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 12, 'normal', 60, 9, NULL, NULL);

  -- Exercise: Rear Delt Reverse Fly (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Rear Delt Reverse Fly (Machine)') OR LOWER(name_es) = LOWER('Rear Delt Reverse Fly (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Rear Delt Reverse Fly (Machine)', 'Rear Delt Reverse Fly (Machine)', 'weight_reps', 'shoulders', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 13, 'normal', 38, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 14, 'normal', 38, 10, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 15, 'normal', 38, 9, NULL, NULL);

  -- Exercise: Triceps Extension (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Triceps Extension (Machine)') OR LOWER(name_es) = LOWER('Triceps Extension (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Triceps Extension (Machine)', 'Triceps Extension (Machine)', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 16, 'normal', 41.5, 12, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 17, 'normal', 41.5, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 18, 'normal', 41.5, 8, NULL, NULL);

  -- Exercise: Seated Incline Curl (Dumbbell)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Incline Curl (Dumbbell)') OR LOWER(name_es) = LOWER('Seated Incline Curl (Dumbbell)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Incline Curl (Dumbbell)', 'Seated Incline Curl (Dumbbell)', 'weight_reps', 'biceps', 'dumbbell', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 19, 'normal', 16, 14, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 20, 'normal', 16, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 21, 'normal', 16, 7, NULL, NULL);

  -- Exercise: Super French Press Maquina
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Super French Press Maquina') OR LOWER(name_es) = LOWER('Super French Press Maquina') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Super French Press Maquina', 'Super French Press Maquina', 'weight_reps', 'triceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 22, 'normal', 20, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 23, 'normal', 20, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 24, 'normal', 20, 9, NULL, NULL);

  -- Exercise: Preacher Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Preacher Curl (Machine)') OR LOWER(name_es) = LOWER('Preacher Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Preacher Curl (Machine)', 'Preacher Curl (Machine)', 'weight_reps', 'biceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 25, 'normal', 32, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 26, 'normal', 32, 9, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_49, target_exercise_id, 27, 'normal', 32, 8, NULL, NULL);
END $$;

-- ── WORKOUT 50: Pierna 1 ──
DO $$
DECLARE
  w_id_50 UUID := gen_random_uuid();
  target_profile_id UUID;
  target_exercise_id UUID;
BEGIN
  SELECT id INTO target_profile_id FROM public.profiles LIMIT 1;
  INSERT INTO public.workouts (id, profile_id, name, started_at, finished_at, duration_minutes, estimated_volume_kg)
  VALUES (w_id_50, target_profile_id, 'Pierna 1', to_timestamp(1771679455), to_timestamp(1771683301), 30, 9688);

  -- Exercise: Hip Adduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Adduction (Machine)') OR LOWER(name_es) = LOWER('Hip Adduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Adduction (Machine)', 'Hip Adduction (Machine)', 'weight_reps', 'adductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 1, 'normal', 124, 15, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 2, 'normal', 124, 11, NULL, NULL);

  -- Exercise: Hip Abduction (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Abduction (Machine)') OR LOWER(name_es) = LOWER('Hip Abduction (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Abduction (Machine)', 'Hip Abduction (Machine)', 'weight_reps', 'abductors', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 3, 'normal', 96, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 4, 'normal', 96, 7, NULL, NULL);

  -- Exercise: Leg Press (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Leg Press (Machine)') OR LOWER(name_es) = LOWER('Leg Press (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Leg Press (Machine)', 'Leg Press (Machine)', 'weight_reps', 'quadriceps', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 5, 'normal', 130, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 6, 'normal', 130, 4, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 7, 'normal', 130, 4, NULL, NULL);

  -- Exercise: Hip Thrust (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Hip Thrust (Machine)') OR LOWER(name_es) = LOWER('Hip Thrust (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Hip Thrust (Machine)', 'Hip Thrust (Machine)', 'weight_reps', 'glutes', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 8, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 9, 'normal', 45, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 10, 'normal', 45, 11, NULL, NULL);

  -- Exercise: Seated Leg Curl (Machine)
  SELECT id INTO target_exercise_id FROM public.exercises WHERE LOWER(name) = LOWER('Seated Leg Curl (Machine)') OR LOWER(name_es) = LOWER('Seated Leg Curl (Machine)') LIMIT 1;
  IF target_exercise_id IS NULL THEN
    INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, equipment_category, is_custom)
    VALUES ('Seated Leg Curl (Machine)', 'Seated Leg Curl (Machine)', 'weight_reps', 'hamstrings', 'machine', true)
    RETURNING id INTO target_exercise_id;
  END IF;
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 11, 'normal', 47, 13, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 12, 'normal', 54, 11, NULL, NULL);
  INSERT INTO public.workout_sets (workout_id, exercise_id, set_index, indicator, weight_kg, reps, duration_seconds, distance_meters)
  VALUES (w_id_50, target_exercise_id, 13, 'normal', 54, 9, NULL, NULL);
END $$;

