const puppeteer = require('puppeteer-core');
const path = require('path');
const fs = require('fs');

async function captureScreenshots() {
  const screenshotsDir = path.join(__dirname, '..', 'docs', 'screenshots');
  if (!fs.existsSync(screenshotsDir)) {
    fs.mkdirSync(screenshotsDir, { recursive: true });
  }

  const chromePath = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
  console.log('🚀 Launching Chrome for screenshot capture...');
  const browser = await puppeteer.launch({
    executablePath: chromePath,
    headless: true,
    defaultViewport: {
      width: 1280,
      height: 900,
      deviceScaleFactor: 2,
    },
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
  });

  const page = await browser.newPage();
  const url = 'http://localhost:5174/';
  console.log(`Navigating to ${url}...`);
  await page.goto(url, { waitUntil: 'networkidle0', timeout: 30000 });
  await new Promise((r) => setTimeout(r, 2000));

  async function selectModule(moduleName) {
    await page.evaluate((mod) => {
      const btns = Array.from(document.querySelectorAll('nav button'));
      const target = btns.find((b) => b.textContent?.toLowerCase().includes(mod) || b.getAttribute('aria-label')?.toLowerCase().includes(mod));
      if (target) target.click();
    }, moduleName);
    await new Promise((r) => setTimeout(r, 1200));
    await page.evaluate(() => window.scrollTo(0, 0));
  }

  async function selectTab(tabLabel) {
    await page.evaluate((label) => {
      const btns = Array.from(document.querySelectorAll('button'));
      const target = btns.find((b) => b.textContent?.toLowerCase().includes(label.toLowerCase()));
      if (target) target.click();
    }, tabLabel);
    await new Promise((r) => setTimeout(r, 1000));
    await page.evaluate(() => window.scrollTo(0, 0));
  }

  // 1. FIT DASHBOARD
  console.log('📸 1. Fit Dashboard...');
  await selectModule('fit');
  await selectTab('diary');
  await page.screenshot({ path: path.join(screenshotsDir, '01-fit-dashboard.png') });

  // 2. DISHES & RECIPES
  console.log('📸 2. Dishes & Meal Prep...');
  await selectTab('dishes');
  await page.screenshot({ path: path.join(screenshotsDir, '02-fit-dishes.png') });

  // 3. GYM EXERCISE CATALOG
  console.log('📸 3. Gym Exercise Catalog...');
  await selectModule('gym');
  await selectTab('exercises');
  await page.screenshot({ path: path.join(screenshotsDir, '03-gym-exercises.png') });

  // 4. GYM HISTORY & MUSCLE HEATMAP
  console.log('📸 4. Gym History & Muscle Heatmap...');
  await selectTab('history');
  await page.screenshot({ path: path.join(screenshotsDir, '04-gym-history-heatmap.png') });

  // 5. SHOPPING LIST
  console.log('📸 5. Shopping List...');
  await selectModule('shopping');
  await selectTab('active list');
  await page.screenshot({ path: path.join(screenshotsDir, '05-shopping-list.png') });

  // 6. SHOPPING COMPARATOR
  console.log('📸 6. Price Comparison...');
  await selectTab('price comparison');
  await page.screenshot({ path: path.join(screenshotsDir, '06-shopping-comparator.png') });

  // 7. COUPLE FEED
  console.log('📸 7. Couple Feed...');
  await selectModule('feed');
  await new Promise((r) => setTimeout(r, 1000));
  await page.screenshot({ path: path.join(screenshotsDir, '07-couple-feed.png') });

  // 8. MOBILE VIEWPORT
  console.log('📸 8. Mobile Fit Viewport...');
  const mobilePage = await browser.newPage();
  await mobilePage.setViewport({ width: 390, height: 844, deviceScaleFactor: 2 });
  await mobilePage.goto(url, { waitUntil: 'networkidle0', timeout: 30000 });
  await new Promise((r) => setTimeout(r, 2000));
  await mobilePage.evaluate(() => window.scrollTo(0, 0));
  await mobilePage.screenshot({ path: path.join(screenshotsDir, '08-mobile-preview.png') });

  await browser.close();
  console.log('✨ Screenshots captured perfectly in docs/screenshots/!');
}

captureScreenshots().catch((err) => {
  console.error('Screenshot capture failed:', err);
  process.exit(1);
});
