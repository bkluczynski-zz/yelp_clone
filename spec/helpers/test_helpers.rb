def sign_up_helper(email)
  visit('/')
  click_link('Sign Up')
  fill_in('Email', with: email)
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def leave_review(thoughts, rating)
  visit '/'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  choose "review_rating_#{rating}"
  click_button 'Leave Review'
end

def create_restaurant(name)
  visit '/'
  click_link "Add a restaurant"
  fill_in "Name", with: name
  fill_in 'Description', with: 'Deep fried goodness'
  click_button "Create Restaurant"
end
