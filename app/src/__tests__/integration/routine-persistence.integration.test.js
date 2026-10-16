import { describe, it, expect, vi, beforeEach } from 'vitest';

const { mockQueryBuilder, tracker } = vi.hoisted(() => {
  const tracker = {
    mockInserted: null,
    mockUpdated: null,
    mockDeletedId: null,
  };

  const mockQueryBuilder = {
    select: vi.fn(),
    insert: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
    eq: vi.fn(),
    or: vi.fn(),
    order: vi.fn(),
  };

  return { mockQueryBuilder, tracker };
});

vi.mock('../../lib/supabase', () => ({
  supabase: {
    from: vi.fn(() => mockQueryBuilder),
  },
  SUPABASE_SCHEMA: 'fit',
}));

import {
  saveRoutineToSupabase,
  fetchRoutinesFromSupabase,
  deleteRoutineFromSupabase,
} from '../../modules/gym/lib/supabase-gym';

describe('Supabase Routine Persistence Integration', () => {
  const validUUID = '83cfc58c-3a9f-478c-8d77-d7585edbf9a0';
  const profileUUID = '0913bf0f-8606-4dea-9db1-1842be5b7b5f';

  beforeEach(() => {
    tracker.mockInserted = null;
    tracker.mockUpdated = null;
    tracker.mockDeletedId = null;
    vi.clearAllMocks();

    mockQueryBuilder.select.mockReturnValue(mockQueryBuilder);
    mockQueryBuilder.eq.mockReturnValue(mockQueryBuilder);
    mockQueryBuilder.or.mockReturnValue(mockQueryBuilder);

    mockQueryBuilder.insert.mockImplementation((payload) => {
      tracker.mockInserted = payload;
      return {
        select: vi.fn().mockReturnValue({
          single: vi.fn().mockResolvedValue({
            data: { ...payload, id: validUUID },
            error: null,
          }),
        }),
      };
    });

    mockQueryBuilder.update.mockImplementation((payload) => {
      tracker.mockUpdated = payload;
      return {
        eq: vi.fn().mockImplementation((col, val) => ({
          select: vi.fn().mockReturnValue({
            single: vi.fn().mockResolvedValue({
              data: { ...payload, id: val },
              error: null,
            }),
          }),
        })),
      };
    });

    mockQueryBuilder.delete.mockImplementation(() => ({
      eq: vi.fn().mockImplementation((col, val) => {
        tracker.mockDeletedId = val;
        return Promise.resolve({ error: null });
      }),
    }));

    mockQueryBuilder.order.mockResolvedValue({
      data: [{ id: validUUID, name: 'Legs' }],
      error: null,
    });
  });

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
    expect(saved.id).toBe(validUUID);
    expect(saved.name).toBe('Leg Day Blast');
    expect(saved.profile_id).toBe(profileUUID);

    // Crucial: id must NOT be present in insert payload to prevent NOT NULL constraint violation
    expect(tracker.mockInserted).not.toBeNull();
    expect(tracker.mockInserted.id).toBeUndefined();
    expect(tracker.mockInserted.name).toBe('Leg Day Blast');
  });

  it('updates an existing routine when a valid UUID is provided', async () => {
    const updated = await saveRoutineToSupabase({
      id: validUUID,
      profile_id: profileUUID,
      name: 'Push Day A (Updated)',
      description: 'Chest, Delts & Triceps',
      color: '#ef4444',
      exercises: [],
    });

    expect(updated).not.toBeNull();
    expect(updated.id).toBe(validUUID);
    expect(tracker.mockUpdated).not.toBeNull();
    expect(tracker.mockUpdated.name).toBe('Push Day A (Updated)');
    expect(tracker.mockUpdated.updated_at).toBeDefined();
  });

  it('safely handles deleteRoutineFromSupabase for temporary local non-UUID ids without database calls', async () => {
    const localId = '1729074000000';
    const result = await deleteRoutineFromSupabase(localId);
    expect(result).toBe(true);
    expect(tracker.mockDeletedId).toBeNull();
  });

  it('calls delete with valid UUID', async () => {
    const result = await deleteRoutineFromSupabase(validUUID);
    expect(result).toBe(true);
    expect(tracker.mockDeletedId).toBe(validUUID);
  });

  it('fetches existing routines from Supabase including shared templates', async () => {
    const routines = await fetchRoutinesFromSupabase(profileUUID);
    expect(Array.isArray(routines)).toBe(true);
    expect(routines.length).toBe(1);
    expect(mockQueryBuilder.or).toHaveBeenCalledWith(
      `profile_id.eq.${profileUUID},profile_id.is.null`
    );
  });
});
