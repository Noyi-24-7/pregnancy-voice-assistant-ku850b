#!/bin/bash

# Test the API with a small audio sample
# Replace YOUR_URL with your actual Vercel deployment URL

API_URL="${1:-http://localhost:3000}"

echo "Testing Cancer App API at: $API_URL/api/process-audio"
echo ""

# Create a test request with minimal base64 audio data
# This is a tiny valid audio file for testing
AUDIO_DATA="data:audio/m4a;base64,AAAAGGZ0eXBNNEEgAAAAAE00QSBtcDQyaXNvbQAAAAhtZGF0"

echo "Sending request..."
echo ""

curl -X POST "$API_URL/api/process-audio" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d "{
    \"audioFile\": \"$AUDIO_DATA\",
    \"sourceLanguage\": \"en\",
    \"conversationHistory\": []
  }" \
  --write-out "\n\nHTTP Status: %{http_code}\n" \
  --silent \
  --show-error

echo ""
echo "Test completed!"

