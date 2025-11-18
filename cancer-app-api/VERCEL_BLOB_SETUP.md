# Simplified Setup with Vercel Blob Storage

## ✅ No Google Cloud Storage Needed!

This version uses **Vercel Blob Storage** instead of Google Cloud Storage, making setup much simpler.

## Prerequisites

1. Node.js 18+ installed
2. Your API keys (which you already have):
   - ✅ SPITCH_API_KEY
   - ✅ GEMMA_API_KEY
   - ✅ ZAMZAR_API_KEY

## Quick Start

### 1. Your API Keys Are Already Configured ✓

Your `.env.local` file is already set up with:
```env
SPITCH_API_KEY=sk_rK4cVeU8LfNHZMID6py7cRIDTWFg8x85GY3ab0FG
GEMMA_API_KEY=AIzaSyDTK7HZCCdb_oex2Sc7g8zZysZlI6shJCY
ZAMZAR_API_KEY=3e3883191f7fec54040c031eaed3bbe9bcfe748d
```

### 2. Test Locally (Optional)

For local testing with Vercel Blob, you'll need a local development token:

```bash
# Install Vercel CLI
npm i -g vercel

# Link your project
vercel link

# Pull environment variables (this will set up BLOB_READ_WRITE_TOKEN)
vercel env pull .env.local
```

Then run:
```bash
npm run dev:webpack
```

**OR** skip local testing and deploy directly to Vercel (recommended)!

### 3. Deploy to Vercel

```bash
# Login to Vercel
vercel login

# Deploy
vercel

# Deploy to production
vercel --prod
```

### 4. Configure Environment Variables in Vercel

In Vercel Dashboard → Your Project → Settings → Environment Variables:

Add these for **Production**, **Preview**, and **Development**:

1. `SPITCH_API_KEY` = `sk_rK4cVeU8LfNHZMID6py7cRIDTWFg8x85GY3ab0FG`
2. `GEMMA_API_KEY` = `AIzaSyDTK7HZCCdb_oex2Sc7g8zZysZlI6shJCY`
3. `ZAMZAR_API_KEY` = `3e3883191f7fec54040c031eaed3bbe9bcfe748d`

**Note**: `BLOB_READ_WRITE_TOKEN` is automatically set by Vercel - you don't need to add it!

### 5. Test Your Deployment

```bash
# Health check
curl https://your-app.vercel.app/api/process-audio

# Should return:
# {"status":"ok","service":"Cancer App Audio Processing API","version":"1.0.0"}
```

## What Changed from Google Cloud Storage?

### Before (with GCS):
- ❌ Need Google Cloud account
- ❌ Create GCS bucket
- ❌ Create service account
- ❌ Download credentials JSON
- ❌ Configure GOOGLE_CLOUD_PROJECT_ID
- ❌ Configure GOOGLE_CLOUD_BUCKET_NAME
- ❌ Configure GOOGLE_APPLICATION_CREDENTIALS

### After (with Vercel Blob):
- ✅ Just deploy to Vercel
- ✅ Storage is automatically configured
- ✅ No additional setup needed

## How Vercel Blob Works

1. **Automatic Setup**: When you deploy to Vercel, Blob storage is automatically available
2. **No Configuration**: The `BLOB_READ_WRITE_TOKEN` is set automatically
3. **Public URLs**: Uploaded files get public URLs automatically
4. **Pay-as-you-go**: Free tier includes 1GB storage and 10GB bandwidth

## Storage Locations Updated

The following scripts now use Vercel Blob instead of GCS:

1. ✅ `scripts/upload-audio-vercel.cjs` - Upload input audio
2. ✅ `scripts/download-reupload-vercel.cjs` - Download & re-upload converted audio
3. ✅ `scripts/upload-synthesized-vercel.cjs` - Upload synthesized audio

All three handle the same workflow but use Vercel Blob's simple API.

## Vercel Blob Limits

### Free Tier (Hobby):
- 1 GB storage
- 10 GB bandwidth per month
- More than enough for testing

### Pro Plan ($20/month):
- 100 GB storage  
- 1 TB bandwidth per month

## Testing Your API

Once deployed, test with:

```bash
curl -X POST https://your-app.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "data:audio/m4a;base64,<your_base64_audio>",
    "sourceLanguage": "en",
    "conversationHistory": []
  }'
```

Expected response:
```json
{
  "success": true,
  "translatedText": "Medical response...",
  "audioUrl": "https://blob.vercel-storage.com/...",
  "transcribedText": "Question...",
  "sourceLanguage": "en",
  "error": null
}
```

## Troubleshooting

### "BLOB_READ_WRITE_TOKEN is not defined"

**Solution**: This only happens in local development. Either:
1. Run `vercel env pull` to get the token
2. Skip local testing and deploy directly to Vercel

### Storage URLs not working

**Solution**: Vercel Blob URLs are automatically public. If you can't access them:
1. Check that the upload succeeded (check logs)
2. Verify the URL format: `https://blob.vercel-storage.com/...`

### Out of storage space

**Solution**: 
1. Check usage in Vercel Dashboard → Storage
2. Upgrade to Pro plan for more storage
3. Implement cleanup for old audio files

## Monitoring Storage Usage

1. Go to Vercel Dashboard
2. Select your project
3. Click "Storage" in the sidebar
4. View Blob storage usage and files

## Cost Comparison

### Google Cloud Storage:
- Setup time: ~30 minutes
- Complexity: High
- Cost: ~$0.026/GB/month + bandwidth

### Vercel Blob:
- Setup time: 0 minutes (automatic)
- Complexity: None
- Cost: Free tier (1GB) or $20/month Pro (100GB)

## Next Steps

1. ✅ Deploy to Vercel: `vercel --prod`
2. ✅ Add environment variables in Vercel Dashboard
3. ✅ Test the API endpoint
4. ✅ You're done!

No Google Cloud setup needed! 🎉

