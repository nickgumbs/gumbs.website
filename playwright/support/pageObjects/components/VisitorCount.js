import BaseComponent from '../BaseComponent';

/**
 * @extends {BaseComponent}
 */
export default class VisitorCount extends BaseComponent {
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
