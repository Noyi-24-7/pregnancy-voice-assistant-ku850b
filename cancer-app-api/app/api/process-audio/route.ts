import { NextRequest, NextResponse } from 'next/server';
import execute from '@/lib/cancerApp/index';

export const runtime = 'nodejs';
export const maxDuration = 60; // Maximum execution time in seconds

export async function POST(request: NextRequest) {
  try {
    // Parse the request body
    const body = await request.json();
    
    // Validate required inputs
    const { audioFile, sourceLanguage, conversationHistory } = body;
    
    if (!audioFile) {
      return NextResponse.json(
        { error: 'audioFile is required' },
        { status: 400 }
      );
    }
    
    if (!sourceLanguage) {
      return NextResponse.json(
        { error: 'sourceLanguage is required' },
        { status: 400 }
      );
    }
    
    // Prepare inputs for the workflow
    const inputs = {
      audioFile,
      sourceLanguage,
      conversationHistory: conversationHistory || []
    };
    
    // Initialize root context
    const root: any = {};
    
    // Execute the workflow
    try {
      await execute(inputs, root);
    } catch (error) {
      // The workflow throws "STOP" to halt execution, which is expected
      if (error !== "STOP") {
        throw error;
      }
    }
    
    // Extract the result from root context
    const result = root.output?.result || {};
    
    // Return the response
    return NextResponse.json({
      success: true,
      translatedText: result.translatedText || '',
      audioUrl: result.audioUrl?.publicUrl || result.audioUrl || '',
      error: result.error || null,
      transcribedText: root['a4e5a4d6-d8d1-4840-b19c-e643c6355aba']?.transcribedText || '',
      sourceLanguage
    });
    
  } catch (error: any) {
    console.error('Error processing audio:', error);
    
    return NextResponse.json(
      {
        success: false,
        error: error?.message || 'An error occurred while processing the audio',
        details: process.env.NODE_ENV === 'development' ? error?.stack : undefined
      },
      { status: 500 }
    );
  }
}

// Health check endpoint
export async function GET() {
  return NextResponse.json({
    status: 'ok',
    service: 'Cancer App Audio Processing API',
    version: '1.0.0'
  });
}

