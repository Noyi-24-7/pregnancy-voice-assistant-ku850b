// Download from Zamzar and re-upload to Vercel Blob
const { put } = require('@vercel/blob');

module.exports = async function downloadAndReuploadToVercel({ zamzarResponse, fileName }, { logging }) {
  try {
    logging.log('Downloading MP3 from Zamzar and re-uploading to Vercel Blob');
    
    // Parse Zamzar response
    let zamzarData = zamzarResponse;
    if (typeof zamzarResponse === 'string') {
      zamzarData = JSON.parse(zamzarResponse);
    }
    
    const zamzarUrl = zamzarData.publicUrl;
    const authHeader = zamzarData.downloadHeaders.Authorization;
    
    logging.log(`Downloading from: ${zamzarUrl}`);
    
    // Download the MP3 from Zamzar
    const downloadResponse = await fetch(zamzarUrl, {
      headers: { 'Authorization': authHeader }
    });
    
    if (!downloadResponse.ok) {
      throw new Error(`Failed to download from Zamzar: ${downloadResponse.status}`);
    }
    
    const mp3Buffer = Buffer.from(await downloadResponse.arrayBuffer());
    logging.log(`Downloaded MP3: ${mp3Buffer.length} bytes`);
    
    // Upload to Vercel Blob
    const blob = await put(fileName, mp3Buffer, {
      access: 'public',
      addRandomSuffix: false,
      contentType: 'audio/mpeg',
    });
    
    logging.log(`MP3 uploaded successfully: ${blob.url}`);
    
    return {
      publicUrl: blob.url
    };
    
  } catch (error) {
    logging.error('Download and re-upload failed:', error);
    throw error;
  }
};

