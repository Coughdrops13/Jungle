require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
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
      @category.products.create!(
        name:  Faker::Hipster.sentence(2),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel2.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products on home page and click 'Add to Cart' button and cart increases by 1" do
    #ACT
    visit root_path
    page.find_by_id('ADDTOCART', match: :first).click
    expect(page).to have_text('My Cart (1)')

    #DEBUG / VERIFY
    save_screenshot
  end
end
