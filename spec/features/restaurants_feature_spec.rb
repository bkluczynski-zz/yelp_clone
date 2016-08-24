require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC', description: "Chicken")
    end
    scenario 'displays restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){ Restaurant.create(name: 'KFC', description: 'Deep fried goodness') }
    scenario "lets a user view a restaurant" do
      visit '/'
      click_link 'KFC'
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'a non-signed in user can not' do
    scenario 'create a restaurant' do
      visit '/'
      click_link "Add a restaurant"
      expect(page).to have_content 'You need to sign in or sign up before continuing'
      expect(current_path).to eq "/users/sign_in"
    end

    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

    scenario 'edit a restaurant' do
      visit '/'
      click_link 'Edit KFC'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
      expect(current_path).to eq "/users/sign_in"
    end

    scenario 'delete a restaurant' do
      visit '/'
      click_link 'Delete KFC'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
      expect(current_path).to eq "/users/sign_in"
    end

  end

  context 'a signed in user can' do
    before do
      visit('/')
      click_link('Sign Up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    scenario 'create a new restaurant' do
      visit '/'
      click_link "Add a restaurant"
      fill_in "Name", with: "KFC"
      fill_in 'Description', with: 'Deep fried goodness'
      click_button "Create Restaurant"
      expect(page).to have_content "KFC"
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant raises an error' do
      it "does not let you submit a name that is too short" do
        visit '/'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

    context 'editing restaurants' do
      before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

      scenario 'lets a user edit a restaurant' do
        visit '/'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(page).to have_content 'Deep fried goodness'
        expect(current_path).to eq '/restaurants'
      end
    end

    context 'deleting restaurants' do
      before { Restaurant.create name: 'KFC', description: 'Deep fried goodness'}

      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted succesfully'
      end
    end
  end

end
