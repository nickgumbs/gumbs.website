import { test as base, expect } from '@playwright/test';
import HomePage from './pages/HomePage.js';

/**
 * @typedef {Object} PageObjects
 * @property {HomePage} homePage
 */
const test = base.extend(
  /** @type {import('@playwright/test').Fixtures<PageObjects>} */
  {
    homePage: async ({ page }, use) => {
      const homePage = new HomePage(page);
      await use(homePage);
    }
  }
);

export { test, expect };
