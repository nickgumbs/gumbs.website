import BasePage from '../BasePage.js';
import Image from '../components/Image.js';
import Joke from '../components/Joke.js';
import VisitorCount from '../components/VisitorCount.js';

/**
 * @extends {BasePage}
 */
export default class HomePage extends BasePage {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    super(page);
    this.image = new Image(page);
    this.joke = new Joke(page);
    this.visitorCount = new VisitorCount(page);
  }

  async goto() {
    const dataReq = this.page.waitForRequest('/data/homepage.json');
    const jokes = this.page.waitForRequest('**/jokes');
    const visit = this.page.waitForRequest('**/visit');

    await super.goto('/');
    await Promise.all([dataReq, jokes, visit]);
    await this.page.waitForLoadState('networkidle');
  }
}
