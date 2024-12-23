// @ts-check
import { test, expect } from '../support/pageObjects/PageFixtures';
import data from '../../public/data/homepage.json';

test.beforeEach(async ({ homePage }) => {
  await homePage.goto();
});

test.describe('Homepage', () => {
  test('should display all images', async ({ homePage }) => {
    const images = await homePage.image.getImage();
    for (const [index, module] of data.content.cartoons.modules.entries()) {
      const image = images.locator(`nth=${index}`);
      await Promise.all([
        expect(image).toHaveAttribute('src', module.src),
        expect(image).toHaveAttribute('alt', module.alt)
      ]);
    }
  });

  test('should verify site visitor count', async ({ homePage }) => {
    const visitorCountElement =
      await homePage.visitorCount.getSiteVisitorCount();
    const initialCount = Number(
      (await visitorCountElement.textContent()).match(/\d+/)[0]
    );
    await homePage.goto();
    const secondCount = Number(
      (await visitorCountElement.textContent()).match(/\d+/)[0]
    );
    await expect(initialCount).toBeLessThan(secondCount);
  });

  test('should verify joke module', async ({ homePage }) => {
    const jokeElement = await homePage.joke.getJokes();
    const refreshButton = await homePage.joke.getRefreshButton();

    await expect(jokeElement).toBeVisible();
    await expect(jokeElement).not.toHaveText('');
    const initialJoke = await jokeElement.textContent();

    await jokeElement.click();
    await expect(jokeElement).toBeVisible();
    await expect(jokeElement).not.toHaveText('');

    const secondJoke = await jokeElement.textContent();
    await expect(jokeElement).not.toContainText(initialJoke);

    await refreshButton.click();
    await expect(jokeElement).toBeVisible();
    await expect(jokeElement).not.toHaveText('');
    await expect(jokeElement).not.toContainText(secondJoke);
  });
});
