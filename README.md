# MindfulMoments

**Mission:** Help people escape social media with tiny, caring micro-activities that learn from them and adapt over time.

## How it works
1. You tell the app how much time you have, where you are, what kind of activity you want, and how your energy is.
2. It proposes a micro-activity (meditation, movement, writing, brain training) and guides you with warm voice/tone.
3. After the session you give feedback (mood, difficulty, suggestions).
4. The app stores that locally and adapts future suggestions (e.g., adjusts duration, prioritizes relaxation if you're stressed).

## Key Features
- Zero sign-up required; all data stays local by default.
- Voice-guided empathetic instructions.
- Adaptive quick-start suggestions based on recent feedback and use.
- Session tracking: streaks, total minutes, total sessions.
- Feedback loop adjusts next recommendations automatically.

## Privacy
All core personalization happens in `localStorage` on your device. No data is sent anywhere unless you opt into using the optional feedback backend.

## Deployment (fastest path)
### Option A: GitHub + GitHub Pages (free)
1. Create a GitHub repository (e.g., `mindfulmoments`).
2. Clone locally and place `index.html` (your full app), this `README.md`, and `deploy.sh` in the root.
3. Run:
   ```sh
   chmod +x deploy.sh
   ./deploy.sh git@github.com:<your-user>/mindfulmoments.git
   ```
4. In repo settings > Pages, enable publishing from `gh-pages` branch or `main` if adjusted.

### Option B: Vercel (zero config)
1. Sign into vercel.com and import the repo.
2. Vercel will auto-deploy on push. No build step needed—just ensure `index.html` is at root.

## Feedback Backend (optional)
If you want aggregated, anonymized feedback to improve cold-starts or get insight across devices, deploy a lightweight Cloudflare Worker or similar.

### Example Worker
```js
export default {
  async fetch(request) {
    if (request.method !== 'POST') return new Response('Only POST', {status:405});
    try {
      const data = await request.json();
      console.log('Feedback received', {
        activityType: data.activityType,
        duration: data.duration,
        mood: data.mood,
        difficulty: data.difficulty
      });
      return new Response(JSON.stringify({status: 'ok'}), {headers: {'Content-Type': 'application/json'}});
    } catch (e) {
      return new Response('Bad request', {status:400});
    }
  }
};
```

### Client snippet
```js
fetch('https://your-worker-domain.workers.dev', {
  method: 'POST',
  headers: {'Content-Type': 'application/json'},
  body: JSON.stringify({
    activityType: currentSessionData.type,
    duration: currentSessionData.duration,
    mood: selectedRatings.mood,
    difficulty: selectedRatings.difficulty,
    feedbackText: document.getElementById('feedback-text').value,
    sessionId: currentSessionData.startTime.getTime()
  })
});
```

## Versioning
Include a version string somewhere in the UI (e.g., `const VERSION = '0.1.0'`) so you can track what users saw.

## Quick Launch Checklist
- [ ] Create GitHub repo
- [ ] Drop full `index.html` into repo root
- [ ] Add `README.md`, `deploy.sh`, and workflow
- [ ] Run deploy script
- [ ] Enable GitHub Pages or connect to Vercel
- [ ] Validate behavior live

## Next Evolution Paths
- Aggregated intelligence for cold-starts
- Remote config for phrasing
- Export/share profiles
- Multi-device opt-in sync
