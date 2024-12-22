const BaseComponent = require('../BaseComponent');

/**
 * @extends {BaseComponent}
 */
class Footer extends BaseComponent {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    super(page);
    this.elements.footer = '#footer';
  }

  async getFooter() {
    return this.page.locator(this.elements.footer);
  }
}

module.exports = Footer;
