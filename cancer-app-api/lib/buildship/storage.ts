// Stub file - we use Vercel Blob Storage instead of Google Cloud Storage
// This file exists for compatibility with BuildShip utilities but doesn't actually use GCS

export const bucket = {
  name: process.env.BUCKET || 'vercel-blob',
  file: (fileName: string) => ({
    name: fileName,
    // These methods are stubs - actual storage happens in the script files using Vercel Blob
    createWriteStream: () => null,
    makePublic: () => Promise.resolve(),
    exists: () => Promise.resolve([false]),
    save: () => Promise.resolve(),
    publicUrl: () => `https://blob.vercel-storage.com/${fileName}`,
  }),
};
