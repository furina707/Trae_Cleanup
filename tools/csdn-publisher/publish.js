import { chromium } from "playwright";
import fs from "fs";
import path from "path";

function arg(name, def) {
  const idx = process.argv.findIndex((v) => v === `--${name}`);
  if (idx !== -1 && process.argv[idx + 1]) return process.argv[idx + 1];
  return def;
}

async function loadCookies(cookiesPath) {
  if (!cookiesPath) return [];
  const p = path.resolve(cookiesPath);
  if (!fs.existsSync(p)) return [];
  const raw = fs.readFileSync(p, "utf8");
  try {
    const data = JSON.parse(raw);
    if (Array.isArray(data)) return data.map((c) => ({ ...c, sameSite: c.sameSite || "Lax" }));
    return [];
  } catch {
    return [];
  }
}

async function main() {
  const title = arg("title", "Trae Cleanup Tool 发布");
  const mdPath = arg("md", path.resolve("../../PROMOTION.md"));
  const cookiesPath = arg("cookies", "");
  const draft = arg("draft", "false") === "true";

  const body = fs.existsSync(mdPath) ? fs.readFileSync(mdPath, "utf8") : "内容缺失";

  const browser = await chromium.launch({ headless: false });
  const context = await browser.newContext();
  const cookies = await loadCookies(cookiesPath);
  if (cookies.length) await context.addCookies(cookies);
  const page = await context.newPage();

  await page.goto("https://editor.csdn.net/md/", { waitUntil: "domcontentloaded" });

  const titleSelectors = [
    'input[placeholder*="标题"]',
    'input[placeholder*="文章"]',
    'input[type="text"]'
  ];
  let filledTitle = false;
  for (const sel of titleSelectors) {
    const loc = page.locator(sel).first();
    if (await loc.count()) {
      await loc.fill(title);
      filledTitle = true;
      break;
    }
  }
  if (!filledTitle) {
    const inputs = page.locator("input");
    if (await inputs.count()) {
      await inputs.nth(0).fill(title);
    }
  }

  const editorSelectors = [
    'div[contenteditable="true"]',
    '.md-editor, .editor',
    '.CodeMirror-code',
    'textarea'
  ];
  let editorSet = false;
  for (const sel of editorSelectors) {
    const loc = page.locator(sel).first();
    if (await loc.count()) {
      await loc.click();
      await page.keyboard.insertText(body);
      editorSet = true;
      break;
    }
  }
  if (!editorSet) {
    await page.keyboard.insertText(body);
  }

  if (draft) {
    await page.waitForTimeout(2000);
    await browser.close();
    process.exit(0);
  }

  const publishLocators = [
    page.getByRole("button", { name: /发布/ }),
    page.locator('button:has-text("发布")'),
    page.locator('button:has-text("发布文章")')
  ];
  let clicked = false;
  for (const b of publishLocators) {
    if (await b.count()) {
      await b.click();
      clicked = true;
      break;
    }
  }

  if (!clicked) {
    await page.keyboard.press("Control+S");
  }

  await page.waitForTimeout(5000);
  await browser.close();
}

main();
