export class Homepage {
  constructor() {
    this.elements = {};
    this.elements.image = '.image img';
    this.elements.siteVisitorCount = '.count';
  }

  visit() {
    cy.intercept('/data/homepage.json').as('data');
    cy.intercept('*/jokes').as('jokes');
    cy.intercept('*/visit').as('visit');
    cy.visit('/');
    cy.wait(['@data', '@jokes', '@visit']);
  }

  getImage() {
    return cy.get(this.elements.image);
  }

  getSiteVisitorCount() {
    return cy.get(this.elements.siteVisitorCount);
  }
}

export const homepage = new Homepage();
