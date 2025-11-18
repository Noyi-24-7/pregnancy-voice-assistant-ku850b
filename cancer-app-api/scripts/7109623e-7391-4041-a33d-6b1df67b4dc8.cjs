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

// cancerApp/tmp_scripts_900/7109623e-7391-4041-a33d-6b1df67b4dc8_temp.ts
var e_7391_4041_a33d_6b1df67b4dc8_temp_exports = {};
__export(e_7391_4041_a33d_6b1df67b4dc8_temp_exports, {
  default: () => processCancerQuestion
});
module.exports = __toCommonJS(e_7391_4041_a33d_6b1df67b4dc8_temp_exports);
var SYSTEM_PROMPT = `
You are a highly experienced oncologist providing clear, calm, supportive guidance.
Use patient-friendly explanations grounded in evidence.

### Cancer Knowledge (Use only when relevant)
\u2022 Breast cancer signs: new lumps, skin dimpling, shape/size changes, nipple inversion/rash, unusual/bloody discharge, armpit swelling.
\u2022 Cervical cancer: early silent; later \u2192 unusual bleeding, watery/bloody discharge, pain during sex.
\u2022 Prostate cancer: early silent; later \u2192 weak stream, urgency, night urination, incomplete emptying; advanced \u2192 weight loss, bone pain, blood in urine/semen.
\u2022 Screening: mammogram (40+ risk-based), Pap/HPV routine intervals, PSA requires shared decision-making.
\u2022 Treatment categories: surgery, radiation, chemotherapy, immunotherapy.
\u2022 Post-chemo tips: dental prep; nausea \u2192 small bland meals; fatigue \u2192 short naps + gentle exercise; neuropathy \u2192 padded shoes; mouth sores \u2192 baking soda + salt rinse.
\u2022 Red flags: fever \u2265 38\xB0C, persistent vomiting/diarrhea, chest pain, breathing difficulty, unusual bleeding, sudden severe pain, port-site infection.

### Safety Rules
\u2022 Do NOT diagnose. Clarify possibilities only.
\u2022 Do NOT give medication dosages.
\u2022 For red flags or severe symptoms, advise urgent in-person care.
\u2022 Ask clarifying questions rather than guessing.

### Style
\u2022 Respond in **3\u20134 sentences max**, \u226480 words.
\u2022 Warm, supportive, medically safe.
\u2022 Use simple language.
\u2022 Reference conversation history only if relevant.
\u2022 End with a follow-up question when appropriate.

### Memory Trimming
You will receive:
1) Short summary of earlier conversation  
2) Latest user message  
Use both only for continuity.
`;
function isSelfDiagnosisRequest(message) {
  const text = message.toLowerCase();
  const forbidden = [
    /do i have cancer/,
    /can you tell if i have/,
    /does this mean i have/,
    /confirm.*i have/,
    /do you think i have/,
    /diagnose me/
  ];
  if (forbidden.some((p) => p.test(text))) return true;
  const allowed = [
    /how would i know if i have/,
    /how do i know if i have/,
    /what are the signs/,
    /what are the symptoms/,
    /how is cancer diagnosed/,
    /how do people find out/
  ];
  if (allowed.some((p) => p.test(text))) return false;
  return false;
}
async function processCancerQuestion({ question, originalLanguage, apiKey, conversationHistory }, { logging }) {
  try {
    logging.log(`Processing cancer question: ${question}`);
    if (isSelfDiagnosisRequest(question)) {
      return {
        medicalResponse: "I can\u2019t determine whether you have cancer. A clinician would need to assess symptoms directly and may recommend imaging or lab tests. What changes or symptoms made you wonder about this?",
        success: true
      };
    }
    let historyArray = [];
    try {
      if (conversationHistory && conversationHistory !== "[]") {
        historyArray = JSON.parse(conversationHistory);
      }
    } catch (err) {
      logging.error("Failed to parse conversation history, resetting.");
      historyArray = [];
    }
    let conversationSummary = "";
    let lastUserMessage = "";
    if (historyArray.length > 0) {
      for (let i = historyArray.length - 1; i >= 0; i--) {
        if (historyArray[i].isUser) {
          lastUserMessage = historyArray[i].text;
          break;
        }
      }
      const bullets = [];
      for (const msg of historyArray.slice(0, -1)) {
        if (bullets.length < 10) {
          bullets.push(
            msg.isUser ? `\u2022 Patient noted: ${msg.text.slice(0, 140)}` : `\u2022 Doctor responded: ${msg.text.slice(0, 140)}`
          );
        }
      }
      conversationSummary = bullets.join("\n");
    }
    const finalPrompt = `
${SYSTEM_PROMPT}

### Previous Summary
${conversationSummary || "None"}

### Last User Message
${lastUserMessage || "None"}

### New Question
${question}

Follow all rules above.
    `;
    const model = "gemma-3n-e4b-it";
    const payload = {
      contents: [
        {
          role: "user",
          parts: [{ text: finalPrompt }]
        }
      ],
      generationConfig: {
        temperature: 0.3,
        topP: 0.7,
        topK: 10,
        maxOutputTokens: 200
      }
    };
    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      }
    );
    const raw = await response.text();
    if (!response.ok) {
      throw new Error(`API error ${response.status}: ${raw}`);
    }
    const data = JSON.parse(raw);
    const aiResponse = data?.candidates?.[0]?.content?.parts?.[0]?.text?.trim() || "";
    if (!aiResponse) {
      throw new Error("Empty response from model");
    }
    let finalAnswer = aiResponse;
    if (!finalAnswer.includes("?")) {
      const followUps = [
        " What changes have you noticed?",
        " When did these symptoms start?",
        " Has anything made the symptoms better or worse?",
        " Have you done any screening tests recently?"
      ];
      finalAnswer += followUps[Math.floor(Math.random() * followUps.length)];
    }
    return {
      medicalResponse: finalAnswer,
      success: true
    };
  } catch (error) {
    return {
      medicalResponse: "I wasn't able to process that. Please speak with an oncologist or healthcare provider for proper evaluation.",
      success: false
    };
  }
}
