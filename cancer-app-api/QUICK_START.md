# Quick Start - Deploy in 5 Minutes! ⚡

Your API keys are already configured. Let's get this deployed!

## ✅ What You Already Have

- ✅ SPITCH_API_KEY configured
- ✅ GEMMA_API_KEY configured  
- ✅ ZAMZAR_API_KEY configured
- ✅ Vercel Blob scripts ready
- ✅ No Google Cloud setup needed!

## 🚀 Deploy Now

### Step 1: Install Vercel CLI

```bash
npm install -g vercel
```

### Step 2: Login

```bash
vercel login
```

### Step 3: Deploy

```bash
cd cancer-app-api
vercel
```

Follow the prompts:
- **Set up and deploy?** → Yes
- **Which scope?** → Your account
- **Link to existing project?** → No (create new)
- **Project name?** → cancer-app-api (or your choice)
- **Directory?** → ./ (current)
- **Override settings?** → No

Wait for deployment... ⏳

### Step 4: Add Environment Variables

Go to your Vercel Dashboard: https://vercel.com/dashboard

1. Click on your **cancer-app-api** project
2. Go to **Settings** → **Environment Variables**
3. Add these 3 variables for **Production, Preview, and Development**:

| Variable | Value |
|----------|-------|
| `SPITCH_API_KEY` | `sk_rK4cVeU8LfNHZMID6py7cRIDTWFg8x85GY3ab0FG` |
| `GEMMA_API_KEY` | `AIzaSyDTK7HZCCdb_oex2Sc7g8zZysZlI6shJCY` |
| `ZAMZAR_API_KEY` | `3e3883191f7fec54040c031eaed3bbe9bcfe748d` |

**Note**: `BLOB_READ_WRITE_TOKEN` is automatically set by Vercel - don't add it!

### Step 5: Deploy to Production

```bash
vercel --prod
```

### Step 6: Test It! 🎉

```bash
# Replace YOUR_URL with your actual Vercel URL
curl https://YOUR_URL.vercel.app/api/process-audio

# Should return:
# {"status":"ok","service":"Cancer App Audio Processing API","version":"1.0.0"}
```

## ✨ You're Done!

Your API is live at: `https://YOUR_PROJECT.vercel.app/api/process-audio`

## 📝 Test with Audio

```bash
curl -X POST https://YOUR_URL.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "data:audio/m4a;base64,<base64_audio_here>",
    "sourceLanguage": "en",
    "conversationHistory": []
  }'
```

## 🔥 Pro Tips

### Faster Deployments
Add this to your `package.json`:
```json
{
  "scripts": {
    "deploy": "vercel --prod"
  }
}
```

Then just run: `npm run deploy`

### View Logs
```bash
vercel logs https://YOUR_URL.vercel.app
```

### Monitor Storage
1. Go to Vercel Dashboard
2. Click your project
3. Click **Storage** in sidebar
4. View Blob storage usage

### Redeploy
Just run `vercel --prod` again anytime!

## 🆘 Troubleshooting

### Build Fails
```bash
# Use webpack instead of Turbopack
npm run build
vercel --prod
```

### "Module not found" errors
```bash
npm install
vercel --prod
```

### Environment variables not working
1. Check they're added in Vercel Dashboard
2. Make sure they're set for **Production** environment
3. Redeploy: `vercel --prod`

## 📊 What Gets Deployed

- ✅ API endpoint: `/api/process-audio`
- ✅ Health check: GET `/api/process-audio`
- ✅ Audio processing: POST `/api/process-audio`
- ✅ Automatic storage with Vercel Blob
- ✅ All 12 workflow steps

## 💰 Costs

### Vercel Free (Hobby)
- ✅ Perfect for testing
- ✅ 100GB bandwidth/month
- ✅ 1GB Blob storage
- ⚠️ 10s function timeout (may be tight)

### Vercel Pro ($20/month)
- ✅ Recommended for production
- ✅ 1TB bandwidth/month
- ✅ 100GB Blob storage
- ✅ 60s function timeout (better for audio processing)

## 🎯 Next Steps

1. ✅ Share your API URL with your team
2. ✅ Test with real audio files
3. ✅ Monitor usage in Vercel Dashboard
4. ✅ Consider upgrading to Pro for longer timeouts

## 📚 More Info

- **Full Documentation**: See [README.md](./README.md)
- **Vercel Blob Setup**: See [VERCEL_BLOB_SETUP.md](./VERCEL_BLOB_SETUP.md)
- **Deployment Details**: See [DEPLOYMENT.md](./DEPLOYMENT.md)

---

Need help? Check the troubleshooting section in [VERCEL_BLOB_SETUP.md](./VERCEL_BLOB_SETUP.md)

