import { describe, it, expect, vi, beforeEach } from 'vitest';
import {
  saveRoutineToSupabase,
  fetchRoutinesFromSupabase,
  deleteRoutineFromSupabase,
} from '../../modules/gym/lib/supabase-gym';
import { supabase } from '../../lib/supabase';

describe('Supabase Routine Persistence Integration', () => {
  const validUUID = '83cfc58c-3a9f-478c-8d77-d7585edbf9a0';
  const profileUUID = '0913bf0f-8606-4dea-9db1-1842be5b7b5f';

  it('omits null/undefined id on insert to let database generate valid UUID', async () => {
    const rawRoutine = {
      id: null,
      profile_id: profileUUID,
      name: 'Leg Day Blast',
      description: 'Quads and hamstrings',
      color: '#10b981',
      exercises: [
        {
          exercise_id: 'ex-squat',
          target_sets: 4,
          target_reps: 10,
        },
      ],
    };

    const saved = await saveRoutineToSupabase(rawRoutine);
    expect(saved).not.toBeNull();
    expect(saved.id).toBeDefined();
    expect(saved.name).toBe('Leg Day Blast');
    expect(saved.profile_id).toBe(profileUUID);

    // Clean up created routine
    if (saved.id && saved.id !== 'mock-id') {
      await deleteRoutineFromSupabase(saved.id);
    }
  });

  it('updates an existing routine when a valid UUID is provided', async () => {
    // 1. Create a routine
    const created = await saveRoutineToSupabase({
      profile_id: profileUUID,
      name: 'Push Day A',
      description: 'Chest & Delts',
      color: '#ef4444',
      exercises: [],
    });

    expect(created).not.toBeNull();
    const routineId = created.id;

    // 2. Update that routine
    const updated = await saveRoutineToSupabase({
      id: routineId,
      profile_id: profileUUID,
      name: 'Push Day A (Updated)',
      description: 'Chest, Delts & Triceps',
      color: '#ef4444',
      exercises: [],
    });

    expect(updated).not.toBeNull();
    expect(updated.id).toBe(routineId);
    expect(updated.name).toBe('Push Day A (Updated)');

    // 3. Delete it
    const deleted = await deleteRoutineFromSupabase(routineId);
    expect(deleted).toBe(true);
  });

  it('safely handles deleteRoutineFromSupabase for temporary local non-UUID ids', async () => {
    const localId = '1729074000000';
    const result = await deleteRoutineFromSupabase(localId);
    expect(result).toBe(true);
  });

  it('fetches existing routines from Supabase without throwing errors', async () => {
    const routines = await fetchRoutinesFromSupabase(profileUUID);
    expect(Array.isArray(routines)).toBe(true);
  });
});
