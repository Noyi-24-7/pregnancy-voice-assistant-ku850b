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

// cancerApp/tmp_scripts_900/da94dcb4-fa62-4c27-a358-dea9442734d3_temp.ts
var da94dcb4_fa62_4c27_a358_dea9442734d3_temp_exports = {};
__export(da94dcb4_fa62_4c27_a358_dea9442734d3_temp_exports, {
  default: () => cleanMedicalResponse
});
module.exports = __toCommonJS(da94dcb4_fa62_4c27_a358_dea9442734d3_temp_exports);
async function cleanMedicalResponse({
  medicalResponse
}, {
  logging
}) {
  try {
    if (!medicalResponse) {
      return { cleanedResponse: "" };
    }
    let cleanedText = medicalResponse;
    cleanedText = cleanedText.replace(/\*\*(.*?)\*\*/g, "$1");
    cleanedText = cleanedText.replace(/\*(.*?)\*/g, "$1");
    cleanedText = cleanedText.replace(/__(.*?)__/g, "$1");
    cleanedText = cleanedText.replace(/\\n/g, " ");
    cleanedText = cleanedText.replace(/\n/g, " ");
    cleanedText = cleanedText.replace(/\s{2,}/g, " ");
    cleanedText = cleanedText.trim();
    cleanedText = cleanedText.replace(/\.\s+/g, ". ");
    cleanedText = cleanedText.replace(/\?\s+/g, "? ");
    cleanedText = cleanedText.replace(/!\s+/g, "! ");
    cleanedText = cleanedText.replace(/[^\w\s.,!?;:()-]/g, "");
    logging.log(`Original length: ${medicalResponse.length}`);
    logging.log(`Cleaned length: ${cleanedText.length}`);
    logging.log(`Cleaned text preview: ${cleanedText.substring(0, 200)}...`);
    return {
      cleanedResponse: cleanedText
    };
  } catch (error) {
    logging.error(`Text cleaning failed: ${error.message}`);
    return {
      cleanedResponse: medicalResponse
      // Return original if cleaning fails
    };
  }
}
