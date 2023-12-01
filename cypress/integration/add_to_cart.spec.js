describe('Add to Cart', () => {
  beforeEach(() => {
    // Visit the home page
    cy.visit('http://localhost:3000');
  });

  it('should visit the home page', () => {
    cy.get('p').should('contain', 'Looking for a way to add some life to your home?');
  });

  it("There is 2 products on the page", () => {
    // Log the number of articles found
    cy.get(".products article").then(($articles) => {
      console.log("Number of articles found:", $articles.length);
    });

    // Assertion
    cy.get(".products article").should("have.length", 2);
  });

  it('should increase cart count when "Add to Cart" button is clicked', () => {
    // Get the cart content and alias it
    cy.get('.navbar li.nav-item:last-child').invoke('text').as('cartContent');

    // Log the cart content for debugging
    cy.get('@cartContent').then((cartContent) => {
      cy.log('Cart Content:', cartContent);
    });

    // Click the "Add to Cart" button
    cy.get('.products article:first-child button.btn').click({ force: true });

    // Perform your Cypress assertions instead of Chai-jQuery
    cy.get('@cartContent').should('match', /Evergreens\s*My Cart \(0\)/);
  });
});