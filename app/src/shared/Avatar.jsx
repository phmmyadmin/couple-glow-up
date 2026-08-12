import React from 'react';

export default function Avatar({ profile, size = 'md', className = '' }) {
  const sizeClasses = {
    sm: 'w-7 h-7 text-xs',
    md: 'w-9 h-9 text-sm',
    lg: 'w-12 h-12 text-base',
  };

  const initial = profile?.name ? profile.name.charAt(0).toUpperCase() : '?';
  const isFemale = profile?.gender === 'female';

  const gradientClass = isFemale
    ? 'bg-gradient-to-tr from-rose-500 to-amber-400'
    : 'bg-gradient-to-tr from-indigo-600 to-teal-400';

  if (profile?.avatar_url) {
    return (
      <img
        src={profile.avatar_url}
        alt={profile.name}
        className={`${sizeClasses[size]} rounded-full object-cover ring-2 ring-white/20 ${className}`}
      />
    );
  }

  return (
    <div
      className={`${sizeClasses[size]} rounded-full ${gradientClass} flex items-center justify-center font-bold text-white shadow-md ring-2 ring-white/10 ${className}`}
    >
      {initial}
    </div>
  );
}
