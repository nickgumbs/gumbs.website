class BaseComponent {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    this.page = page;
    this.elements = {};
  }
}

export default BaseComponent;
