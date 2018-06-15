# frozen_string_literal: true

require 'rails_helper'

describe "Users", type: :feature do
  let!(:user) { create :user }
  let!(:user2) { create :user, name: 'Jean-René' }
  let!(:admin) { create :user, :administrateur, name: 'Admin' }

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
  
  context "as a lambda user" do
    scenario "login" do
      log_in_user user

      expect(page).to have_content "Welcome #{user.name} !!!!"
    end
    
    scenario "cannot edit another user" do
      log_in_user user
      find(:xpath, "//a[@href='/users/2/edit']").click

      expect(page).to have_content "Forbidden access"
    end

  end

  context "as an admin" do
    scenario "login" do
      log_in_user admin

      expect(page).to have_content "Welcome #{admin.name} !!!!"
    end

    scenario "can access to the show of another user" do
      log_in_user admin
      puts admin.inspect

      find(:xpath, "//a[@href='/users/2/edit']").click
      expect(page).to have_content "Editing User"
    end

  end
end
