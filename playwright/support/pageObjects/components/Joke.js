import BaseComponent from '../BaseComponent';

/**
 * @extends {BaseComponent}
 */
export default class Joke extends BaseComponent {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    super(page);
    this.elements.jokes = '#joke';
    this.elements.refreshButton = 'button.refresh';
  }

  async getJokes() {
    return this.page.locator(this.elements.jokes);
  }

  async getRefreshButton() {
    return this.page.locator(this.elements.refreshButton);
  }
}
