const { test: base } = require('@playwright/test');
const HomePage = require('./pages/HomePage');

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

module.exports = { test, expect: base.expect };
