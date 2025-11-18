// Vercel Blob Storage adapter - replaces Google Cloud Storage
import { put } from '@vercel/blob';

export interface UploadResult {
  publicUrl: string;
}

export async function uploadBase64ToStorage(
  base64Data: string,
  fileName: string
): Promise<UploadResult> {
  try {
    // Handle different base64 formats
    let cleanBase64 = base64Data;
    if (base64Data.includes(';base64,')) {
      cleanBase64 = base64Data.split(';base64,').pop() || '';
    } else if (base64Data.includes(',')) {
      cleanBase64 = base64Data.split(',').pop() || '';
    }

    // Convert base64 to buffer
    const buffer = Buffer.from(cleanBase64, 'base64');

    // Upload to Vercel Blob
    const blob = await put(fileName, buffer, {
      access: 'public',
      addRandomSuffix: false,
    });

    return {
      publicUrl: blob.url,
    };
  } catch (error: any) {
    throw new Error(`Failed to upload to Vercel Blob: ${error.message}`);
  }
}

export async function uploadBufferToStorage(
  buffer: Buffer,
  fileName: string,
  contentType: string = 'audio/mpeg'
): Promise<UploadResult> {
  try {
    const blob = await put(fileName, buffer, {
      access: 'public',
      addRandomSuffix: false,
      contentType,
    });

    return {
      publicUrl: blob.url,
    };
  } catch (error: any) {
    throw new Error(`Failed to upload buffer to Vercel Blob: ${error.message}`);
  }
}

