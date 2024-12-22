// @ts-check
const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './playwright/e2e',
  testMatch: '**/*.pw.js',
  outputDir: './reports/playwright',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  reporter: [['list'], ['@estruyf/github-actions-reporter']],
  use: {
    baseURL: 'https://gumbs.website',
    trace: 'on-first-retry'
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] }
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
      testIgnore: [/.*axe.pw.js/, /lighthouse.pw.js/]
    }
  ]
});
