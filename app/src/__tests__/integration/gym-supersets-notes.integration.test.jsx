import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import LiveWorkoutLogger from '../../modules/gym/components/LiveWorkoutLogger';

// Mock WakeLock to avoid errors
vi.mock('../../lib/wake-lock', () => ({
  requestWakeLock: vi.fn(),
  releaseWakeLock: vi.fn()
}));

const localStorageMock = {
  getItem: vi.fn(),
  setItem: vi.fn(),
  clear: vi.fn(),
  removeItem: vi.fn(),
};
global.localStorage = localStorageMock;

const mockExercises = [
  { id: 'ex-1', name: 'Bench Press', exercise_type: 'weight_reps' },
  { id: 'ex-2', name: 'Push Ups', exercise_type: 'weight_reps' },
  { id: 'ex-3', name: 'Pull Ups', exercise_type: 'weight_reps' }
];

describe('Gym Supersets and Notes Integration', () => {
  describe('Supersets Logic', () => {
    it('groups exercises into superset pairs with matching superset_id', async () => {
      render(
        <LiveWorkoutLogger
          exercises={mockExercises}
          initialWorkoutState={{
            workoutExercises: [
              { id: 'item-1', exercise: mockExercises[0], sets: [{ id: 'set-1', is_checked: false }], supersetId: null },
              { id: 'item-2', exercise: mockExercises[1], sets: [{ id: 'set-2', is_checked: false }], supersetId: null },
            ]
          }}
          onSaveWorkout={vi.fn()}
          onCancel={vi.fn()}
        />
      );

      // Open context menu for first exercise
      const menuButtons = screen.getAllByTitle('Exercise Options');
      fireEvent.click(menuButtons[0]);

      // Click Link as Superset
      const linkBtn = await screen.findByText('Link as Superset');
      fireEvent.click(linkBtn);

      // Expect SS badge to appear
      const badges = await screen.findAllByText('SS');
      expect(badges.length).toBeGreaterThan(0);
    });

    it('identifies superset blocks correctly (2 exercises = 1 superset)', async () => {
      render(
        <LiveWorkoutLogger
          exercises={mockExercises}
          initialWorkoutState={{
            workoutExercises: [
              { id: 'item-1', exercise: mockExercises[0], sets: [{ id: 'set-1', is_checked: false }], supersetId: 'sup-1' },
              { id: 'item-2', exercise: mockExercises[1], sets: [{ id: 'set-2', is_checked: false }], supersetId: 'sup-1' },
            ]
          }}
          onSaveWorkout={vi.fn()}
          onCancel={vi.fn()}
        />
      );

      const badges = screen.getAllByText('SS');
      expect(badges.length).toBe(2);
    });

    it('removes superset grouping when unlinking', async () => {
      render(
        <LiveWorkoutLogger
          exercises={mockExercises}
          initialWorkoutState={{
            workoutExercises: [
              { id: 'item-1', exercise: mockExercises[0], sets: [{ id: 'set-1', is_checked: false }], supersetId: 'sup-1' },
              { id: 'item-2', exercise: mockExercises[1], sets: [{ id: 'set-2', is_checked: false }], supersetId: 'sup-1' },
            ]
          }}
          onSaveWorkout={vi.fn()}
          onCancel={vi.fn()}
        />
      );

      // Open context menu for first exercise
      const menuButtons = screen.getAllByTitle('Exercise Options');
      fireEvent.click(menuButtons[0]);

      // Click Unlink Superset
      const unlinkBtn = await screen.findByText('Unlink Superset');
      fireEvent.click(unlinkBtn);

      // Expect SS badges to disappear
      await waitFor(() => {
        expect(screen.queryByText('SS')).toBeNull();
      });
    });
  });

  describe('Exercise Notes', () => {
    it('stores and retrieves exercise-level notes', async () => {
      render(
        <LiveWorkoutLogger
          exercises={mockExercises}
          initialWorkoutState={{
            workoutExercises: [
              { id: 'item-1', exercise: mockExercises[0], sets: [{ id: 'set-1', is_checked: false }], notes: '' },
            ]
          }}
          onSaveWorkout={vi.fn()}
          onCancel={vi.fn()}
        />
      );

      // Click notes toggle
      const notesToggle = screen.getByTitle('Toggle Notes');
      fireEvent.click(notesToggle);

      // Type a note
      const textArea = screen.getByPlaceholderText('Add notes for this exercise...');
      fireEvent.change(textArea, { target: { value: 'Seat height 4' } });

      expect(textArea.value).toBe('Seat height 4');
    });

    it('saves notes as empty string when cleared', async () => {
      render(
        <LiveWorkoutLogger
          exercises={mockExercises}
          initialWorkoutState={{
            workoutExercises: [
              { id: 'item-1', exercise: mockExercises[0], sets: [{ id: 'set-1', is_checked: false }], notes: 'Previous note' },
            ]
          }}
          onSaveWorkout={vi.fn()}
          onCancel={vi.fn()}
        />
      );

      // Click notes toggle
      const notesToggle = screen.getByTitle('Toggle Notes');
      fireEvent.click(notesToggle);

      // Clear note
      const textArea = screen.getByPlaceholderText('Add notes for this exercise...');
      expect(textArea.value).toBe('Previous note');
      
      fireEvent.change(textArea, { target: { value: '' } });
      expect(textArea.value).toBe('');
    });

    it('preserves notes across set additions', async () => {
      render(
        <LiveWorkoutLogger
          exercises={mockExercises}
          initialWorkoutState={{
            workoutExercises: [
              { id: 'item-1', exercise: mockExercises[0], sets: [{ id: 'set-1', is_checked: false }], notes: 'Seat height 4' },
            ]
          }}
          onSaveWorkout={vi.fn()}
          onCancel={vi.fn()}
        />
      );

      // Click notes toggle
      const notesToggle = screen.getByTitle('Toggle Notes');
      fireEvent.click(notesToggle);

      const textArea = screen.getByPlaceholderText('Add notes for this exercise...');
      expect(textArea.value).toBe('Seat height 4');

      // Add a set
      const addSetBtn = screen.getByText('Add Set');
      fireEvent.click(addSetBtn);

      // Note should still be there
      expect(textArea.value).toBe('Seat height 4');
    });
  });
});
