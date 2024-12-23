// // @ts-check
import { test, expect } from '../support/pageObjects/PageFixtures';
import AxeBuilder from '@axe-core/playwright';

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
