require 'rails_helper'

RSpec.feature 'Signing users out' do
  let!(:user) { Fabricate(:user, email: 'john@example.com') }
  scenario 'successfully ends the session' do
    visit root_path

    click_link 'Sign in'

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    click_link 'Sign out'

    expect(page).to have_content('You have been signed out')
  end
end
