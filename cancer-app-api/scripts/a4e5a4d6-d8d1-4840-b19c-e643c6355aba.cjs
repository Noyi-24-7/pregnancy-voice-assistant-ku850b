var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// cancerApp/tmp_scripts_900/a4e5a4d6-d8d1-4840-b19c-e643c6355aba_temp.ts
var a4e5a4d6_d8d1_4840_b19c_e643c6355aba_temp_exports = {};
__export(a4e5a4d6_d8d1_4840_b19c_e643c6355aba_temp_exports, {
  default: () => spitchTranscription
});
module.exports = __toCommonJS(a4e5a4d6_d8d1_4840_b19c_e643c6355aba_temp_exports);
async function spitchTranscription({
  endpoint,
  url,
  language,
  authorization,
  contentType
}, {
  logging
}) {
  try {
    let audioUrl;
    if (typeof url === "string") {
      audioUrl = url;
    } else if (typeof url === "object" && url.publicUrl) {
      audioUrl = url.publicUrl;
    } else if (typeof url === "string" && url.startsWith("{")) {
      try {
        const parsedUrl = JSON.parse(url);
        audioUrl = parsedUrl.publicUrl;
      } catch {
        audioUrl = url;
      }
    } else {
      throw new Error("Invalid URL format received");
    }
    if (!audioUrl) {
      throw new Error("Audio URL is required");
    }
    if (!language) {
      throw new Error("Language parameter is required");
    }
    if (!authorization) {
      throw new Error("Authorization token is required");
    }
    logging.log(`Transcribing audio from URL: ${audioUrl}`);
    logging.log(`Language: ${language}`);
    logging.log(`Endpoint: ${endpoint}`);
    const formData = new FormData();
    formData.append("url", audioUrl);
    formData.append("language", language);
    logging.log(`Sending FormData with url: ${audioUrl}, language: ${language}`);
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Authorization": authorization
        // DO NOT set Content-Type - let FormData handle it automatically
      },
      body: formData
      // Use FormData instead of JSON.stringify()
    });
    if (!response.ok) {
      const errorData = await response.text();
      logging.error(`Transcription failed with status: ${response.status}`);
      logging.error(`Error details: ${errorData}`);
      return {
        transcribedText: "",
        error: `Transcription failed: ${response.status} ${response.statusText}. ${errorData}`
      };
    }
    const data = await response.json();
    logging.log(`API Response: ${JSON.stringify(data)}`);
    logging.log("Transcription completed successfully");
    return {
      transcribedText: data.text || data.transcript || data.transcription || "",
      error: null
    };
  } catch (error) {
    logging.error(`Exception during transcription: ${error.message}`);
    return {
      transcribedText: "",
      error: `Transcription failed: ${error.message}`
    };
  }
}
