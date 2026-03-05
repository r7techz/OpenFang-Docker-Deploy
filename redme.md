# 🦊 OpenFang Docker Deploy

Custom Docker deployment for OpenFang with all dependencies pre-installed — Browser Hand, Clip Hand, Skills, aur Custom Hands sab support karta hai.

**Render, Railway, Fly.io, aur Coolify ke saath compatible.**

---

## 📁 Project Structure

```
openfang-deploy/
├── Dockerfile          ← Main build file (packages + config)
├── README.md           ← Yeh file
├── packages.txt        ← Optional package list reference
└── skills/             ← Custom skills (optional)
    └── my-skill/
        └── SKILL.md
```

---

## 🚀 Deploy Steps

### Render par Deploy

1. GitHub par yeh repo fork/clone karo
2. Render → **New Web Service** → **GitHub se connect karo**
3. Render automatically Dockerfile detect karega
4. Environment variables daalo (neeche dekho)
5. **Deploy** dabao ✅

### Railway par Deploy

1. Railway → **New Project** → **Deploy from GitHub repo**
2. Repo select karo
3. Environment variables daalo
4. Automatic deploy ho jayega ✅

---

## ⚙️ Environment Variables

Render/Railway ke **Environment** tab mein yeh daalo:

```env
PORT=4200
OPENFANG_LISTEN=0.0.0.0:4200
GEMINI_API_KEY=apni_gemini_key_yahan
GROQ_API_KEY=apni_groq_key_yahan
OPENROUTER_API_KEY=apni_openrouter_key_yahan
TELEGRAM_BOT_TOKEN=apna_telegram_token_yahan
TELEGRAM_ENABLED=true
```

---

## 📦 Packages — Kaise Add Karein

### Step 1: Dockerfile kholo

`Dockerfile` mein yeh section dhundo:

```dockerfile
RUN apt-get update && apt-get install -y \
    ffmpeg \
    ...
```

### Step 2: Naya package add karo

**Koi bhi apt package:**
```dockerfile
RUN apt-get update && apt-get install -y \
    ffmpeg \
    yt-dlp \
    tesseract-ocr \       ← OCR ke liye
    imagemagick \         ← Image processing ke liye
    poppler-utils \       ← PDF tools ke liye
    && rm -rf /var/lib/apt/lists/*
```

**Python packages:**
```dockerfile
RUN pip install --no-cache-dir \
    requests \
    pillow \
    openai \              ← OpenAI SDK
    anthropic \           ← Claude SDK
    pandas \              ← Data analysis
    beautifulsoup4        ← Web scraping
```

### Step 3: GitHub par commit karo → Auto redeploy hoga ✅

---

## 🤚 Hands — Kaise Setup Karein

Hands OpenFang ke autonomous agents hain jo bina prompt ke kaam karte hain.

### Browser Hand Setup

**Kya karta hai:** Websites navigate karta hai, forms fill karta hai, buttons click karta hai.

**Required packages (Dockerfile mein already hain):**
```dockerfile
RUN apt-get install -y python3 chromium
RUN pip install playwright
RUN playwright install chromium
```

**Dashboard se activate karna:**
1. OpenFang Dashboard → **Hands** section
2. **Browser Hand** → **Set up**
3. Dependencies verify ho jayengi ✅
4. **Launch** dabao

**Example tasks:**
```
"Google par search karo aur result do"
"Is website ka form fill karo"
"Amazon par product ki price check karo"
```

---

### Clip Hand Setup

**Kya karta hai:** YouTube videos download karke viral short clips banata hai captions aur thumbnails ke saath.

**Required packages (Dockerfile mein already hain):**
```dockerfile
RUN apt-get install -y ffmpeg yt-dlp python3
```

**Dashboard se activate karna:**
1. OpenFang Dashboard → **Hands** section
2. **Clip Hand** → **Set up**
3. Dependencies verify ho jayengi ✅
4. **Configure** mein output folder set karo
5. **Launch** dabao

**Example tasks:**
```
"Is YouTube video ke best 3 clips nikalo: [URL]"
"Video ko vertical format mein crop karo"
"Captions add karo aur Telegram par bhejo"
```

---

### Researcher Hand Setup

**Kya karta hai:** Autonomous deep research — multiple sources cross-reference karta hai, cited reports generate karta hai.

**No extra packages needed** — built-in hai ✅

**Dashboard se activate karna:**
1. OpenFang Dashboard → **Hands** → **Researcher**
2. **Configure** mein topic aur schedule set karo
3. **Launch** dabao — woh khud kaam karna shuru kar dega!

**Example tasks:**
```
"Har roz subah 8 baje AI news research karo aur Telegram par bhejo"
"Mere competitors ka weekly analysis karo"
```

---

### Lead Hand Setup

**Kya karta hai:** Daily prospects dhundta hai, enrich karta hai, score karta hai, CSV/JSON mein deliver karta hai.

**Dashboard se activate karna:**
1. **Hands** → **Lead** → **Configure**
2. ICP (Ideal Customer Profile) define karo
3. Schedule set karo (daily recommended)
4. **Launch** ✅

---

## 🧠 Skills — Kaise Add Karein

Skills AI ko extra knowledge deti hain. Teen tarike hain:

### Tarika 1 — FangHub se Install (Dashboard)

1. Dashboard → **Skills** section
2. Koi bhi skill dhundo (Weather, Coding, etc.)
3. **Install** dabao

> ⚠️ Rate limited ho sakta hai — thoda wait karo aur dobara try karo

---

### Tarika 2 — Custom SKILL.md banana (Recommended)

**Step 1:** Repo mein `skills/` folder banao

**Step 2:** Apni skill ka folder banao, example:

```
skills/
└── hinglish-assistant/
    └── SKILL.md
```

**Step 3:** `SKILL.md` file banao is format mein:

```markdown
---
name: hinglish-assistant
description: Hindi aur English mix mein baat karne wala assistant
version: 1.0.0
author: marsel7
---

# Hinglish Assistant

## Behavior
- Hamesha Hindi aur English mix mein jawab do
- Friendly aur helpful tone rakho
- Technical terms English mein rakho

## Knowledge Base

### Common Responses
- Greetings: "Namaste! Kya haal hai?"
- Farewell: "Alvida! Phir milenge!"

## Examples
User: "What is AI?"
Assistant: "AI matlab Artificial Intelligence hai — yeh ek technology hai jo..."
```

**Step 4:** Dockerfile mein add karo:

```dockerfile
COPY skills/ /root/.openfang/skills/
```

**Step 5:** GitHub commit karo → Redeploy → Dashboard mein skill dikhegi ✅

---

### Tarika 3 — Dashboard se Direct Add

1. Dashboard → **Skills** → **"+" button**
2. SKILL.md content paste karo
3. Save karo ✅

---

## 🔄 Redeploy Kaise Karein

**Render:**
- Automatic — GitHub commit push karo, Render khud build karega

**Railway:**
- Automatic — GitHub commit push karo, Railway khud build karega

**Manual:**
- Render/Railway dashboard → **"Redeploy"** button dabao

---

## 🐛 Common Errors aur Fix

| Error | Cause | Fix |
|---|---|---|
| `sudo: not found` | Container mein sudo nahi hota | Dockerfile mein `USER root` add karo |
| `Rate limited` | FangHub se bahut zyada requests | 5-10 min wait karo |
| `Run cancelled` | RAM ya timeout issue | Chota model use karo (llama-3.1-8b) |
| `Port not found` | Wrong port | `PORT=4200` env var add karo |
| `Playwright not found` | Browser Hand dependency | Dockerfile mein playwright add karo |

---

## 💡 Tips

- **Free plan ke liye** Groq ka `llama-3.1-8b` model use karo — sabse fast aur free!
- **UptimeRobot** lagao taaki service sleep na kare — `https://uptimerobot.com`
- **Skills rate limit** aaye toh 10 min baad try karo
- **Multiple providers** add karo — Groq + Gemini + OpenRouter — auto fallback karta hai

---

## 📞 Support

- GitHub Issues: https://github.com/RightNow-AI/openfang/issues
- Discord: https://discord.gg/sSJqgNnq6X
