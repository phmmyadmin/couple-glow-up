import React from 'react';

export default function Button({
  children,
  variant = 'primary', // 'primary', 'secondary', 'outline', 'ghost', 'danger'
  size = 'md', // 'sm', 'md', 'lg'
  icon: Icon,
  className = '',
  disabled = false,
  type = 'button',
  onClick,
  ...props
}) {
  const baseClasses =
    'inline-flex items-center justify-center font-semibold rounded-xl transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 active:scale-[0.98] disabled:opacity-50 disabled:pointer-events-none disabled:active:scale-100';

  const variantClasses = {
    primary: 'bg-indigo-600 hover:bg-indigo-700 text-white shadow-sm hover:shadow-indigo-500/10',
    secondary: 'bg-indigo-50 hover:bg-indigo-100 text-indigo-700 border border-indigo-200/80',
    outline: 'bg-white hover:bg-slate-50 text-slate-700 border border-slate-200 shadow-sm',
    ghost: 'bg-transparent hover:bg-slate-100 text-slate-600 hover:text-slate-900',
    danger: 'bg-rose-50 hover:bg-rose-100 text-rose-600 border border-rose-200/80',
  };

  const sizeClasses = {
    sm: 'text-xs px-3 py-2 gap-2 rounded-xl',
    md: 'text-xs sm:text-sm px-4 py-2.5 sm:py-3 gap-2 rounded-xl',
    lg: 'text-sm sm:text-base px-6 py-3.5 gap-2.5 rounded-2xl',
  };

  return (
    <button
      type={type}
      disabled={disabled}
      onClick={onClick}
      className={`${baseClasses} ${variantClasses[variant] || variantClasses.primary} ${
        sizeClasses[size] || sizeClasses.md
      } ${className}`}
      {...props}
    >
      {Icon && <Icon className="w-4 h-4 sm:w-5 sm:h-5 shrink-0" />}
      {children && <span>{children}</span>}
    </button>
  );
}
