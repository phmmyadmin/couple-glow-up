#!/usr/bin/env node
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load env from app/.env
dotenv.config({ path: path.join(__dirname, '../app/.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL || 'https://tarkabzvlllptenatxln.supabase.co';
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY || 'sb_publishable_slCCCjjFmUxs5R1LrLiRPQ_k8Qy7RUP';

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Supabase credentials not found in app/.env');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function importHevyToSupabase() {
  const jsonPath = path.join(__dirname, '../data/hevy_workouts.json');
  if (!fs.existsSync(jsonPath)) {
    console.error(`❌ Error: File not found: ${jsonPath}`);
    process.exit(1);
  }

  const rawData = fs.readFileSync(jsonPath, 'utf-8');
  const workouts = JSON.parse(rawData);

  console.log(`🚀 Starting Direct Import of ${workouts.length} Hevy Workouts into Supabase...`);

  // 1. Get target profile_id
  const { data: profiles, error: profErr } = await supabase.from('profiles').select('id').limit(1);
  if (profErr || !profiles || !profiles.length) {
    console.error('❌ Error fetching profile from Supabase:', profErr);
    process.exit(1);
  }
  const profileId = profiles[0].id;
  console.log(`👤 Importing for profile_id: ${profileId}`);

  // 2. Cache existing exercises catalog
  const { data: existingExs } = await supabase.from('exercises').select('id, name, name_es');
  const exerciseMap = new Map();
  (existingExs || []).forEach((ex) => {
    if (ex.name) exerciseMap.set(ex.name.toLowerCase().strip ? ex.name.toLowerCase().strip() : ex.name.toLowerCase(), ex.id);
    if (ex.name_es) exerciseMap.set(ex.name_es.toLowerCase(), ex.id);
  });

  let importedWorkouts = 0;
  let importedSets = 0;

  for (let i = 0; i < workouts.length; i++) {
    const w = workouts[i];
    const wTitle = w.title || w.name || `Hevy Workout #${i + 1}`;
    
    // Format timestamp
    let startedAt = new Date().toISOString();
    if (w.start_time) {
      startedAt = typeof w.start_time === 'number' ? new Date(w.start_time * 1000).toISOString() : new Date(w.start_time).toISOString();
    }
    let finishedAt = startedAt;
    if (w.end_time) {
      finishedAt = typeof w.end_time === 'number' ? new Date(w.end_time * 1000).toISOString() : new Date(w.end_time).toISOString();
    }

    const durationMins = w.duration_minutes || 30;
    const estVol = w.estimated_volume_kg || 0;

    // Insert Workout
    const { data: workoutRow, error: wErr } = await supabase
      .from('workouts')
      .insert({
        profile_id: profileId,
        name: wTitle,
        started_at: startedAt,
        finished_at: finishedAt,
        duration_minutes: durationMins,
        estimated_volume_kg: estVol,
      })
      .select('id')
      .single();

    if (wErr) {
      console.error(`❌ Error inserting workout #${i + 1} (${wTitle}):`, wErr.message);
      continue;
    }

    importedWorkouts++;
    const workoutId = workoutRow.id;

    // Process exercises in workout
    const exList = w.exercises || w.workout_exercises || [];
    let setCounter = 0;

    for (const exItem of exList) {
      const exTitle = exItem.title || exItem.name || 'Custom Exercise';
      const normTitle = exTitle.toLowerCase().trim();

      let exerciseId = exerciseMap.get(normTitle);

      // If exercise doesn't exist, create custom exercise
      if (!exerciseId) {
        const { data: newEx, error: exErr } = await supabase
          .from('exercises')
          .insert({
            name: exTitle,
            name_es: exTitle,
            exercise_type: exItem.exercise_type || 'weight_reps',
            muscle_group: exItem.muscle_group || 'other',
            equipment_category: exItem.equipment_category || 'dumbbell',
            is_custom: true,
          })
          .select('id')
          .single();

        if (newEx) {
          exerciseId = newEx.id;
          exerciseMap.set(normTitle, exerciseId);
        }
      }

      if (!exerciseId) continue;

      const setsList = exItem.sets || [];
      const setsToInsert = [];

      for (const sItem of setsList) {
        setCounter++;
        let indicator = sItem.set_type || sItem.indicator || 'normal';
        if (!['normal', 'warmup', 'dropset', 'failure'].includes(indicator)) indicator = 'normal';

        setsToInsert.push({
          workout_id: workoutId,
          exercise_id: exerciseId,
          set_index: setCounter,
          indicator: indicator,
          weight_kg: sItem.weight_kg !== undefined && sItem.weight_kg !== null ? parseFloat(sItem.weight_kg) : null,
          reps: sItem.reps !== undefined && sItem.reps !== null ? parseInt(sItem.reps, 10) : null,
          duration_seconds: sItem.duration_seconds ? parseInt(sItem.duration_seconds, 10) : null,
          distance_meters: sItem.distance_meters ? parseFloat(sItem.distance_meters) : null,
        });
      }

      if (setsToInsert.length > 0) {
        const { data: insertedSets, error: setsErr } = await supabase
          .from('workout_sets')
          .insert(setsToInsert);

        if (!setsErr) {
          importedSets += setsToInsert.length;
        }
      }
    }

    if ((i + 1) % 20 === 0 || i === workouts.length - 1) {
      console.log(`✅ Progress: ${i + 1}/${workouts.length} workouts imported (${importedSets} sets)...`);
    }
  }

  console.log(`\n🎉 DIRECT IMPORT COMPLETE!`);
  console.log(`📊 Total Workouts Imported: ${importedWorkouts}/${workouts.length}`);
  console.log(`🏋️ Total Sets Imported: ${importedSets}`);
}

importHevyToSupabase();
