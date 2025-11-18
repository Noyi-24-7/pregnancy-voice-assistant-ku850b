// Upload audio to Vercel Blob Storage
const { put } = require('@vercel/blob');

module.exports = async function uploadAudioToVercelBlob({ base64, fileName }, { logging }) {
  try {
    logging.log(`Uploading audio: ${fileName}`);
    
    if (!base64) {
      throw new Error('base64 input is required');
    }
    
    if (!fileName) {
      throw new Error('fileName input is required');
    }
    
    // Handle different base64 formats
    let base64Data = base64;
    if (base64.includes(';base64,')) {
      base64Data = base64.split(';base64,').pop();
    } else if (base64.includes(',')) {
      base64Data = base64.split(',').pop();
    }
    
    // Convert to buffer
    const buffer = Buffer.from(base64Data, 'base64');
    logging.log(`Buffer size: ${buffer.length} bytes`);
    
    // Upload to Vercel Blob
    const blob = await put(fileName, buffer, {
      access: 'public',
      addRandomSuffix: false,
      contentType: 'audio/x-m4a',
    });
    
    logging.log(`Upload successful: ${blob.url}`);
    
    return {
      publicUrl: blob.url
    };
    
  } catch (error) {
    logging.error('Upload failed:', error);
    throw error;
  }
};

