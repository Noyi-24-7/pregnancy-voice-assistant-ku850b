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

// cancerApp/tmp_scripts_900/926cd33f-5c23-400b-afd7-898c3ec80c45_temp.ts
var cd33f_5c23_400b_afd7_898c3ec80c45_temp_exports = {};
__export(cd33f_5c23_400b_afd7_898c3ec80c45_temp_exports, {
  default: () => spitchTranslate
});
module.exports = __toCommonJS(cd33f_5c23_400b_afd7_898c3ec80c45_temp_exports);
async function spitchTranslate({
  endpoint,
  text,
  source,
  target,
  authorization,
  contentType
}, {
  logging
}) {
  try {
    logging.log(`=== TRANSLATION DEBUG INFO ===`);
    logging.log(`Source language: ${source}`);
    logging.log(`Target language: ${target}`);
    logging.log(`Text to translate: ${text}`);
    logging.log(`Endpoint: ${endpoint}`);
    if (!text) {
      throw new Error("No text provided for translation");
    }
    if (!source) {
      throw new Error("Source language not specified");
    }
    if (!target) {
      throw new Error("Target language not specified");
    }
    if (source === target) {
      logging.log("Source and target languages are the same, skipping translation");
      return {
        translatedText: text,
        // Return original text unchanged
        error: null
      };
    }
    const payload = {
      text,
      source,
      target
    };
    logging.log(`Making translation request from ${source} to ${target}`);
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Authorization": authorization,
        "Content-Type": contentType || "application/json"
      },
      body: JSON.stringify(payload)
    });
    const data = await response.json();
    logging.log(`Translation API response:`, JSON.stringify(data));
    if (!response.ok) {
      throw new Error(data.message || `API error: ${response.status} ${response.statusText}`);
    }
    const translatedResult = data.translated_text || data.translation || data.text;
    logging.log(`Final translated text: ${translatedResult}`);
    return {
      translatedText: translatedResult,
      error: null
    };
  } catch (error) {
    logging.error(`Translation error: ${error.message}`);
    return {
      translatedText: text,
      // Return original text if translation fails
      error: error.message
    };
  }
}
