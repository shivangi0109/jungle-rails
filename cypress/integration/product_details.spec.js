describe('Product Details', () => {
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

  it('should navigate to product detail page by clicking on a product', () => {
    // Click on the first product (adjust the selector based on your product structure)
    cy.get('.products article:first-child').click();

    // Ensure that the URL changes to the product detail page
    cy.url().should('include', '/products/');

    // Assert that you are on the product detail page
    cy.get('.product-detail').should('be.visible');

    // Additional assertions or actions on the product detail page can be added here
  });
});