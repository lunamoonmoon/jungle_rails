
describe('product details', () => {

  it('clicks a product on the home page', () => {
    cy.visit('/');
    cy.get('div.products img').first().should('be.visible').click();
  })

})
