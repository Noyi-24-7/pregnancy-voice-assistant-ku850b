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

// cancerApp/tmp_scripts_900/c501951c-0d3f-4e37-9480-6770735f2be3_temp.ts
var c501951c_0d3f_4e37_9480_6770735f2be3_temp_exports = {};
__export(c501951c_0d3f_4e37_9480_6770735f2be3_temp_exports, {
  default: () => spitchTextToSpeech
});
module.exports = __toCommonJS(c501951c_0d3f_4e37_9480_6770735f2be3_temp_exports);
async function spitchTextToSpeech({
  endpoint,
  text,
  language,
  voice,
  authorization,
  contentType
}, {
  logging
}) {
  try {
    logging.log(`Synthesizing text to speech with Spitch API...`);
    logging.log(`Text: ${text.substring(0, 100)}${text.length > 100 ? "..." : ""}`);
    logging.log(`Voice: ${voice}`);
    logging.log(`Language: ${language}`);
    const requestBody = {
      text,
      voice,
      language
    };
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Authorization": authorization,
        "Content-Type": contentType
      },
      body: JSON.stringify(requestBody)
    });
    if (!response.ok) {
      const errorData = await response.text();
      logging.log(`Error from Spitch API: ${response.status} ${response.statusText}`);
      logging.log(`Error details: ${errorData}`);
      return {
        audioBase64: null,
        error: `Spitch API error: ${response.status} ${response.statusText} - ${errorData}`
      };
    }
    const audioBuffer = await response.arrayBuffer();
    const base64Audio = Buffer.from(audioBuffer).toString("base64");
    logging.log(`Successfully synthesized speech, returning base64 audio`);
    return {
      audioBase64: base64Audio,
      error: null
    };
  } catch (error) {
    logging.log(`Exception occurred during text-to-speech synthesis: ${error.message}`);
    return {
      audioBase64: null,
      error: `Failed to synthesize speech: ${error.message}`
    };
  }
}
