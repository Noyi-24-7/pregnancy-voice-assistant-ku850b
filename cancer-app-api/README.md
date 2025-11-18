# Cancer App Audio Processing API

A Next.js API service that processes medical questions via audio input, providing transcription, translation, medical Q&A with Gemma AI, and speech synthesis responses.

## Features

- **Audio Transcription**: Converts audio to text using Spitch API
- **Language Translation**: Translates questions to English and responses back to user's language
- **Medical Q&A**: Processes medical questions using Gemma AI
- **Speech Synthesis**: Converts text responses to natural-sounding speech
- **Cloud Storage**: Stores audio files in Google Cloud Storage
- **Multi-language Support**: English, Yoruba, Hausa, Igbo, Amharic, Tigrinya

## Architecture

This project is a migration of a BuildShip workflow to a self-hosted Next.js API. It consists of:

```
cancer-app-api/
├── app/
│   └── api/
│       └── process-audio/
│           └── route.ts          # Main API endpoint
├── lib/
│   ├── buildship/                # BuildShip utilities
│   │   ├── utils.ts
│   │   ├── http.ts
│   │   └── files/                # File handling utilities
│   └── cancerApp/                # Workflow logic
│       ├── index.ts              # Main workflow executor
│       └── nodes.ts              # Node definitions
├── scripts/                      # Individual workflow node scripts
├── .env.example                  # Environment variable template
├── .env.local                    # Local environment (gitignored)
├── vercel.json                   # Vercel deployment config
├── DEPLOYMENT.md                 # Deployment guide
└── README.md                     # This file
```

## Workflow

The API processes audio through the following pipeline:

1. **Upload Input Audio** → Store original audio in GCS
2. **Convert M4A to MP3** → Use Zamzar API for format conversion
3. **Download & Re-upload** → Store converted audio
4. **Transcribe Audio** → Convert speech to text (Spitch)
5. **Translate to English** → Translate question if needed
6. **Process Medical Question** → Get medical response (Gemma AI)
7. **Clean Response** → Remove markdown formatting
8. **Translate Response** → Translate back to user's language
9. **Select Voice** → Choose appropriate voice for language
10. **Synthesize Speech** → Convert text to audio (Spitch)
11. **Upload Output Audio** → Store synthesized audio in GCS
12. **Build Output** → Return structured response

## Prerequisites

- Node.js 18 or higher
- npm or yarn
- Google Cloud Platform account with Storage enabled
- API keys for:
  - Spitch (transcription, translation, TTS)
  - Gemma (medical AI)
  - Zamzar (audio conversion)

## Quick Start

### 1. Clone and Install

```bash
cd cancer-app-api
npm install
```

### 2. Configure Environment

```bash
cp .env.example .env.local
```

Edit `.env.local` with your credentials:

```env
SPITCH_API_KEY=your_spitch_key
GEMMA_API_KEY=your_gemma_key
ZAMZAR_API_KEY=your_zamzar_key
GOOGLE_CLOUD_PROJECT_ID=your_project_id
GOOGLE_CLOUD_BUCKET_NAME=your_bucket
BUCKET=your_bucket
```

### 3. Set Up Google Cloud Storage

1. Create a GCS bucket
2. Create a service account with "Storage Admin" role
3. Download the service account key JSON
4. Save as `service-account-key.json` in project root
5. Add to `.env.local`:

```env
GOOGLE_APPLICATION_CREDENTIALS=./service-account-key.json
```

### 4. Run Development Server

⚠️ **Note**: Due to Turbopack limitations with dynamic imports, you may need to use traditional webpack:

```bash
# Option 1: Development mode (works with Turbopack)
npm run dev

# Option 2: Build with webpack
npm run build
npm start
```

### 5. Test the API

```bash
curl -X GET http://localhost:3000/api/process-audio

# Should return:
# {"status":"ok","service":"Cancer App Audio Processing API","version":"1.0.0"}
```

For a full test with audio:

```bash
curl -X POST http://localhost:3000/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "data:audio/m4a;base64,<base64_encoded_audio>",
    "sourceLanguage": "en",
    "conversationHistory": []
  }'
```

## API Reference

### POST /api/process-audio

Process an audio file containing a medical question.

#### Request

```typescript
{
  audioFile: string;          // Base64-encoded audio (M4A or MP3)
  sourceLanguage: string;     // Language code (en, yo, ha, ig, am, ti)
  conversationHistory?: Array<{
    isUser: boolean;
    text: string;
  }>;
}
```

#### Response

```typescript
{
  success: boolean;
  translatedText: string;     // Medical response in user's language
  audioUrl: string;           // URL to synthesized audio response
  transcribedText: string;    // Original transcribed question
  sourceLanguage: string;     // Language code used
  error: string | null;       // Error message if failed
}
```

#### Example

```javascript
const response = await fetch('/api/process-audio', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    audioFile: 'data:audio/m4a;base64,UklGRiQA...',
    sourceLanguage: 'en',
    conversationHistory: []
  })
});

const data = await response.json();
console.log(data.translatedText);  // Medical response
console.log(data.audioUrl);        // Audio URL
```

### GET /api/process-audio

Health check endpoint.

#### Response

```json
{
  "status": "ok",
  "service": "Cancer App Audio Processing API",
  "version": "1.0.0"
}
```

## Supported Languages

| Code | Language   | Voice     |
|------|------------|-----------|
| en   | English    | lucy      |
| yo   | Yoruba     | sade      |
| ha   | Hausa      | amina     |
| ig   | Igbo       | ngozi     |
| am   | Amharic    | hana      |
| ti   | Tigrinya   | selam     |

## Deployment

See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed deployment instructions.

### Quick Deploy to Vercel

```bash
npm i -g vercel
vercel login
vercel
```

Then configure environment variables in Vercel Dashboard.

## Configuration

### Vercel Settings (vercel.json)

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

- **maxDuration**: 60 seconds (requires Pro plan)
- **memory**: 1024 MB

### Next.js Configuration (next.config.ts)

```typescript
{
  serverExternalPackages: ['@google-cloud/storage', '@google-cloud/firestore'],
  webpack: (config) => {
    config.resolve.fallback = { ...config.resolve.fallback, encoding: false };
    return config;
  }
}
```

## Troubleshooting

### Build Errors with Turbopack

**Problem**: Dynamic imports failing during build

**Solution**: The BuildShip export uses dynamic imports that Turbopack doesn't fully support yet. Use webpack instead:

```bash
npm run build  # Uses webpack by default
```

### Function Timeout

**Problem**: API calls timing out after 10 seconds

**Solution**: 
1. Upgrade to Vercel Pro for 60s timeout
2. OR split workflow into multiple endpoints
3. OR use background processing with webhooks

### Memory Limit Exceeded

**Problem**: "Function invocation failed" with memory errors

**Solution**: Increase memory in `vercel.json` (requires Pro plan):

```json
{
  "functions": {
    "app/api/process-audio/route.ts": {
      "memory": 3008
    }
  }
}
```

### Google Cloud Storage Errors

**Problem**: "Permission denied" or "Bucket not found"

**Solution**:
1. Verify service account has "Storage Admin" role
2. Ensure `BUCKET` environment variable matches bucket name
3. Check bucket exists and is in the same project

### API Rate Limits

**Problem**: 429 errors from Spitch, Gemma, or Zamzar

**Solution**:
1. Implement request queuing
2. Add exponential backoff and retry logic
3. Cache responses where appropriate
4. Contact API providers for rate limit increases

## Development

### Project Structure

- **app/api/**: Next.js API routes
- **lib/**: Utility libraries and workflow logic
- **scripts/**: Individual node implementations from BuildShip
- **public/**: Static assets (if any)

### Adding New Features

1. Modify workflow in `lib/cancerApp/index.ts`
2. Add new node scripts to `scripts/` directory
3. Update `lib/cancerApp/nodes.ts` if adding new nodes
4. Test locally before deploying

### Testing

```bash
# Unit tests (when implemented)
npm test

# Integration tests
npm run test:integration

# E2E tests
npm run test:e2e
```

## Security

- Never commit `.env.local` or service account keys
- Use Vercel environment variables for production secrets
- Implement rate limiting for production use
- Validate and sanitize all user inputs
- Use CORS headers to restrict API access

## Performance

- Average processing time: 10-30 seconds
- Supports concurrent requests
- Caching recommended for repeated translations
- Monitor function execution time in Vercel Dashboard

## Contributing

This is a migrated BuildShip workflow. For improvements:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

[Your License Here]

## Support

For issues and questions:
- Open an issue on GitHub
- Contact: [Your Contact Info]

## Acknowledgments

- Built with [Next.js](https://nextjs.org/)
- Audio processing by [Spitch](https://spi-tch.com/)
- AI by [Gemma](https://ai.google.dev/gemma)
- Audio conversion by [Zamzar](https://zamzar.com/)
- Storage by [Google Cloud Storage](https://cloud.google.com/storage)
- Originally built with [BuildShip](https://buildship.com/)

## Changelog

### v1.0.0 (2025-11-17)
- Initial migration from BuildShip to Next.js
- Full audio processing pipeline
- Multi-language support
- Medical Q&A with Gemma AI
