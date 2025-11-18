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

// cancerApp/tmp_scripts_900/10bbb0ce-10d6-4d2c-b336-3ca2b69a40c9_temp.ts
var bbb0ce_10d6_4d2c_b336_3ca2b69a40c9_temp_exports = {};
__export(bbb0ce_10d6_4d2c_b336_3ca2b69a40c9_temp_exports, {
  default: () => selectSpitchVoice
});
module.exports = __toCommonJS(bbb0ce_10d6_4d2c_b336_3ca2b69a40c9_temp_exports);
async function selectSpitchVoice({
  targetLanguage
}, {
  logging
}) {
  const languageToVoiceMap = {
    "en": "lucy",
    "yo": "sade",
    "ha": "amina",
    "ig": "ngozi",
    "am": "hana",
    "ti": "selam"
  };
  const defaultVoice = "lucy";
  const selectedVoice = languageToVoiceMap[targetLanguage] || defaultVoice;
  logging.log(`Selected voice "${selectedVoice}" for language code "${targetLanguage}"`);
  return selectedVoice;
}
