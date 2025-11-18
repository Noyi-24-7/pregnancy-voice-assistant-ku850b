# Cancer App API - Deployment Guide

## Overview

This project is a Next.js API that wraps the BuildShip audio processing workflow for medical Q&A. It handles audio transcription, translation, medical question processing, and speech synthesis.

## Prerequisites

1. Node.js 18+ installed
2. Vercel account
3. API keys:
   - SPITCH_API_KEY (for transcription, translation, and TTS)
   - GEMMA_API_KEY (for medical Q&A processing)
   - ZAMZAR_API_KEY (for audio format conversion)
   - Google Cloud Storage credentials

## Known Issues

### Turbopack Build Errors

The project currently has build issues with Turbopack due to dynamic imports in the BuildShip utilities. To resolve this:

**Option 1: Use Webpack Instead of Turbopack**

Update `package.json` scripts to disable Turbopack:

```json
{
  "scripts": {
    "dev": "next dev --experimental-https=false",
    "build": "next build",
    "start": "next start"
  }
}
```

**Option 2: Wait for Turbopack Support**

The Next.js team is actively working on improving Turbopack's support for dynamic imports. Monitor:
- https://github.com/vercel/next.js/issues

## Local Testing

### 1. Install Dependencies

```bash
cd cancer-app-api
npm install
```

### 2. Configure Environment Variables

Copy `.env.example` to `.env.local` and fill in your credentials:

```bash
cp .env.example .env.local
```

Edit `.env.local`:

```env
# API Keys
SPITCH_API_KEY=your_spitch_api_key
GEMMA_API_KEY=your_gemma_api_key
ZAMZAR_API_KEY=your_zamzar_api_key

# Google Cloud Storage
GOOGLE_CLOUD_PROJECT_ID=your_project_id
GOOGLE_CLOUD_BUCKET_NAME=your_bucket_name
GOOGLE_APPLICATION_CREDENTIALS=./service-account-key.json
BUCKET=your_bucket_name
```

### 3. Set Up Google Cloud Storage

1. Create a Google Cloud Storage bucket
2. Create a service account with Storage Admin permissions
3. Download the service account key JSON
4. Save it as `service-account-key.json` in the project root
5. Update `GOOGLE_APPLICATION_CREDENTIALS` in `.env.local`

### 4. Test the API Locally

Due to the build issues, you may need to test using the development server:

```bash
npm run dev
```

The API will be available at `http://localhost:3000/api/process-audio`

### 5. Test the Endpoint

Use curl or Postman to test:

```bash
curl -X POST http://localhost:3000/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "base64_encoded_audio_here",
    "sourceLanguage": "en",
    "conversationHistory": []
  }'
```

## Deploying to Vercel

### Option A: Deploy via Vercel CLI

1. Install Vercel CLI:

```bash
npm i -g vercel
```

2. Login to Vercel:

```bash
vercel login
```

3. Deploy:

```bash
vercel
```

4. Follow prompts to link/create project

5. Deploy to production:

```bash
vercel --prod
```

### Option B: Deploy via Vercel Dashboard

1. Push your code to GitHub/GitLab/Bitbucket

2. Go to https://vercel.com/dashboard

3. Click "Add New" → "Project"

4. Import your repository

5. Configure environment variables in project settings:
   - Navigate to Settings → Environment Variables
   - Add all variables from `.env.local`
   - For `GOOGLE_APPLICATION_CREDENTIALS`, paste the JSON content directly

6. Click "Deploy"

## Post-Deployment Configuration

### 1. Configure Environment Variables

In Vercel Dashboard → Your Project → Settings → Environment Variables:

Add the following variables for Production, Preview, and Development:

- `SPITCH_API_KEY`
- `GEMMA_API_KEY`
- `ZAMZAR_API_KEY`
- `GOOGLE_CLOUD_PROJECT_ID`
- `GOOGLE_CLOUD_BUCKET_NAME`
- `BUCKET`

For `GOOGLE_APPLICATION_CREDENTIALS`, you have two options:

**Option 1: Paste JSON content as environment variable**
```
GOOGLE_CLOUD_STORAGE_CREDENTIALS={"type":"service_account","project_id":"..."}
```

Then update the code to parse this JSON instead of reading from file.

**Option 2: Use Vercel's Secret Files (Recommended)**
- Use Vercel's secret file feature to upload the service account JSON
- Reference it in your environment variables

### 2. Update Storage CORS Settings

Ensure your Google Cloud Storage bucket allows requests from your Vercel domain:

```bash
gsutil cors set cors.json gs://your-bucket-name
```

Sample `cors.json`:

```json
[
  {
    "origin": ["https://your-domain.vercel.app"],
    "method": ["GET", "POST", "PUT"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
```

### 3. Test Production Deployment

```bash
curl -X POST https://your-domain.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "base64_encoded_audio_here",
    "sourceLanguage": "en",
    "conversationHistory": []
  }'
```

## Performance Optimization

### Function Timeout

The default timeout for Vercel Hobby plan is 10s, Pro is 60s. The workflow may take longer.

To increase timeout (Pro plan only):

1. Update `vercel.json`:

```json
{
  "functions": {
    "app/api/process-audio/route.ts": {
      "maxDuration": 60,
      "memory": 1024
    }
  }
}
```

2. Consider splitting the workflow into multiple endpoints if processing exceeds limits

### File Size Limits

- Vercel has a 4.5MB request body size limit
- For larger audio files, consider:
  1. Client-side compression before upload
  2. Streaming upload to storage, then processing by reference
  3. Using Vercel Blob storage as intermediate storage

## Monitoring and Debugging

### View Logs

```bash
vercel logs your-deployment-url
```

Or in Vercel Dashboard → Your Project → Logs

### Common Issues

1. **Function Timeout**: Upgrade to Pro plan or optimize workflow
2. **Out of Memory**: Increase memory allocation in `vercel.json`
3. **API Rate Limits**: Implement request queuing or caching
4. **Storage Access Errors**: Verify service account permissions

## API Documentation

### Endpoint

`POST /api/process-audio`

### Request Body

```json
{
  "audioFile": "base64_encoded_audio_string",
  "sourceLanguage": "en",
  "conversationHistory": [
    { "isUser": true, "text": "previous question" },
    { "isUser": false, "text": "previous response" }
  ]
}
```

### Response

```json
{
  "success": true,
  "translatedText": "Medical response in user's language",
  "audioUrl": "https://storage.googleapis.com/.../audio.m4a",
  "transcribedText": "Original transcribed question",
  "sourceLanguage": "en",
  "error": null
}
```

### Health Check

`GET /api/process-audio`

Returns:
```json
{
  "status": "ok",
  "service": "Cancer App Audio Processing API",
  "version": "1.0.0"
}
```

## Support

For issues related to:
- BuildShip export: https://docs.buildship.com
- Next.js deployment: https://nextjs.org/docs
- Vercel platform: https://vercel.com/docs
- API integrations: Contact respective API support (Spitch, Gemma, Zamzar)

