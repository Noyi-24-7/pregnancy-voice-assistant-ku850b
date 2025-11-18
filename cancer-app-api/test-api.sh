#!/bin/bash

# Test script for the Cancer App Audio Processing API

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

API_URL="${API_URL:-http://localhost:3000}"

echo -e "${YELLOW}Testing Cancer App Audio Processing API${NC}"
echo "API URL: $API_URL"
echo ""

# Test 1: Health Check
echo -e "${YELLOW}Test 1: Health Check (GET)${NC}"
RESPONSE=$(curl -s -X GET "$API_URL/api/process-audio")
echo "Response: $RESPONSE"

if echo "$RESPONSE" | grep -q '"status":"ok"'; then
    echo -e "${GREEN}✓ Health check passed${NC}"
else
    echo -e "${RED}✗ Health check failed${NC}"
    exit 1
fi

echo ""

# Test 2: Process Audio (Mock Request)
echo -e "${YELLOW}Test 2: Process Audio (POST) - Mock Data${NC}"
echo "Note: This requires actual base64 audio data to work properly"
echo "Sending a minimal request to check endpoint structure..."

RESPONSE=$(curl -s -X POST "$API_URL/api/process-audio" \
    -H "Content-Type: application/json" \
    -d '{
        "audioFile": "data:audio/m4a;base64,AAAA",
        "sourceLanguage": "en",
        "conversationHistory": []
    }')

echo "Response: $RESPONSE"

if echo "$RESPONSE" | grep -q '"error"'; then
    echo -e "${YELLOW}⚠ Endpoint reachable but returned error (expected with mock data)${NC}"
else
    echo -e "${GREEN}✓ Process audio endpoint is responsive${NC}"
fi

echo ""
echo -e "${GREEN}API Testing Complete${NC}"
echo ""
echo "To test with real audio:"
echo "1. Encode an audio file to base64: base64 -i audio.m4a"
echo "2. Use the full base64 string in the 'audioFile' field"
echo "3. Ensure all API keys are configured in .env.local"

