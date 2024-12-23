// // @ts-check
const { test, expect } = require('../support/pageObjects/PageFixtures');
const AxeBuilder = require('@axe-core/playwright').default;

test.describe('Accessibility Scans', () => {
  test.describe.configure({ retries: 0 });

  test('HomePage a11y', async ({ homePage }) => {
    await homePage.goto();
    const accessibilityScanResults = await new AxeBuilder({
      page: homePage.page
    }).analyze();
    expect(accessibilityScanResults.violations).toEqual([]);
  });
});
