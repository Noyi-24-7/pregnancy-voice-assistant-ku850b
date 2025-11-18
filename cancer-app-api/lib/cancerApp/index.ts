// @ts-nocheck

import "dotenv/config";
import pMap from "p-map";
import { getSecret, scripExecutor, parseExpression, setResult, duplicateState, executeWorkflow } from "../buildship/utils";
import { httpExecutor } from "../buildship/http";

// The workflowDirectory parameter is not used anymore since we import nodes directly
const executeScript = scripExecutor("");
const executeHttp = httpExecutor("");

enum NODES {
    "uploadInputAudioToStorage" = "e25c9a7a-7e2d-492f-90d8-6e1139f8a67f",
    "convertM4AToMp3" = "42b28296-d752-466b-83ce-c6de14f5b35b",
    "downloadReUpload" = "ba67b2a1-66c2-4144-9144-9914ffb7cff1",
    "transcribeAudioWithSpitch" = "a4e5a4d6-d8d1-4840-b19c-e643c6355aba",
    "translateQuestionToEnglish" = "df983403-6ae0-4c73-b3d9-ebd04bb4749e",
    "processMedicalQuestionWithGemma" = "7109623e-7391-4041-a33d-6b1df67b4dc8",
    "cleanMedicalResponse" = "da94dcb4-fa62-4c27-a358-dea9442734d3",
    "translateResponseBackToUserLanguage" = "926cd33f-5c23-400b-afd7-898c3ec80c45",
    "selectVoiceForSynthesis" = "10bbb0ce-10d6-4d2c-b336-3ca2b69a40c9",
    "synthesizeSpeechWithSpitch" = "c501951c-0d3f-4e37-9480-6770735f2be3",
    "uploadSynthesizedAudioToStorage" = "5a085e0a-807a-49b2-804f-99feba62dd86",
    "buildOutputJson" = "ce5e43fd-fca6-4ce4-9178-886c5cec2bb7",
    "outputs" = "67567c20-ac80-46aa-8234-b9c096ac81b6"
}


export default async function execute(inputs: any, root: any) {
    root["inputs"] = {};
    Object.entries(inputs).forEach(([key, value]) => {
        root["inputs"][key] = value;
    });

    setResult(root, await executeScript(NODES.uploadInputAudioToStorage, { "fileName": await parseExpression(root, "Date.now() + '.mp4'"), "base64": root["inputs"]["audioFile"] }, root, {}), [NODES.uploadInputAudioToStorage]);

    setResult(root, await executeScript(NODES.convertM4AToMp3, { "apiKey": await getSecret("ZAMZAR_API_KEY"), "audioUrl": root[NODES.uploadInputAudioToStorage]["publicUrl"], "translatedText": await parseExpression(root, "ctx?.[\"root\"]?.[\"a30ed2d3-2c81-48d4-8c0b-90197e75ed43\"]?.[\"then\"]?.[\"204ba493-4d43-4356-8576-35bee31148fe\"]?.[\"translatedText\"] ?? ctx?.[\"root\"]?.[\"a30ed2d3-2c81-48d4-8c0b-90197e75ed43\"]?.[\"else\"]?.[\"2b1eeb9e-d771-4141-bc58-8f882c6210e9\"]"), "m4aUrl": root[NODES.uploadInputAudioToStorage] }, root, {}), [NODES.convertM4AToMp3]);

    setResult(root, await executeScript(NODES.downloadReUpload, { "zamzarResponse": root[NODES.convertM4AToMp3], "m4aUrl": root[NODES.uploadInputAudioToStorage], "audioUrl": root[NODES.uploadInputAudioToStorage]["publicUrl"], "fileName": await parseExpression(root, "`voice-translations/converted-${Date.now()}.mp3`"), "translatedText": await parseExpression(root, "ctx?.[\"root\"]?.[\"a30ed2d3-2c81-48d4-8c0b-90197e75ed43\"]?.[\"then\"]?.[\"204ba493-4d43-4356-8576-35bee31148fe\"]?.[\"translatedText\"] ?? ctx?.[\"root\"]?.[\"a30ed2d3-2c81-48d4-8c0b-90197e75ed43\"]?.[\"else\"]?.[\"2b1eeb9e-d771-4141-bc58-8f882c6210e9\"]") }, root, {}), [NODES.downloadReUpload]);

    setResult(root, await executeScript(NODES.transcribeAudioWithSpitch, { "endpoint": "https://api.spi-tch.com/v1/transcriptions", "language": root["inputs"]["sourceLanguage"], "url": root[NODES.downloadReUpload]["publicUrl"], "authorization": await parseExpression(root, "`Bearer ${await getSecret(\"SPITCH_API_KEY\")}`") }, root, {}), [NODES.transcribeAudioWithSpitch]);

    setResult(root, await executeScript(NODES.translateQuestionToEnglish, { "target": "en", "text": root[NODES.transcribeAudioWithSpitch]["transcribedText"], "source": root["inputs"]["sourceLanguage"], "endpoint": "https://api.spi-tch.com/v1/translate", "contentType": "application/json", "authorization": await parseExpression(root, "`Bearer ${await getSecret(\"SPITCH_API_KEY\")}`") }, root, {}), [NODES.translateQuestionToEnglish]);

    setResult(root, await executeScript(NODES.processMedicalQuestionWithGemma, { "question": root[NODES.translateQuestionToEnglish]["translatedText"], "originalLanguage": root["inputs"]["sourceLanguage"], "conversationHistory": root["inputs"]["conversationHistory"], "apiKey": await getSecret("GEMMA_API_KEY") }, root, {}), [NODES.processMedicalQuestionWithGemma]);

    setResult(root, await executeScript(NODES.cleanMedicalResponse, { "medicalResponse": root[NODES.processMedicalQuestionWithGemma]["medicalResponse"] }, root, {}), [NODES.cleanMedicalResponse]);

    setResult(root, await executeScript(NODES.translateResponseBackToUserLanguage, { "text": root[NODES.cleanMedicalResponse]["cleanedResponse"], "target": root["inputs"]["sourceLanguage"], "endpoint": "https://api.spi-tch.com/v1/translate", "source": "en", "contentType": "application/json", "authorization": await parseExpression(root, "`Bearer ${await getSecret(\"SPITCH_API_KEY\")}`") }, root, {}), [NODES.translateResponseBackToUserLanguage]);

    setResult(root, await executeScript(NODES.selectVoiceForSynthesis, { "targetLanguage": root["inputs"]["sourceLanguage"] }, root, {}), [NODES.selectVoiceForSynthesis]);

    setResult(root, await executeScript(NODES.synthesizeSpeechWithSpitch, { "authorization": await parseExpression(root, "`Bearer ${await getSecret(\"SPITCH_API_KEY\")}`"), "text": root[NODES.translateResponseBackToUserLanguage]["translatedText"], "language": root["inputs"]["sourceLanguage"], "endpoint": "https://api.spi-tch.com/v1/speech", "contentType": "application/json", "voice": await parseExpression(root, "ctx?.[\"root\"]?.[\"10bbb0ce-10d6-4d2c-b336-3ca2b69a40c9\"]") }, root, {}), [NODES.synthesizeSpeechWithSpitch]);

    setResult(root, await executeScript(NODES.uploadSynthesizedAudioToStorage, { "base64": root[NODES.synthesizeSpeechWithSpitch]["audioBase64"], "fileName": await parseExpression(root, "`voice-translations/output/translation-${Date.now()}.m4a`") }, root, {}), [NODES.uploadSynthesizedAudioToStorage]);

    setResult(root, await executeScript(NODES.buildOutputJson, { "medicalResponse": root[NODES.translateResponseBackToUserLanguage]["translatedText"], "translatedText": root["a2ca7e6a-459f-4fa9-88aa-9452b495fcad"]["finalText"], "transcribedText": root[NODES.transcribeAudioWithSpitch]["transcribedText"], "audioUrl": root[NODES.uploadSynthesizedAudioToStorage]["publicUrl"], "sourceLanguage": root["inputs"]["sourceLanguage"] }, root, {}), [NODES.buildOutputJson]);

    setResult(root, {
        "result": await parseExpression(root, "({\n  translatedText: ctx?.[\"root\"]?.[\"926cd33f-5c23-400b-afd7-898c3ec80c45\"]?.[\"translatedText\"],\n  audioUrl: ctx?.[\"root\"]?.[\"5a085e0a-807a-49b2-804f-99feba62dd86\"],\n  error: ctx?.[\"root\"]?.[\"c501951c-0d3f-4e37-9480-6770735f2be3\"]?.[\"error\"]\n})")
    }, ["output"]);
    throw "STOP";

    return result;
}
