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

// cancerApp/tmp_scripts_900/df983403-6ae0-4c73-b3d9-ebd04bb4749e_temp.ts
var df983403_6ae0_4c73_b3d9_ebd04bb4749e_temp_exports = {};
__export(df983403_6ae0_4c73_b3d9_ebd04bb4749e_temp_exports, {
  default: () => spitchTranslate
});
module.exports = __toCommonJS(df983403_6ae0_4c73_b3d9_ebd04bb4749e_temp_exports);
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
    if (!text) {
      throw new Error("No text provided for translation");
    }
    if (!source) {
      throw new Error("Source language not specified");
    }
    if (!target) {
      throw new Error("Target language not specified");
    }
    const payload = {
      text,
      source,
      target
    };
    logging.log(`Translating text from ${source} to ${target}`);
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Authorization": authorization,
        "Content-Type": contentType || "application/json"
      },
      body: JSON.stringify(payload)
    });
    const data = await response.json();
    if (!response.ok) {
      throw new Error(data.message || `API error: ${response.status} ${response.statusText}`);
    }
    return {
      translatedText: data.translated_text || data.translation || data.text,
      error: null
    };
  } catch (error) {
    logging.error(`Translation error: ${error.message}`);
    return {
      translatedText: null,
      error: error.message
    };
  }
}
