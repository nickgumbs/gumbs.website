import Footer from './components/Footer.js';

export default class BasePage {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    this.page = page;
    this.elements = {};
    this.footer = new Footer(page);
  }

  async goto(path) {
    await this.page.goto(path);
  }
}
