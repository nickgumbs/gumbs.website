import BaseComponent from '../BaseComponent';

/**
 * @extends {BaseComponent}
 */
export default class Footer extends BaseComponent {
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
