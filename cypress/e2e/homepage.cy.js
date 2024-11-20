import { homepage } from '../support/pages/Homepage';
import data from '../../public/data/homepage.json';

describe('Homepage', () => {
  it('should display all images', () => {
    homepage.visit('/');
    for (const [index, module] of data.content.cartoons.modules.entries()) {
      homepage
        .getImage()
        .eq(index)
        .should('have.attr', 'src', module.src)
        .should('have.attr', 'alt', module.alt);
    }
  });

  it('should verify site visitor count', () => {
    homepage.visit('/');
    homepage
      .getSiteVisitorCount()
      .invoke('text')
      .then((count1) => {
        const initialCount = Number(count1.match(/\d+/)[0]);
        homepage.visit();
        homepage
          .getSiteVisitorCount()
          .invoke('text')
          .then((count2) => {
            const newCount = Number(count2.match(/\d+/)[0]);
            cy.wrap(initialCount).should('be.lt', newCount);
          });
      });
  });
});
