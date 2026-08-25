import React, { useState } from 'react';
import Card from '../../../shared/ui/Card';
import BODY_PATHS from '../lib/body-paths';

const INERT_PARTS = new Set(['head', 'hair', 'neck', 'hands', 'knees', 'tibialis', 'ankles', 'feet']);

const MUSCLE_NAMES = {
  chest: 'Chest',
  deltoids: 'Shoulders',
  biceps: 'Biceps',
  triceps: 'Triceps',
  abs: 'Abs / Core',
  obliques: 'Obliques',
  serratus: 'Serratus',
  'hip-flexors': 'Hip Flexors',
  'upper-back': 'Upper Back / Lats',
  trapezius: 'Traps',
  'lower-back': 'Lower Back',
  quadriceps: 'Quadriceps',
  adductors: 'Adductors',
  hamstring: 'Hamstrings',
  gluteal: 'Glutes',
  calves: 'Calves',
  forearm: 'Forearms',
};

export default function MuscleBodyHeatmap({
  activeMuscles = [],
  muscleVolumeMap = null,
  title = 'Muscles Worked',
  hideHeader = false,
}) {
  const [selectedGender, setSelectedGender] = useState('male'); // 'male' | 'female'
  const [hoveredMuscle, setHoveredMuscle] = useState(null);

  // Normalize active muscles
  const activeSet = new Set(activeMuscles.map((m) => String(m).toLowerCase().trim()));

  const getSetsForSlug = (slug) => {
    if (!muscleVolumeMap) {
      if (slug === 'chest' && (activeSet.has('chest') || activeSet.has('pecho'))) return 4;
      if (slug === 'deltoids' && (activeSet.has('shoulders') || activeSet.has('delts') || activeSet.has('hombros'))) return 4;
      if (slug === 'biceps' && (activeSet.has('biceps') || activeSet.has('bicep') || activeSet.has('arms'))) return 4;
      if (slug === 'triceps' && (activeSet.has('triceps') || activeSet.has('tricep') || activeSet.has('arms'))) return 4;
      if (slug === 'quadriceps' && (activeSet.has('quads') || activeSet.has('quadriceps') || activeSet.has('legs'))) return 4;
      if (slug === 'hamstring' && (activeSet.has('hamstrings') || activeSet.has('isquios') || activeSet.has('legs'))) return 4;
      if (slug === 'gluteal' && (activeSet.has('glutes') || activeSet.has('gluteos') || activeSet.has('legs'))) return 4;
      if (slug === 'calves' && (activeSet.has('calves') || activeSet.has('gemelos') || activeSet.has('legs'))) return 4;
      if ((slug === 'upper-back' || slug === 'trapezius' || slug === 'lower-back') && (activeSet.has('back') || activeSet.has('lats') || activeSet.has('espalda'))) return 4;
      if ((slug === 'abs' || slug === 'obliques') && (activeSet.has('abs') || activeSet.has('core'))) return 4;
      return 0;
    }

    if (slug === 'chest') return muscleVolumeMap.chest || 0;
    if (slug === 'deltoids') return muscleVolumeMap.shoulders || 0;
    if (slug === 'biceps') return muscleVolumeMap.biceps || 0;
    if (slug === 'triceps') return muscleVolumeMap.triceps || 0;
    if (slug === 'abs' || slug === 'obliques' || slug === 'serratus' || slug === 'hip-flexors') {
      return muscleVolumeMap.abs || 0;
    }
    if (slug === 'quadriceps' || slug === 'adductors') return muscleVolumeMap.quads || 0;
    if (slug === 'hamstring') return muscleVolumeMap.hamstrings || 0;
    if (slug === 'gluteal') return muscleVolumeMap.glutes || 0;
    if (slug === 'calves') return muscleVolumeMap.calves || 0;
    if (slug === 'upper-back' || slug === 'trapezius' || slug === 'lower-back') {
      return muscleVolumeMap.back || 0;
    }
    if (slug === 'forearm') return Math.round((muscleVolumeMap.biceps || 0) * 0.5);

    return 0;
  };

  const getStyleForSlug = (slug) => {
    if (INERT_PARTS.has(slug)) {
      return {
        fill: '#f1f5f9',
        stroke: '#cbd5e1',
        strokeWidth: 0.75,
      };
    }

    const sets = getSetsForSlug(slug);

    if (sets <= 0) {
      return {
        fill: '#e2e8f0',
        stroke: '#cbd5e1',
        strokeWidth: 0.8,
        cursor: 'pointer',
        transition: 'all 0.25s ease',
      };
    }

    if (sets <= 3) {
      // 1-3 sets: Light Blue
      return {
        fill: '#93c5fd',
        stroke: '#3b82f6',
        strokeWidth: 1.0,
        cursor: 'pointer',
        transition: 'all 0.25s ease',
      };
    }

    if (sets <= 6) {
      // 4-6 sets: Vibrant Blue
      return {
        fill: '#3b82f6',
        stroke: '#1d4ed8',
        strokeWidth: 1.2,
        cursor: 'pointer',
        transition: 'all 0.25s ease',
      };
    }

    if (sets <= 10) {
      // 7-10 sets: Deep Blue
      return {
        fill: '#1d4ed8',
        stroke: '#1e40af',
        strokeWidth: 1.4,
        cursor: 'pointer',
        transition: 'all 0.25s ease',
      };
    }

    // 10+ sets: Indigo / Royal
    return {
      fill: '#4338ca',
      stroke: '#312e81',
      strokeWidth: 1.6,
      cursor: 'pointer',
      transition: 'all 0.25s ease',
    };
  };

  const modelData = BODY_PATHS?.[selectedGender] || BODY_PATHS?.male;
  const frontView = modelData?.front;
  const backView = modelData?.back;

  const renderView = (view, label) => {
    if (!view) return null;
    return (
      <div className="flex flex-col items-center flex-1">
        <span className="text-[11px] font-bold tracking-wider text-slate-400 uppercase mb-1">
          {label}
        </span>
        <svg
          viewBox={view.vb}
          className="w-full max-h-[280px] drop-shadow-2xs select-none"
          role="img"
        >
          {Object.entries(view.p || {}).map(([slug, paths]) =>
            (paths || []).map((d, idx) => {
              const style = getStyleForSlug(slug);
              const isHovered = hoveredMuscle === slug;
              const sets = getSetsForSlug(slug);
              const name = MUSCLE_NAMES[slug] || slug;

              return (
                <path
                  key={`${slug}-${idx}`}
                  d={d}
                  style={{
                    ...style,
                    ...(isHovered && !INERT_PARTS.has(slug)
                      ? { fill: '#6366f1', stroke: '#4338ca', strokeWidth: 2, filter: 'drop-shadow(0 2px 4px rgba(99,102,241,0.4))' }
                      : {}),
                  }}
                  onMouseEnter={() => !INERT_PARTS.has(slug) && setHoveredMuscle(slug)}
                  onMouseLeave={() => setHoveredMuscle(null)}
                >
                  <title>{!INERT_PARTS.has(slug) ? `${name}: ${sets} set(s)` : ''}</title>
                </path>
              );
            })
          )}
        </svg>
      </div>
    );
  };

  const content = (
    <div className="space-y-3 flex flex-col justify-between h-full">
      {!hideHeader && (
        <div className="flex items-center justify-between">
          <h4 className="text-sm font-extrabold text-slate-900 flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full bg-blue-600 animate-pulse" />
            <span>{title}</span>
          </h4>
          <div className="flex bg-slate-100 p-0.5 rounded-lg text-xs font-bold text-slate-600">
            <button
              type="button"
              onClick={() => setSelectedGender('male')}
              className={`px-2 py-0.5 rounded-md transition-all cursor-pointer ${
                selectedGender === 'male' ? 'bg-white text-indigo-700 shadow-2xs font-extrabold' : 'hover:text-slate-900'
              }`}
            >
              Male
            </button>
            <button
              type="button"
              onClick={() => setSelectedGender('female')}
              className={`px-2 py-0.5 rounded-md transition-all cursor-pointer ${
                selectedGender === 'female' ? 'bg-white text-indigo-700 shadow-2xs font-extrabold' : 'hover:text-slate-900'
              }`}
            >
              Female
            </button>
          </div>
        </div>
      )}

      {/* Anatomy Body Map Rendering */}
      <div className="flex items-center justify-center gap-3 sm:gap-6 py-2 px-1 bg-gradient-to-b from-slate-50/50 to-slate-100/30 rounded-xl border border-slate-100/80">
        {renderView(frontView, 'Front')}
        <div className="w-[1px] h-48 bg-slate-200/60 self-center hidden sm:block" />
        {renderView(backView, 'Back')}
      </div>

      {/* Hovered Tooltip Card */}
      <div className="min-h-[22px] text-center text-xs">
        {hoveredMuscle && !INERT_PARTS.has(hoveredMuscle) ? (
          <span className="inline-flex items-center gap-1.5 font-bold px-2.5 py-0.5 bg-indigo-50 text-indigo-700 rounded-full border border-indigo-200/70 shadow-2xs animate-fadeIn">
            <span>🎯 {MUSCLE_NAMES[hoveredMuscle] || hoveredMuscle}:</span>
            <span className="font-extrabold">{getSetsForSlug(hoveredMuscle)} sets</span>
          </span>
        ) : (
          <span className="text-[11px] text-slate-400 font-medium">Hover or tap on any muscle group to view sets</span>
        )}
      </div>

      {/* Volume Heatmap Legend */}
      <div className="flex items-center justify-between pt-2 border-t border-slate-100 text-[10px] text-slate-500 font-bold">
        <span>0 sets</span>
        <div className="flex items-center gap-1">
          <span className="w-3.5 h-2.5 rounded-xs bg-[#e2e8f0] border border-[#cbd5e1]" title="0 sets" />
          <span className="w-3.5 h-2.5 rounded-xs bg-[#93c5fd] border border-[#3b82f6]" title="1-3 sets" />
          <span className="w-3.5 h-2.5 rounded-xs bg-[#3b82f6] border border-[#1d4ed8]" title="4-6 sets" />
          <span className="w-3.5 h-2.5 rounded-xs bg-[#1d4ed8] border border-[#1e40af]" title="7-10 sets" />
          <span className="w-3.5 h-2.5 rounded-xs bg-[#4338ca] border border-[#312e81]" title="10+ sets" />
        </div>
        <span className="text-indigo-700 font-extrabold">10+ sets</span>
      </div>
    </div>
  );

  if (hideHeader) {
    return content;
  }

  return (
    <Card className="p-4 sm:p-5 shadow-sm border border-slate-200/90 rounded-2xl bg-white">
      {content}
    </Card>
  );
}
