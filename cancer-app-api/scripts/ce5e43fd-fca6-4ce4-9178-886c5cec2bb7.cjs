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

// cancerApp/tmp_scripts_900/ce5e43fd-fca6-4ce4-9178-886c5cec2bb7_temp.ts
var ce5e43fd_fca6_4ce4_9178_886c5cec2bb7_temp_exports = {};
__export(ce5e43fd_fca6_4ce4_9178_886c5cec2bb7_temp_exports, {
  default: () => constructOutputJson
});
module.exports = __toCommonJS(ce5e43fd_fca6_4ce4_9178_886c5cec2bb7_temp_exports);
async function constructOutputJson({
  transcribedText,
  medicalResponse,
  audioUrl,
  sourceLanguage
}) {
  const outputJson = {
    success: true,
    transcribedText,
    translatedText: medicalResponse,
    // Medical response in user's language
    audioUrl,
    sourceLanguage,
    targetLanguage: sourceLanguage
    // Same as source for Q&A
  };
  return {
    outputJson
  };
}
