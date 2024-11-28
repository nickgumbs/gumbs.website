export class Homepage {
  constructor() {
    this.elements = {};
    this.elements.image = '.image img';
    this.elements.siteVisitorCount = '.count';
    this.elements.jokes = '#joke';
    this.elements.refreshButton = '#joke';
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

  getJokes() {
    return cy.get(this.elements.jokes);
  }

  getRefreshButton() {
    return cy.get(this.elements.refreshButton);
  }
}

export const homepage = new Homepage();
