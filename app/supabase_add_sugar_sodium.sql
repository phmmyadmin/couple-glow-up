-- ============================================================================
-- ADD SUGAR & SODIUM TRACKING TO FIT TRACKER IN SUPABASE
-- ============================================================================

-- 1. Añadir columnas sugar (g) y sodium (mg) a la tabla intakes
ALTER TABLE public.intakes 
ADD COLUMN IF NOT EXISTS sugar NUMERIC DEFAULT 0,
ADD COLUMN IF NOT EXISTS sodium NUMERIC DEFAULT 0;

-- 2. Añadir columnas sugar (g) y sodium (mg) a la tabla daily_logs
ALTER TABLE public.daily_logs 
ADD COLUMN IF NOT EXISTS sugar NUMERIC DEFAULT 0,
ADD COLUMN IF NOT EXISTS sodium NUMERIC DEFAULT 0;
