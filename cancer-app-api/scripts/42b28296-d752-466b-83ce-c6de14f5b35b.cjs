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

// cancerApp/tmp_scripts_900/42b28296-d752-466b-83ce-c6de14f5b35b_temp.ts
var b28296_d752_466b_83ce_c6de14f5b35b_temp_exports = {};
__export(b28296_d752_466b_83ce_c6de14f5b35b_temp_exports, {
  default: () => convertAudioZamzar
});
module.exports = __toCommonJS(b28296_d752_466b_83ce_c6de14f5b35b_temp_exports);
async function convertAudioZamzar({
  audioUrl,
  apiKey
}, {
  logging
}) {
  try {
    logging.log(`Converting M4A to MP3 using Zamzar API`);
    let url = audioUrl;
    if (typeof audioUrl === "object" && audioUrl.publicUrl) {
      url = audioUrl.publicUrl;
    }
    logging.log(`Input URL: ${url}`);
    const jobData = new FormData();
    jobData.append("source_file", url);
    jobData.append("target_format", "mp3");
    const conversionResponse = await fetch("https://sandbox.zamzar.com/v1/jobs", {
      method: "POST",
      headers: {
        "Authorization": `Basic ${Buffer.from(apiKey + ":").toString("base64")}`
        // Don't set Content-Type for FormData
      },
      body: jobData
    });
    if (!conversionResponse.ok) {
      const error = await conversionResponse.text();
      throw new Error(`Zamzar API failed: ${conversionResponse.status} - ${error}`);
    }
    const job = await conversionResponse.json();
    const jobId = job.id;
    logging.log(`Conversion job started: ${jobId}`);
    let attempts = 0;
    const maxAttempts = 60;
    while (attempts < maxAttempts) {
      await new Promise((resolve) => setTimeout(resolve, 2e3));
      attempts++;
      const statusResponse = await fetch(`https://sandbox.zamzar.com/v1/jobs/${jobId}`, {
        headers: {
          "Authorization": `Basic ${Buffer.from(apiKey + ":").toString("base64")}`
        }
      });
      if (!statusResponse.ok) {
        logging.error(`Status check failed: ${statusResponse.status}`);
        continue;
      }
      const status = await statusResponse.json();
      logging.log(`Attempt ${attempts}: Status = ${status.status}`);
      if (status.status === "successful") {
        const fileId = status.target_files[0].id;
        const downloadUrl = `https://sandbox.zamzar.com/v1/files/${fileId}/content`;
        logging.log(`\u2705 Conversion completed, file ID: ${fileId}`);
        return {
          publicUrl: downloadUrl,
          fileId,
          downloadHeaders: {
            "Authorization": `Basic ${Buffer.from(apiKey + ":").toString("base64")}`
          }
        };
      }
      if (status.status === "failed") {
        throw new Error(`Audio conversion failed: ${status.failure_reason || "Unknown error"}`);
      }
    }
    throw new Error("Audio conversion timeout");
  } catch (error) {
    logging.error(`Audio conversion failed: ${error.message}`);
    throw error;
  }
}
