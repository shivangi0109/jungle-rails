describe('Home', () => {
  it('should visit the home page', () => {
    // Visit the home page
    cy.visit('http://localhost:3000');
    cy.get('p').should('contain', 'Looking for a way to add some life to your home?');
  });

  // it("There is products on the page", () => {
  //   cy.get(".products article").should("be.visible");
  // });

  it("There is 2 products on the page", () => {

    // Wait for 5 seconds (adjust the time as needed)
    cy.wait(5000);

    // Log the number of articles found
    cy.get(".products article").then(($articles) => {
      console.log("Number of articles found:", $articles.length);
    });

    // Assertion
    cy.get(".products article").should("have.length", 2);
  });
});
