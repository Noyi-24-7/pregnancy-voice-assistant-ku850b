# Script Mapping: Google Cloud Storage → Vercel Blob

The original BuildShip export created scripts that use Google Cloud Storage. 
We've created simplified alternatives using Vercel Blob.

## Replacements Needed

To use Vercel Blob instead of Google Cloud Storage, replace the following scripts:

### 1. Upload Input Audio
- **Original**: `scripts/e25c9a7a-7e2d-492f-90d8-6e1139f8a67f.cjs`
- **New**: `scripts/upload-audio-vercel.cjs` ✅ Created

### 2. Download & Re-upload
- **Original**: `scripts/ba67b2a1-66c2-4144-9144-9914ffb7cff1.cjs`
- **New**: `scripts/download-reupload-vercel.cjs` ✅ Created

### 3. Upload Synthesized Audio
- **Original**: `scripts/5a085e0a-807a-49b2-804f-99feba62dd86.cjs`
- **New**: `scripts/upload-synthesized-vercel.cjs` ✅ Created

## Implementation

You have two options:

### Option A: Replace the original scripts (Recommended)

```bash
cd cancer-app-api/scripts

# Backup originals
cp e25c9a7a-7e2d-492f-90d8-6e1139f8a67f.cjs e25c9a7a-7e2d-492f-90d8-6e1139f8a67f.cjs.backup
cp ba67b2a1-66c2-4144-9144-9914ffb7cff1.cjs ba67b2a1-66c2-4144-9144-9914ffb7cff1.cjs.backup
cp 5a085e0a-807a-49b2-804f-99feba62dd86.cjs 5a085e0a-807a-49b2-804f-99feba62dd86.cjs.backup

# Replace with Vercel Blob versions
cp upload-audio-vercel.cjs e25c9a7a-7e2d-492f-90d8-6e1139f8a67f.cjs
cp download-reupload-vercel.cjs ba67b2a1-66c2-4144-9144-9914ffb7cff1.cjs
cp upload-synthesized-vercel.cjs 5a085e0a-807a-49b2-804f-99feba62dd86.cjs
```

### Option B: Keep both versions

Keep both and choose which to use based on where you deploy.
- Use GCS scripts if deploying elsewhere with GCS
- Use Vercel Blob scripts when deploying to Vercel

## What's Different?

### Google Cloud Storage Version:
```javascript
import { Storage } from '@google-cloud/storage';

const storage = new Storage();
const bucket = storage.bucket(process.env.BUCKET);
const file = bucket.file(fileName);
// ... complex folder creation, streaming, etc.
```

### Vercel Blob Version:
```javascript
const { put } = require('@vercel/blob');

const blob = await put(fileName, buffer, {
  access: 'public',
  addRandomSuffix: false,
});
// Done! blob.url is your public URL
```

## Benefits of Vercel Blob

1. **Simpler Code**: 5 lines vs 50+ lines
2. **No Setup**: Automatic in Vercel environment
3. **No Credentials**: Token is auto-configured
4. **Public URLs**: Automatically public, no makePublic() needed
5. **Built-in**: No separate service to manage

## Running the Replacement

Run this command to apply the changes:

```bash
cd /Users/noyi/Downloads/preggos/pregnancy-voice-assistant-ku850b/cancer-app-api/scripts
cp upload-audio-vercel.cjs e25c9a7a-7e2d-492f-90d8-6e1139f8a67f.cjs
cp download-reupload-vercel.cjs ba67b2a1-66c2-4144-9144-9914ffb7cff1.cjs
cp upload-synthesized-vercel.cjs 5a085e0a-807a-49b2-804f-99feba62dd86.cjs
```

Now your workflow will use Vercel Blob! ✅

