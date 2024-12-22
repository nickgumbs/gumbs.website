const BaseComponent = require('../BaseComponent');

/**
 * @extends {BaseComponent}
 */
class Image extends BaseComponent {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    super(page);
    this.elements.image = '.image img';
  }

  async goto() {
    await super.goto('/');
  }

  async getImage() {
    return this.page.locator(this.elements.image);
  }
}

module.exports = Image;
