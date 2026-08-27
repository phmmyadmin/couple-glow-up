import React, { useState, useRef, useEffect } from 'react';
import {
  Download,
  Upload,
  FileSpreadsheet,
  Check,
  AlertCircle,
  X,
  Database,
  ArrowRight,
  Loader2,
} from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import {
  exportFullAppData,
  importFullAppData,
  parseHevyCsv,
  parseStrongCsv,
} from '../lib/data-importers';

export default function DataPortabilityModal({
  isOpen,
  onClose,
  dataContext = {},
  onImportWorkouts,
  onRestoreBackup,
  setToastMessage,
}) {
  const [activeTab, setActiveTab] = useState('export'); // 'export' | 'import'
  const [importSource, setImportSource] = useState('hevy'); // 'hevy' | 'strong' | 'json'
  const [previewData, setPreviewData] = useState(null);
  const [isProcessing, setIsProcessing] = useState(false);
  const fileInputRef = useRef(null);

  // ESC key listener to close modal
  useEffect(() => {
    if (!isOpen) return;
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  // 1. Export JSON
  const handleExportJSON = () => {
    try {
      const payload = exportFullAppData(dataContext);
      const dataStr = 'data:text/json;charset=utf-8,' + encodeURIComponent(JSON.stringify(payload, null, 2));
      const downloadAnchor = document.createElement('a');
      downloadAnchor.setAttribute('href', dataStr);
      const filename = `openfit-backup-${new Date().toISOString().slice(0, 10)}.json`;
      downloadAnchor.setAttribute('download', filename);
      document.body.appendChild(downloadAnchor);
      downloadAnchor.click();
      downloadAnchor.remove();

      if (setToastMessage) {
        setToastMessage(`📦 Backup downloaded: ${filename}`);
      }
    } catch (err) {
      console.error('Export error:', err);
      if (setToastMessage) setToastMessage('⚠️ Failed to export backup.');
    }
  };

  // 2. Handle File Upload
  const handleFileChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setIsProcessing(true);
    const reader = new FileReader();

    reader.onload = (event) => {
      try {
        const content = event.target.result;

        if (importSource === 'json') {
          const result = importFullAppData(content);
          if (!result.isValid) {
            alert(`Invalid JSON Backup: ${result.error}`);
            setIsProcessing(false);
            return;
          }
          setPreviewData({
            type: 'json',
            version: result.version,
            exportDate: result.exportDate,
            workoutsCount: result.data.workouts?.length || 0,
            routinesCount: result.data.routines?.length || 0,
            exercisesCount: result.data.exercises?.length || 0,
            rawPayload: result.data,
          });
        } else {
          // CSV (Hevy or Strong)
          const parser = importSource === 'hevy' ? parseHevyCsv : parseStrongCsv;
          const result = parser(content, dataContext.exercises || []);

          if (!result.workouts || result.workouts.length === 0) {
            alert('No valid workouts found in the CSV file.');
            setIsProcessing(false);
            return;
          }

          const totalSets = result.workouts.reduce(
            (acc, w) => acc + w.workout_exercises.reduce((sAcc, e) => sAcc + e.sets.length, 0),
            0
          );

          setPreviewData({
            type: 'csv',
            source: importSource,
            workoutsCount: result.workouts.length,
            totalSets,
            workouts: result.workouts,
          });
        }
      } catch (err) {
        console.error('Import processing error:', err);
        alert(`Error reading file: ${err.message}`);
      } finally {
        setIsProcessing(false);
      }
    };

    reader.readAsText(file);
  };

  // 3. Confirm Import
  const handleConfirmImport = async () => {
    if (!previewData) return;

    setIsProcessing(true);
    try {
      if (previewData.type === 'json' && onRestoreBackup) {
        await onRestoreBackup(previewData.rawPayload);
        if (setToastMessage) setToastMessage('✨ JSON Backup restored successfully!');
      } else if (previewData.type === 'csv' && onImportWorkouts) {
        await onImportWorkouts(previewData.workouts);
        if (setToastMessage) {
          setToastMessage(`🎉 Imported ${previewData.workoutsCount} workouts (${previewData.totalSets} sets)!`);
        }
      }
      onClose();
    } catch (err) {
      console.error('Error confirming import:', err);
      if (setToastMessage) setToastMessage('⚠️ Import failed: ' + err.message);
    } finally {
      setIsProcessing(false);
    }
  };

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={onClose}
    >
      <Card
        className="w-full max-w-lg max-h-[90vh] flex flex-col p-5 sm:p-6 shadow-2xl border-slate-700/80 bg-white"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-center justify-between border-b border-slate-100 pb-4">
          <div className="flex items-center gap-2.5">
            <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
              <Database className="w-5 h-5" />
            </div>
            <div>
              <CardTitle className="text-lg">Data Backup & Portability</CardTitle>
              <p className="text-xs text-slate-500 font-medium">
                Import from Hevy / Strong or export your full OpenFit database.
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="p-1.5 text-slate-400 hover:text-slate-600 rounded-xl hover:bg-slate-100 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Tab Switcher */}
        <div className="flex bg-slate-100 p-1 rounded-2xl my-4 text-xs font-bold">
          <button
            type="button"
            onClick={() => {
              setActiveTab('export');
              setPreviewData(null);
            }}
            className={`flex-1 py-2 rounded-xl transition-all flex items-center justify-center gap-1.5 ${
              activeTab === 'export'
                ? 'bg-white text-indigo-600 shadow-xs'
                : 'text-slate-500 hover:text-slate-800'
            }`}
          >
            <Download className="w-3.5 h-3.5" />
            <span>Export Backup (JSON)</span>
          </button>
          <button
            type="button"
            onClick={() => {
              setActiveTab('import');
              setPreviewData(null);
            }}
            className={`flex-1 py-2 rounded-xl transition-all flex items-center justify-center gap-1.5 ${
              activeTab === 'import'
                ? 'bg-white text-indigo-600 shadow-xs'
                : 'text-slate-500 hover:text-slate-800'
            }`}
          >
            <Upload className="w-3.5 h-3.5" />
            <span>Import Data (Hevy / Strong)</span>
          </button>
        </div>

        {/* Tab Content */}
        <div className="overflow-y-auto flex-1 space-y-4 pr-1">
          {activeTab === 'export' && (
            <div className="space-y-4 py-2">
              <div className="p-4 bg-slate-50 rounded-2xl border border-slate-200 text-xs text-slate-600 space-y-2">
                <div className="font-bold text-slate-800 flex items-center gap-1.5">
                  <Check className="w-4 h-4 text-emerald-600" />
                  <span>Everything included in your backup:</span>
                </div>
                <ul className="list-disc pl-5 space-y-1 font-medium text-slate-500">
                  <li>{dataContext.workouts?.length || 0} Workouts & Live Sets</li>
                  <li>{dataContext.routines?.length || 0} Custom Routines</li>
                  <li>{dataContext.personalRecords?.length || 0} Personal Records (PRs)</li>
                  <li>{dataContext.dailyLogs?.length || 0} Daily Food Diary Logs</li>
                  <li>{dataContext.dishes?.length || 0} Meal Prep Custom Dishes</li>
                  <li>{dataContext.weightLogs?.length || 0} Weight Logs</li>
                </ul>
              </div>

              <Button
                variant="primary"
                size="lg"
                icon={Download}
                onClick={handleExportJSON}
                className="w-full justify-center shadow-md font-bold"
              >
                Download Full JSON Backup
              </Button>
            </div>
          )}

          {activeTab === 'import' && (
            <div className="space-y-4 py-2">
              {/* Import Source Selector */}
              <div className="space-y-1.5">
                <label className="text-xs font-bold text-slate-700">Choose Source Format:</label>
                <div className="grid grid-cols-3 gap-2">
                  {[
                    { id: 'hevy', label: 'Hevy CSV', icon: FileSpreadsheet },
                    { id: 'strong', label: 'Strong CSV', icon: FileSpreadsheet },
                    { id: 'json', label: 'OpenFit JSON', icon: Database },
                  ].map((src) => (
                    <button
                      key={src.id}
                      type="button"
                      onClick={() => {
                        setImportSource(src.id);
                        setPreviewData(null);
                      }}
                      className={`p-3 rounded-2xl border text-xs font-bold transition-all flex flex-col items-center gap-1.5 ${
                        importSource === src.id
                          ? 'border-indigo-500 bg-indigo-50/60 text-indigo-700 shadow-xs'
                          : 'border-slate-200 bg-slate-50 text-slate-600 hover:bg-slate-100'
                      }`}
                    >
                      <src.icon className="w-4 h-4" />
                      <span>{src.label}</span>
                    </button>
                  ))}
                </div>
              </div>

              {/* Hidden file input */}
              <input
                ref={fileInputRef}
                type="file"
                accept={importSource === 'json' ? '.json' : '.csv,.txt'}
                onChange={handleFileChange}
                className="hidden"
              />

              {!previewData ? (
                <div
                  onClick={() => fileInputRef.current?.click()}
                  className="border-2 border-dashed border-slate-300 hover:border-indigo-400 p-8 rounded-2xl text-center cursor-pointer transition-colors bg-slate-50/50 hover:bg-indigo-50/20 space-y-2"
                >
                  <Upload className="w-8 h-8 text-indigo-500 mx-auto" />
                  <div className="text-xs font-bold text-slate-700">
                    Click to select {importSource.toUpperCase()} file
                  </div>
                  <p className="text-[11px] text-slate-400 font-medium">
                    {importSource === 'hevy' && 'Export CSV from Hevy App -> Settings -> Export Data'}
                    {importSource === 'strong' && 'Export CSV from Strong App -> Settings -> Export'}
                    {importSource === 'json' && 'Select previously exported openfit-backup.json file'}
                  </p>
                </div>
              ) : (
                /* Import Preview Card */
                <div className="p-4 bg-indigo-50/60 rounded-2xl border border-indigo-200 space-y-3 animate-in fade-in duration-200">
                  <div className="flex items-center justify-between">
                    <span className="text-xs font-bold text-indigo-900 flex items-center gap-1.5">
                      <Check className="w-4 h-4 text-emerald-600" />
                      <span>File Validated & Ready!</span>
                    </span>
                    <button
                      type="button"
                      onClick={() => setPreviewData(null)}
                      className="text-[11px] text-slate-500 hover:text-slate-800 underline font-semibold"
                    >
                      Change file
                    </button>
                  </div>

                  <div className="grid grid-cols-2 gap-2 text-xs font-medium text-slate-700 bg-white p-3 rounded-xl border border-indigo-100">
                    {previewData.type === 'csv' && (
                      <>
                        <div>Workouts: <strong>{previewData.workoutsCount}</strong></div>
                        <div>Total Sets: <strong>{previewData.totalSets}</strong></div>
                      </>
                    )}
                    {previewData.type === 'json' && (
                      <>
                        <div>Workouts: <strong>{previewData.workoutsCount}</strong></div>
                        <div>Routines: <strong>{previewData.routinesCount}</strong></div>
                      </>
                    )}
                  </div>

                  <Button
                    variant="primary"
                    size="md"
                    onClick={handleConfirmImport}
                    disabled={isProcessing}
                    className="w-full justify-center shadow-md font-bold"
                  >
                    {isProcessing ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      <>
                        <span>Confirm & Import Data</span>
                        <ArrowRight className="w-4 h-4" />
                      </>
                    )}
                  </Button>
                </div>
              )}
            </div>
          )}
        </div>
      </Card>
    </div>
  );
}
