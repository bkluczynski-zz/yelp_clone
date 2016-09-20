require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }
  before do
    sign_up_helper('test@example.com')
  end

  scenario 'displays an average rating on all reviews' do
    leave_review('So so', '3')
    click_link 'Sign Out'
    sign_up_helper('test@example2.com')
    leave_review('Great', '5')
    expect(page).to have_content "Average rating: ★★★★☆"
  end

  scenario 'allows users to leave a review using the form' do
    leave_review('mediocre', '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'mediocre'
  end
end
