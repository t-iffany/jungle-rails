describe('Product details', () => {

  it("Visits home page", () => {
    cy.visit('/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Increases cart count by 1 after clicking Add to Cart button for a product", () => {
    // click Add to Cart button
    cy.get("button").contains("Add").click({ force: true });
    // check for My Cart (1) to be visible in the nav bar
    cy.get(".nav-link").contains("My Cart (1)").should("be.visible")
  });

});