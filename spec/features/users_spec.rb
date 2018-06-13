# frozen_string_literal: true

require 'rails_helper'

describe "Users", type: :feature do
  let!(:user) { create :user }

  scenario "create an user" do
    visit new_user_path
    fill_in :user_name, with: 'Roger'
    fill_in :user_password, with: 'password'
    click_on 'Create User'

    expect(page).to have_content 'Roger'
  end

  scenario "display users index" do
    visit users_path

    expect(page).to have_content 'Estelle'
  end
  
  scenario "login" do
    log_in_user user
    
    expect(page).to have_content "Welcome #{user.name} !!!!"
  end
end
