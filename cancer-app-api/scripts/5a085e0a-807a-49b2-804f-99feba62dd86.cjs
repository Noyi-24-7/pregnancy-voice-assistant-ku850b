// Upload synthesized audio to Vercel Blob
const { put } = require('@vercel/blob');

module.exports = async function uploadSynthesizedToVercel({ base64, fileName }, { logging }) {
  try {
    logging.log(`Uploading synthesized audio: ${fileName}`);
    
    if (!base64 || !fileName) {
      throw new Error('Missing base64 or fileName');
    }
    
    // Handle base64 data
    let base64Data = base64;
    if (base64.includes(';base64,')) {
      base64Data = base64.split(';base64,').pop();
    } else if (base64.includes(',')) {
      base64Data = base64.split(',').pop();
    }
    
    const buffer = Buffer.from(base64Data, 'base64');
    logging.log(`Buffer size: ${buffer.length} bytes`);
    
    // Upload to Vercel Blob
    const blob = await put(fileName, buffer, {
      access: 'public',
      addRandomSuffix: false,
      contentType: 'audio/mpeg',
    });
    
    logging.log(`Upload successful: ${blob.url}`);
    
    return {
      publicUrl: blob.url
    };
    
  } catch (error) {
    logging.error('Upload failed:', error);
    return { publicUrl: null, error: error.message };
  }
};

