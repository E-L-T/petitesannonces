# frozen_string_literal: true

require 'rails_helper'

describe "Users", type: :feature do

  scenario "create an user", js: true do
    visit new_user_path
    fill_in :user_name, with: 'Roger'
    fill_in :user_password, with: 'password'
    click_on 'Create User'

    expect(page).to have_content 'Roger'
  end
end
