# Deployment Checklist

Use this checklist to ensure your BuildShip to Vercel migration is complete.

## Pre-Deployment

### Environment Setup
- [ ] Copy `.env.example` to `.env.local`
- [ ] Add SPITCH_API_KEY
- [ ] Add GEMMA_API_KEY  
- [ ] Add ZAMZAR_API_KEY
- [ ] Add GOOGLE_CLOUD_PROJECT_ID
- [ ] Add GOOGLE_CLOUD_BUCKET_NAME
- [ ] Add BUCKET name
- [ ] Create/download Google Cloud service account key
- [ ] Save service account key as `service-account-key.json`
- [ ] Add GOOGLE_APPLICATION_CREDENTIALS path to `.env.local`

### Google Cloud Storage
- [ ] Create GCS bucket (or verify existing)
- [ ] Create service account with Storage Admin role
- [ ] Download service account key JSON
- [ ] Test bucket access locally
- [ ] Configure CORS settings for bucket

### Local Testing
- [ ] Run `npm install`
- [ ] Run `npm run dev:webpack` (to avoid Turbopack issues)
- [ ] Test health check: `curl http://localhost:3000/api/process-audio`
- [ ] Test with sample audio file
- [ ] Verify all workflow steps execute
- [ ] Check logs for any errors

## Vercel Deployment

### Account Setup
- [ ] Create Vercel account (if needed)
- [ ] Install Vercel CLI: `npm i -g vercel`
- [ ] Login: `vercel login`

### Deploy Project
- [ ] Run `vercel` in project directory
- [ ] Link to existing project or create new
- [ ] Confirm project settings
- [ ] Wait for deployment to complete
- [ ] Note deployment URL

### Environment Variables
- [ ] Go to Vercel Dashboard → Project → Settings → Environment Variables
- [ ] Add SPITCH_API_KEY (Production, Preview, Development)
- [ ] Add GEMMA_API_KEY (Production, Preview, Development)
- [ ] Add ZAMZAR_API_KEY (Production, Preview, Development)
- [ ] Add GOOGLE_CLOUD_PROJECT_ID (Production, Preview, Development)
- [ ] Add GOOGLE_CLOUD_BUCKET_NAME (Production, Preview, Development)
- [ ] Add BUCKET (Production, Preview, Development)
- [ ] Add Google service account credentials (as JSON string or using Vercel Secrets)

### Production Configuration
- [ ] Verify `vercel.json` settings (timeout, memory)
- [ ] Check function limits match your plan (Hobby vs Pro)
- [ ] Set up custom domain (optional)
- [ ] Configure CORS for your domain
- [ ] Deploy to production: `vercel --prod`

## Post-Deployment

### Testing
- [ ] Test health check: `curl https://your-app.vercel.app/api/process-audio`
- [ ] Test POST endpoint with English audio
- [ ] Test with other languages (yo, ha, ig, am, ti)
- [ ] Verify audio transcription works
- [ ] Verify translation works
- [ ] Verify medical Q&A works
- [ ] Verify speech synthesis works
- [ ] Check response times (should be < 30s)
- [ ] Verify error handling

### Monitoring
- [ ] Check Vercel Dashboard logs
- [ ] Monitor function execution times
- [ ] Monitor error rates
- [ ] Set up alerts for failures (optional)
- [ ] Check API usage against rate limits

### Documentation
- [ ] Update README with production URL
- [ ] Document any configuration changes
- [ ] Share API documentation with team
- [ ] Document troubleshooting steps

## Optimization (Optional)

### Performance
- [ ] Implement response caching
- [ ] Add request queuing
- [ ] Optimize audio file sizes
- [ ] Consider CDN for audio files
- [ ] Profile slow endpoints

### Security
- [ ] Add rate limiting
- [ ] Implement authentication
- [ ] Add input validation
- [ ] Set up CORS properly
- [ ] Review security logs

### Monitoring
- [ ] Set up Sentry or similar
- [ ] Add custom logging
- [ ] Create dashboards
- [ ] Set up uptime monitoring
- [ ] Configure alerts

## Common Issues to Check

- [ ] Build completes without errors
- [ ] No environment variables missing
- [ ] Service account has correct permissions
- [ ] Bucket exists and is accessible
- [ ] API keys are valid and have credits
- [ ] Function timeout is sufficient (upgrade to Pro if needed)
- [ ] Memory allocation is adequate
- [ ] CORS is configured for your domain
- [ ] No rate limit issues with external APIs

## Success Criteria

Your deployment is successful when ALL of these are true:

- [ ] Health check returns `{"status":"ok"}`
- [ ] Can process English audio end-to-end
- [ ] Can process all supported languages
- [ ] Response time is acceptable (< 30s)
- [ ] No errors in Vercel logs
- [ ] Audio files are stored in GCS
- [ ] Synthesized audio is accessible
- [ ] Error handling works correctly
- [ ] Production environment is stable for 24+ hours

## Maintenance Tasks

### Weekly
- [ ] Review error logs
- [ ] Check API usage/costs
- [ ] Monitor response times
- [ ] Verify uptime

### Monthly
- [ ] Review and rotate API keys
- [ ] Clean up old audio files from GCS
- [ ] Review and optimize costs
- [ ] Update dependencies
- [ ] Review security logs

### Quarterly
- [ ] Security audit
- [ ] Performance review
- [ ] Cost optimization
- [ ] Documentation updates
- [ ] Dependency updates

---

**Date Started**: _______________
**Date Deployed**: _______________
**Deployed By**: _______________
**Production URL**: _______________

