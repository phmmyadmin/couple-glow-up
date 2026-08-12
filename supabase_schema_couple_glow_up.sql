-- ============================================================================
-- COUPLE GLOW UP — SCHEMA SQL COMPLETO PARA SUPABASE
-- Tablas: Profiles, Fit Tracker, Shopping List, Gym Tracker, Couple Feed
-- Triggers: Auto-PRs (1RM Epley), Auto-Feed Events, Realtime
-- ============================================================================

-- ── 0. HABILITAR EXTENSIONES Y FUNCIONES BASE ──
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ── 1. PROFILES & FIT TRACKER ──
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  gender TEXT DEFAULT 'male',          -- 'male', 'female'
  language TEXT DEFAULT 'es',
  avatar_url TEXT,
  height NUMERIC DEFAULT 175,
  weight NUMERIC DEFAULT 70,
  target_weight NUMERIC DEFAULT 68,
  activity_level TEXT DEFAULT 'moderate',
  goal TEXT DEFAULT 'lose_weight',
  pace TEXT DEFAULT 'moderate',
  target_macros JSONB DEFAULT '{"calories": 1950, "protein": 145, "carbs": 195, "fats": 65}'::jsonb,
  maintenance_calories INTEGER DEFAULT 2450,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.daily_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  calories NUMERIC DEFAULT 0,
  protein NUMERIC DEFAULT 0,
  carbs NUMERIC DEFAULT 0,
  fats NUMERIC DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(profile_id, date)
);

CREATE TABLE IF NOT EXISTS public.intakes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  daily_log_id UUID REFERENCES public.daily_logs(id) ON DELETE CASCADE,
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  time TEXT DEFAULT '12:00',
  name TEXT NOT NULL,
  dish_name TEXT,
  quantity NUMERIC DEFAULT 1,
  unit TEXT DEFAULT 'porcion',
  category TEXT DEFAULT 'other',
  calories NUMERIC DEFAULT 0,
  protein NUMERIC DEFAULT 0,
  carbs NUMERIC DEFAULT 0,
  fats NUMERIC DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.weight_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  time TEXT DEFAULT '08:00',
  weight NUMERIC NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(profile_id, date, time)
);


-- ── 2. 🛒 SHOPPING LIST ──

CREATE TABLE IF NOT EXISTS public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  category TEXT DEFAULT 'other',
  default_unit TEXT DEFAULT 'ud',
  emoji TEXT,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.markets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  address TEXT,
  emoji TEXT DEFAULT '🏪',
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.shopping_lists (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL DEFAULT 'Lista de la compra',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.shopping_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  list_id UUID REFERENCES public.shopping_lists(id) ON DELETE CASCADE,
  product_id UUID REFERENCES public.products(id),
  name TEXT NOT NULL,
  quantity NUMERIC DEFAULT 1,
  unit TEXT DEFAULT 'ud',
  category TEXT DEFAULT 'other',
  is_checked BOOLEAN DEFAULT false,
  checked_by UUID REFERENCES public.profiles(id),
  checked_at TIMESTAMPTZ,
  added_by UUID REFERENCES public.profiles(id),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.product_prices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_name TEXT NOT NULL,
  product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
  market_id UUID REFERENCES public.markets(id) ON DELETE CASCADE,
  price NUMERIC NOT NULL,
  currency TEXT DEFAULT 'PHP',
  unit TEXT DEFAULT 'kg',
  last_updated TIMESTAMPTZ DEFAULT now(),
  updated_by UUID REFERENCES public.profiles(id),
  UNIQUE(product_name, market_id)
);


-- ── 3. 🏋️ GYM TRACKER (HEVY MODEL) ──

CREATE TABLE IF NOT EXISTS public.exercises (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  name_es TEXT,
  exercise_type TEXT NOT NULL DEFAULT 'weight_reps',
  -- 'weight_reps', 'reps_only', 'distance_duration', 'duration_only', 'weight_distance'
  muscle_group TEXT NOT NULL,
  other_muscles JSONB DEFAULT '[]',
  equipment_category TEXT DEFAULT 'bodyweight',
  is_custom BOOLEAN DEFAULT false,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.routines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  color TEXT DEFAULT '#6366f1',
  exercises JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.workouts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  routine_id UUID REFERENCES public.routines(id),
  name TEXT NOT NULL,
  description TEXT,
  started_at TIMESTAMPTZ NOT NULL,
  finished_at TIMESTAMPTZ,
  duration_minutes INTEGER,
  estimated_volume_kg NUMERIC DEFAULT 0,
  include_warmup_sets BOOLEAN DEFAULT true,
  nth_workout INTEGER,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.workout_sets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_id UUID REFERENCES public.workouts(id) ON DELETE CASCADE,
  exercise_id UUID REFERENCES public.exercises(id),
  set_index INTEGER NOT NULL DEFAULT 0,
  indicator TEXT NOT NULL DEFAULT 'normal', -- 'normal', 'warmup', 'dropset', 'failure'
  weight_kg NUMERIC,
  reps INTEGER,
  duration_seconds INTEGER,
  distance_meters NUMERIC,
  rpe NUMERIC,
  superset_id INTEGER,
  prs JSONB DEFAULT '[]',
  completed_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.personal_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  exercise_id UUID REFERENCES public.exercises(id),
  record_type TEXT NOT NULL,
  value NUMERIC NOT NULL,
  achieved_at TIMESTAMPTZ DEFAULT now(),
  workout_id UUID REFERENCES public.workouts(id),
  set_id UUID REFERENCES public.workout_sets(id),
  UNIQUE(profile_id, exercise_id, record_type)
);


-- ── 4. 📰 COUPLE FEED ──

CREATE TABLE IF NOT EXISTS public.feed_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  metadata JSONB DEFAULT '{}',
  emoji TEXT DEFAULT '🎯',
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.feed_reactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES public.feed_events(id) ON DELETE CASCADE,
  profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  emoji TEXT DEFAULT '❤️',
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(event_id, profile_id)
);


-- ── 5. SEED DE EJERCICIOS (~120 PREDEFINIDOS) ──

INSERT INTO public.exercises (name, name_es, exercise_type, muscle_group, other_muscles, equipment_category, is_custom) VALUES
('Bench Press',              'Press de Banca',              'weight_reps', 'chest',     '["triceps","shoulders"]', 'barbell',    false),
('Incline Bench Press',      'Press Inclinado',             'weight_reps', 'chest',     '["triceps","shoulders"]', 'barbell',    false),
('Decline Bench Press',      'Press Declinado',             'weight_reps', 'chest',     '["triceps"]',             'barbell',    false),
('Dumbbell Bench Press',     'Press con Mancuernas',        'weight_reps', 'chest',     '["triceps","shoulders"]', 'dumbbell',   false),
('Incline Dumbbell Press',   'Press Inclinado Mancuernas',  'weight_reps', 'chest',     '["triceps","shoulders"]', 'dumbbell',   false),
('Dumbbell Fly',             'Aperturas con Mancuernas',    'weight_reps', 'chest',     '[]',                      'dumbbell',   false),
('Cable Fly',                'Aperturas en Polea',          'weight_reps', 'chest',     '[]',                      'cable',      false),
('Chest Fly (Machine)',      'Aperturas (Máquina)',         'weight_reps', 'chest',     '[]',                      'machine',    false),
('Chest Dip',                'Fondos en Paralelas',         'weight_reps', 'chest',     '["triceps","shoulders"]', 'bodyweight', false),
('Push Up',                  'Flexiones',                   'reps_only',   'chest',     '["triceps","shoulders"]', 'bodyweight', false),
('Machine Chest Press',      'Press de Pecho en Máquina',   'weight_reps', 'chest',     '["triceps","shoulders"]', 'machine',    false),
('Pec Deck',                 'Contractora de Pecho',        'weight_reps', 'chest',     '[]',                      'machine',    false),

('Deadlift',                 'Peso Muerto',                 'weight_reps', 'back',      '["legs","glutes"]',       'barbell',    false),
('Barbell Row',              'Remo con Barra',              'weight_reps', 'back',      '["biceps"]',              'barbell',    false),
('Pendlay Row',              'Remo Pendlay',                'weight_reps', 'back',      '["biceps"]',              'barbell',    false),
('Dumbbell Row',             'Remo con Mancuerna',          'weight_reps', 'back',      '["biceps"]',              'dumbbell',   false),
('Pull Up',                  'Dominadas',                   'reps_only',   'back',      '["biceps"]',              'bodyweight', false),
('Chin Up',                  'Dominadas Supinas',           'reps_only',   'back',      '["biceps"]',              'bodyweight', false),
('Lat Pulldown',             'Jalón al Pecho',              'weight_reps', 'back',      '["biceps"]',              'cable',      false),
('Seated Cable Row',         'Remo Sentado en Polea',       'weight_reps', 'back',      '["biceps"]',              'cable',      false),
('T-Bar Row',                'Remo en T',                   'weight_reps', 'back',      '["biceps"]',              'barbell',    false),
('Face Pull',                'Face Pull',                   'weight_reps', 'back',      '["shoulders"]',           'cable',      false),
('Hyperextension',           'Hiperextensiones',            'reps_only',   'back',      '["glutes"]',              'bodyweight', false),
('Machine Row',              'Remo en Máquina',             'weight_reps', 'back',      '["biceps"]',              'machine',    false),

('Barbell Squat',            'Sentadilla con Barra',        'weight_reps', 'legs',      '["glutes"]',              'barbell',    false),
('Front Squat',              'Sentadilla Frontal',          'weight_reps', 'legs',      '["abdominals"]',          'barbell',    false),
('Leg Press',                'Prensa de Piernas',           'weight_reps', 'legs',      '["glutes"]',              'machine',    false),
('Hack Squat',               'Hack Squat',                  'weight_reps', 'legs',      '["glutes"]',              'machine',    false),
('Romanian Deadlift',        'Peso Muerto Rumano',          'weight_reps', 'legs',      '["back","glutes"]',       'barbell',    false),
('Bulgarian Split Squat',    'Sentadilla Búlgara',          'weight_reps', 'legs',      '["glutes"]',              'dumbbell',   false),
('Leg Extension',            'Extensión de Cuádriceps',     'weight_reps', 'legs',      '[]',                      'machine',    false),
('Leg Curl',                 'Curl de Isquiotibiales',      'weight_reps', 'legs',      '[]',                      'machine',    false),
('Walking Lunge',            'Zancadas Caminando',          'weight_reps', 'legs',      '["glutes"]',              'dumbbell',   false),
('Goblet Squat',             'Sentadilla Goblet',           'weight_reps', 'legs',      '["glutes"]',              'dumbbell',   false),
('Calf Raise',               'Elevación de Gemelos',        'weight_reps', 'legs',      '[]',                      'machine',    false),
('Hip Thrust',               'Hip Thrust',                  'weight_reps', 'glutes',    '["legs"]',                'barbell',    false),

('Overhead Press',           'Press Militar',               'weight_reps', 'shoulders', '["triceps"]',             'barbell',    false),
('Dumbbell Shoulder Press',  'Press Hombros Mancuernas',    'weight_reps', 'shoulders', '["triceps"]',             'dumbbell',   false),
('Arnold Press',             'Press Arnold',                'weight_reps', 'shoulders', '["triceps"]',             'dumbbell',   false),
('Lateral Raise',            'Elevaciones Laterales',       'weight_reps', 'shoulders', '[]',                      'dumbbell',   false),
('Front Raise',              'Elevaciones Frontales',       'weight_reps', 'shoulders', '[]',                      'dumbbell',   false),
('Rear Delt Fly',            'Pájaro / Deltoides Posterior','weight_reps', 'shoulders', '[]',                      'dumbbell',   false),
('Seated Shoulder Press (Machine)', 'Press Hombros Sentado (Máquina)', 'weight_reps', 'shoulders', '["triceps"]', 'machine',    false),

('Barbell Curl',             'Curl con Barra',              'weight_reps', 'biceps',    '[]',                      'barbell',    false),
('Dumbbell Curl',            'Curl con Mancuernas',         'weight_reps', 'biceps',    '[]',                      'dumbbell',   false),
('Hammer Curl',              'Curl Martillo',               'weight_reps', 'biceps',    '[]',                      'dumbbell',   false),
('Bicep Curl (Cable)',       'Curl de Bíceps (Cable)',      'weight_reps', 'biceps',    '[]',                      'cable',      false),

('Tricep Dip',               'Fondos de Tríceps',           'reps_only',   'triceps',   '["chest","shoulders"]',   'bodyweight', false),
('Seated Dip Machine',       'Máquina para Fondos Sentado', 'weight_reps', 'triceps',   '["chest","shoulders"]',   'machine',    false),
('Close Grip Bench Press',   'Press Banca Agarre Cerrado',  'weight_reps', 'triceps',   '["chest"]',               'barbell',    false),
('Triceps Pushdown',         'Tríceps con Polea',           'weight_reps', 'triceps',   '[]',                      'cable',      false),

('Plank',                    'Plancha',                     'duration_only','abdominals','[]',                      'bodyweight', false),
('Hanging Leg Raise',        'Elevación Piernas Colgado',   'reps_only',   'abdominals','[]',                      'bodyweight', false),
('Crunch (Machine)',         'Abdominal Corto (Máquina)',   'weight_reps', 'abdominals','[]',                      'machine',    false),

('Treadmill Running',        'Cinta de Correr',             'distance_duration', 'cardio', '[]',                   'machine',    false),
('Cycling',                  'Bicicleta',                   'distance_duration', 'cardio', '[]',                   'machine',    false),
('Rowing Machine',           'Máquina de Remo',             'distance_duration', 'cardio', '["back"]',             'machine',    false),
('Elliptical',               'Elíptica',                    'distance_duration', 'cardio', '[]',                   'machine',    false),

('Movilidad Cadera',         'Movilidad de Cadera',         'reps_only',   'other',     '[]',                      'none',       false),
('Flexiones Escapulares',    'Flexiones Escapulares',       'reps_only',   'other',     '[]',                      'none',       false),
('Retracción Escapular (Banda)', 'Retracción Escapular',    'reps_only',   'other',     '[]',                      'resistance_band', false),
('Manguito Rotador (Mancuerna)', 'Manguito Rotador',        'weight_reps', 'shoulders', '[]',                      'dumbbell',   false),
('Press Militar (Banda)',    'Press Militar Banda Elástica', 'reps_only',   'shoulders', '["triceps"]',             'resistance_band', false)
ON CONFLICT DO NOTHING;


-- ── 6. RLS & PUBLIC ACCESS ──

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.intakes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.weight_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.markets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shopping_lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shopping_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_prices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.routines ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workout_sets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.personal_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.feed_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.feed_reactions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public Profiles" ON public.profiles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Daily Logs" ON public.daily_logs FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Intakes" ON public.intakes FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Weights" ON public.weight_entries FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Products" ON public.products FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Markets" ON public.markets FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Shopping Lists" ON public.shopping_lists FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Shopping Items" ON public.shopping_items FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Product Prices" ON public.product_prices FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Exercises" ON public.exercises FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Routines" ON public.routines FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Workouts" ON public.workouts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Workout Sets" ON public.workout_sets FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public PRs" ON public.personal_records FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Feed Events" ON public.feed_events FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Feed Reactions" ON public.feed_reactions FOR ALL USING (true) WITH CHECK (true);

-- Habilitar Realtime para la tabla shopping_items y feed_events
ALTER PUBLICATION supabase_realtime ADD TABLE public.shopping_items;
ALTER PUBLICATION supabase_realtime ADD TABLE public.feed_events;
