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

  it("Navigates to a product detail page when clicking on a product partial", () => {
    // added multiple: true because there are more than one article element on the page that can be clicked
    cy.get("article").click({ multiple: true });  // applies the click to each element
    cy.get(".product-detail").should("be.visible");
  });

});