# How to Test Your API

## The Error You Saw

The error `curl: (6) Could not resolve host: https` happens when the URL in your curl command is malformed. This usually means:
1. The URL is split across lines incorrectly
2. There are extra spaces or quotes
3. The `-d` data payload has syntax issues

## ✅ Correct Way to Test

### Method 1: Use the Test Script (Easiest)

I created a test script for you:

```bash
# Test locally (if running dev server)
./test-with-audio.sh http://localhost:3000

# Test your Vercel deployment
./test-with-audio.sh https://your-app.vercel.app
```

### Method 2: Manual curl Command (One-liner)

**For local testing:**
```bash
curl -X POST http://localhost:3000/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{"audioFile":"data:audio/m4a;base64,AAAAGGZ0eXBNNEEgAAAAAE00QSBtcDQyaXNvbQAAAAhtZGF0","sourceLanguage":"en","conversationHistory":[]}'
```

**For Vercel deployment:**
```bash
curl -X POST https://YOUR-URL.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{"audioFile":"data:audio/m4a;base64,AAAAGGZ0eXBNNEEgAAAAAE00QSBtcDQyaXNvbQAAAAhtZGF0","sourceLanguage":"en","conversationHistory":[]}'
```

### Method 3: Save JSON to File (For Large Audio)

1. Create a file called `test-request.json`:

```json
{
  "audioFile": "data:audio/m4a;base64,YOUR_BASE64_AUDIO_HERE",
  "sourceLanguage": "en",
  "conversationHistory": []
}
```

2. Test with curl:

```bash
curl -X POST https://YOUR-URL.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d @test-request.json
```

## 🎯 Testing Steps

### 1. First, Test Health Check

```bash
# Local
curl http://localhost:3000/api/process-audio

# Vercel
curl https://YOUR-URL.vercel.app/api/process-audio
```

Should return:
```json
{"status":"ok","service":"Cancer App Audio Processing API","version":"1.0.0"}
```

### 2. Then Test with Audio

Use one of the methods above with actual audio data.

## 📝 How to Get Base64 Audio Data

### On macOS/Linux:

```bash
# Convert audio file to base64
base64 -i your-audio.m4a | tr -d '\n' > audio-base64.txt

# Then use it in your request
AUDIO_DATA=$(cat audio-base64.txt)
curl -X POST https://YOUR-URL.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d "{\"audioFile\":\"data:audio/m4a;base64,$AUDIO_DATA\",\"sourceLanguage\":\"en\",\"conversationHistory\":[]}"
```

### On Windows (PowerShell):

```powershell
$bytes = [System.IO.File]::ReadAllBytes("your-audio.m4a")
$base64 = [System.Convert]::ToBase64String($bytes)
$json = @{
    audioFile = "data:audio/m4a;base64,$base64"
    sourceLanguage = "en"
    conversationHistory = @()
} | ConvertTo-Json

Invoke-RestMethod -Uri "https://YOUR-URL.vercel.app/api/process-audio" `
  -Method POST `
  -ContentType "application/json" `
  -Body $json
```

## 🔍 Common Issues

### Issue 1: "Could not resolve host"
**Problem**: URL is malformed or has extra spaces
**Solution**: Make sure the URL is on one line or properly escaped with backslashes `\`

### Issue 2: "Empty reply from server"
**Problem**: Server isn't running or URL is wrong
**Solution**: 
- Check if dev server is running: `npm run dev:webpack`
- Verify the URL is correct

### Issue 3: "Error 400 Bad Request"
**Problem**: JSON payload is invalid
**Solution**: 
- Make sure JSON is properly formatted
- Check that audioFile, sourceLanguage are present
- Ensure base64 data is valid

### Issue 4: "Error 500 Internal Server Error"
**Problem**: Missing environment variables or API keys invalid
**Solution**:
- Check environment variables are set
- Verify API keys are valid
- Check Vercel logs: `vercel logs`

## 📊 Expected Response

### Successful Response:
```json
{
  "success": true,
  "translatedText": "Medical response in user's language",
  "audioUrl": "https://blob.vercel-storage.com/...",
  "transcribedText": "Original question transcribed",
  "sourceLanguage": "en",
  "error": null
}
```

### Error Response:
```json
{
  "success": false,
  "error": "Error message here",
  "details": "Stack trace (only in development)"
}
```

## 🚀 Quick Test Commands

**Test health check:**
```bash
curl https://YOUR-URL.vercel.app/api/process-audio
```

**Test with minimal audio (using script):**
```bash
./test-with-audio.sh https://YOUR-URL.vercel.app
```

**Test with your own audio file:**
```bash
# 1. Convert to base64
base64 -i my-audio.m4a | tr -d '\n' > audio.txt

# 2. Create JSON file
cat > request.json << 'EOF'
{
  "audioFile": "data:audio/m4a;base64,PASTE_BASE64_HERE",
  "sourceLanguage": "en",
  "conversationHistory": []
}
EOF

# 3. Send request
curl -X POST https://YOUR-URL.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d @request.json
```

## 💡 Tips

1. **Start small**: Test with the minimal base64 sample first
2. **Check logs**: Use `vercel logs` to see what's happening
3. **Test locally first**: Run `npm run dev:webpack` and test on localhost
4. **File size limits**: Vercel has a 4.5MB body limit for Hobby plan
5. **Timeout**: Processing can take 10-30 seconds - be patient!

---

Need help? Check the DEPLOYMENT.md for more troubleshooting tips!

