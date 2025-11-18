// Minimal node definitions for workflow execution
// The actual script implementations are in the scripts/ directory
export const nodes = [
  { id: "e25c9a7a-7e2d-492f-90d8-6e1139f8a67f", type: "script", label: "Upload Input Audio to Storage" },
  { id: "42b28296-d752-466b-83ce-c6de14f5b35b", type: "script", label: "Convert M4A to MP3" },
  { id: "ba67b2a1-66c2-4144-9144-9914ffb7cff1", type: "script", label: "Download & Re-upload" },
  { id: "a4e5a4d6-d8d1-4840-b19c-e643c6355aba", type: "script", label: "Transcribe Audio with Spitch" },
  { id: "df983403-6ae0-4c73-b3d9-ebd04bb4749e", type: "script", label: "Translate Question to English" },
  { id: "7109623e-7391-4041-a33d-6b1df67b4dc8", type: "script", label: "Process Medical Question with Gemma" },
  { id: "da94dcb4-fa62-4c27-a358-dea9442734d3", type: "script", label: "Clean Medical Response" },
  { id: "926cd33f-5c23-400b-afd7-898c3ec80c45", type: "script", label: "Translate Response Back to User Language" },
  { id: "10bbb0ce-10d6-4d2c-b336-3ca2b69a40c9", type: "script", label: "Select Voice for Synthesis" },
  { id: "c501951c-0d3f-4e37-9480-6770735f2be3", type: "script", label: "Synthesize Speech with Spitch" },
  { id: "5a085e0a-807a-49b2-804f-99feba62dd86", type: "script", label: "Upload Synthesized Audio to Storage" },
  { id: "ce5e43fd-fca6-4ce4-9178-886c5cec2bb7", type: "script", label: "Build Output JSON" },
  { id: "67567c20-ac80-46aa-8234-b9c096ac81b6", type: "output", label: "Outputs" }
];
