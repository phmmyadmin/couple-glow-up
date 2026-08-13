import React, { useState, useEffect, useRef } from 'react';
import { Send, Loader2, Mic, MicOff } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { parseFoodWithGemini } from '../lib/gemini';
import { parseFoodTextLocal } from '../lib/parser';
import { saveIntakesToSupabase, fetchDailyLogsFromSupabase } from '../lib/supabase';

export default function ChatInputBar({
  selectedDate,
  data,
  setData,
  activeProfileId,
  isLoading,
  setIsLoading,
  setToastMessage,
  onSendFood,
}) {
  const { t, i18n } = useTranslation();
  const [text, setText] = useState('');
  const [isListening, setIsListening] = useState(false);
  const recognitionRef = useRef(null);

  useEffect(() => {
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (SpeechRecognition) {
      const recognition = new SpeechRecognition();
      recognition.continuous = false;
      recognition.interimResults = true;

      recognition.onresult = (event) => {
        let transcript = '';
        for (let i = event.resultIndex; i < event.results.length; i++) {
          transcript += event.results[i][0].transcript;
        }
        setText(transcript);
      };

      recognition.onerror = () => setIsListening(false);
      recognition.onend = () => setIsListening(false);
      recognitionRef.current = recognition;
    }
  }, []);

  const toggleListening = () => {
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SpeechRecognition) {
      alert(
        i18n.language.startsWith('es')
          ? 'Tu navegador no soporta el reconocimiento de voz. Prueba Google Chrome.'
          : 'Your browser does not support speech recognition. Try Google Chrome.'
      );
      return;
    }

    if (isListening) {
      recognitionRef.current?.stop();
      setIsListening(false);
    } else {
      try {
        recognitionRef.current.lang = i18n.language.startsWith('es') ? 'es-ES' : 'en-US';
        recognitionRef.current.start();
        setIsListening(true);
      } catch (err) {
        console.error('Error starting recognition:', err);
      }
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const foodText = text.trim();
    if (!foodText || isLoading) return;

    if (typeof setIsLoading === 'function') setIsLoading(true);

    try {
      if (typeof onSendFood === 'function') {
        await onSendFood(foodText);
        setText('');
        return;
      }

      // Send direct to AI (Gemini) with local parser fallback
      let parsedItems = await parseFoodWithGemini(foodText);
      if (!parsedItems || parsedItems.length === 0) {
        parsedItems = parseFoodTextLocal(foodText);
      }

      if (!parsedItems || parsedItems.length === 0) {
        if (typeof setToastMessage === 'function') {
          setToastMessage(t('toast.couldNotParse', 'Could not parse food item'));
        }
        return;
      }

      const timestamp = new Date().toTimeString().slice(0, 5);
      const formattedItems = parsedItems.map((item, idx) => ({
        id: 'intake-' + Date.now() + '-' + idx,
        timestamp,
        raw_text: item.name,
        parsed_name: item.name,
        dish_name: item.dishName || null,
        portion_qty: item.quantity || 1,
        unit: item.unit || 'ud',
        category: item.category || 'other',
        macros: {
          calories: item.calories || 0,
          protein: item.protein || 0,
          carbs: item.carbs || 0,
          fats: item.fats || 0,
        },
      }));

      const targetDate = selectedDate || new Date().toISOString().slice(0, 10);

      if (activeProfileId) {
        const result = await saveIntakesToSupabase({
          date: targetDate,
          items: formattedItems,
          profileId: activeProfileId,
        });

        if (result && result.success) {
          const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
          if (freshData && typeof setData === 'function') {
            setData(freshData);
          }
        }
      } else if (typeof setData === 'function' && data) {
        const updatedLogs = [...(data.dailyLogs || [])];
        const dayIdx = updatedLogs.findIndex((l) => l.date === targetDate);

        if (dayIdx >= 0) {
          const existingIntakes = updatedLogs[dayIdx].intakes || [];
          updatedLogs[dayIdx] = {
            ...updatedLogs[dayIdx],
            intakes: [...existingIntakes, ...formattedItems],
          };
        } else {
          updatedLogs.push({
            date: targetDate,
            intakes: formattedItems,
            dailyTotals: { calories: 0, protein: 0, carbs: 0, fats: 0 },
          });
        }

        setData({
          ...data,
          dailyLogs: updatedLogs,
        });
      }

      const foodNames = formattedItems.map((i) => i.parsed_name).join(', ');
      if (typeof setToastMessage === 'function') {
        setToastMessage(t('toast.foodLogged', `🥗 Logged: ${foodNames}`));
      }
      setText('');
    } catch (err) {
      console.error('Error logging food:', err);
      if (typeof setToastMessage === 'function') {
        setToastMessage(t('toast.errorLoggingFood', 'Error logging food item'));
      }
    } finally {
      if (typeof setIsLoading === 'function') setIsLoading(false);
    }
  };

  return (
    <div className="chat-bar-container">
      <form onSubmit={handleSubmit} className="chat-bar-form">
        <div className="chat-input-wrapper">
          <input
            type="text"
            value={text}
            onChange={(e) => setText(e.target.value)}
            placeholder={
              isListening 
                ? (i18n.language.startsWith('es') ? 'Escuchando tu voz...' : 'Listening to your voice...') 
                : t('chat.placeholder')
            }
            disabled={isLoading}
            className="chat-text-input"
          />

          <button
            type="button"
            onClick={toggleListening}
            title={isListening ? 'Detener micrófono' : 'Dictar por voz'}
            className={`chat-mic-btn ${isListening ? 'listening' : ''}`}
          >
            {isListening ? <MicOff size={18} /> : <Mic size={18} />}
          </button>

          <button
            type="submit"
            disabled={!text.trim() && !isLoading}
            className={`chat-send-btn ${isLoading ? 'loading' : ''}`}
          >
            {isLoading ? <Loader2 className="spin animate-spin" size={18} style={{ animation: 'spin 1s linear infinite' }} /> : <Send size={18} />}
          </button>
        </div>
      </form>

      <style>{`
        .chat-bar-container {
          position: fixed;
          bottom: 1.5rem;
          left: 50%;
          transform: translateX(-50%);
          width: calc(100% - 2rem);
          max-width: 720px;
          z-index: 100;
        }

        .chat-bar-form {
          width: 100%;
        }

        .chat-input-wrapper {
          display: flex;
          align-items: center;
          background: var(--bg-surface);
          border: 1px solid var(--border-light);
          box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
          border-radius: 24px;
          padding: 0.5rem 0.75rem 0.5rem 1.25rem;
          gap: 0.5rem;
          transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .chat-input-wrapper:focus-within {
          border-color: var(--color-indigo);
          box-shadow: 0 8px 30px rgba(99, 102, 241, 0.2);
        }

        .chat-text-input {
          flex: 1;
          border: none;
          background: transparent;
          font-size: 0.95rem;
          font-family: var(--font-body);
          color: var(--text-main);
          outline: none;
        }

        .chat-mic-btn {
          background: transparent;
          color: var(--text-muted);
          border: none;
          border-radius: 50%;
          width: 36px;
          height: 36px;
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: pointer;
          transition: all 0.2s ease;
          flex-shrink: 0;
        }

        .chat-mic-btn:hover {
          background: var(--bg-subtle);
          color: var(--color-indigo);
        }

        .chat-mic-btn.listening {
          background: var(--color-calories);
          color: #FFF;
          animation: pulse 1.5s infinite;
        }

        .chat-send-btn {
          background: var(--color-indigo);
          color: #FFF;
          border: none;
          border-radius: 50%;
          width: 38px;
          height: 38px;
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: pointer;
          transition: all 0.2s ease;
          flex-shrink: 0;
          box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .chat-send-btn:hover:not(:disabled) {
          transform: scale(1.05);
          background: #4f46e5;
        }

        .chat-send-btn:disabled:not(.loading) {
          opacity: 0.5;
          cursor: not-allowed;
          box-shadow: none;
        }

        .chat-send-btn.loading {
          opacity: 1 !important;
          cursor: wait !important;
          background: var(--color-indigo) !important;
          box-shadow: 0 0 12px rgba(99, 102, 241, 0.6) !important;
        }

        @keyframes pulse {
          0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4); }
          70% { transform: scale(1.08); box-shadow: 0 0 0 10px rgba(239, 68, 68, 0); }
          100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
        }
      `}</style>
    </div>
  );
}
