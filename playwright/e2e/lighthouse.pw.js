// @ts-check
const { chromium } = require('@playwright/test');
const { test, expect } = require('../support/pageObjects/PageFixtures');
const { playAudit } = require('playwright-lighthouse');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const thresholds = {
  performance: 90,
  accessibility: 90,
  'best-practices': 50,
  seo: 50
};

// Get the current Git branch name
function getCurrentGitBranch() {
  try {
    return execSync('git rev-parse --abbrev-ref HEAD').toString().trim();
  } catch (error) {
    console.error('Error retrieving Git branch:', error.message);
    return 'unknown-branch';
  }
}

function ensureDirectoryExists(directory) {
  if (!fs.existsSync(directory)) {
    fs.mkdirSync(directory, { recursive: true });
    console.log(`Created directory: ${directory}`);
  }
}

test.describe('Lighthouse', () => {
  test('should verify Lighthouse Performance score', async () => {
    let branchName = getCurrentGitBranch();
    branchName = branchName.replace(/[\/\.]/g, '-');
    const reportName = `lighthouse-${branchName}.html`;
    const directoryName = path.join(process.cwd(), 'reports', 'lighthouse');

    ensureDirectoryExists(directoryName);

    const browser = await chromium.launch({
      args: ['--remote-debugging-port=9222'],
      headless: true
    });

    const context = await browser.newContext();
    const page = await context.newPage();

    try {
      await page.goto('/');
      await playAudit({
        page: page,
        thresholds: thresholds,
        port: 9222,
        reports: {
          formats: {
            html: true
          },
          name: reportName,
          directory: directoryName
        }
      });
      console.log(
        `Lighthouse audit completed successfully. Report: ${directoryName}/${reportName}.html`
      );
    } finally {
      await browser.close();
    }
  });
});
