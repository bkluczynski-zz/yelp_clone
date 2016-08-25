require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }
  before do
    visit('/')
    click_link('Sign Up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'allows users to leave a review using the form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'mediocre'
    choose 'review_rating_3'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'mediocre'
  end
end
