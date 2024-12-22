const BaseComponent = require('../BaseComponent');

/**
 * @extends {BaseComponent}
 */
class Joke extends BaseComponent {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    super(page);
    this.elements = {
      jokes: '#joke',
      refreshButton: 'button.refresh'
    };
  }

  async getJokes() {
    return this.page.locator(this.elements.jokes);
  }

  async getRefreshButton() {
    return this.page.locator(this.elements.refreshButton);
  }
}

module.exports = Joke;
