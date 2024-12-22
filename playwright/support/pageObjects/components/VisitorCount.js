const BaseComponent = require('../BaseComponent');

/**
 * @extends {BaseComponent}
 */
class VisitorCount extends BaseComponent {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    super(page);
    this.elements = {
      siteVisitorCount: '.count'
    };
  }

  async getSiteVisitorCount() {
    return this.page.locator(this.elements.siteVisitorCount);
  }
}

module.exports = VisitorCount;
