require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
  
  # Setup
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They see all products on homepage and click details button on one product to see product details' do
    
    #ACT
    visit root_path
    page.find('footer.actions', match: :first).click_link('Details »')
    expect(page).to have_text('Description')
    #DEBUG / VERIFY
    save_screenshot

  end
end
