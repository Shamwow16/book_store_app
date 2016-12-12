require 'rails_helper'

RSpec.feature 'Seeding Data' do
  scenario 'with seed data in seed.rb' do
    load Rails.root + 'db/seeds.rb'
    require 'pry'; visit root_path
    click_link 'Authors'

    expect(page).to have_content('Sydneey')
  end
end
