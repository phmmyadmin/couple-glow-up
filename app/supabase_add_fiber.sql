-- ============================================================================
-- ADD FIBER TRACKING TO FIT TRACKER IN SUPABASE
-- ============================================================================

-- 1. Añadir columna fiber a la tabla intakes
ALTER TABLE public.intakes 
ADD COLUMN IF NOT EXISTS fiber NUMERIC DEFAULT 0;

-- 2. Añadir columna fiber a la tabla daily_logs
ALTER TABLE public.daily_logs 
ADD COLUMN IF NOT EXISTS fiber NUMERIC DEFAULT 0;
