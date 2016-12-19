require 'rails_helper'
require 'support/macros'
RSpec.feature 'Seeding Data' do
  let(:admin) { Fabricate(:admin) }

  before { sign_in_as(admin) }
  scenario 'with seed data in seed.rb' do
    load Rails.root + 'db/seeds.rb'
    visit root_path
    click_link 'Authors'

    expect(page).to have_content('Sydney')
  end
end
