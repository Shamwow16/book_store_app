require 'rails_helper'
require 'support/macros'

RSpec.feature 'Signing users out' do
  let!(:user) { Fabricate(:user) }

  before { sign_in_as user }

  scenario 'successfully ends the session' do
    visit root_path
    click_link 'Sign out'

    expect(page).to have_content('You have been signed out')
    expect(page).not_to have_content('Sign out')
  end
end
