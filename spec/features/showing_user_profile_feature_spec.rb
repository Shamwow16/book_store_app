require 'rails_helper'

RSpec.feature 'Showing user profile' do
  scenario 'when signed in as a user' do
    user = Fabricate.create(:user)
    visit user_path(1)
    expect(page).to have_content('Profile')
  end
end
