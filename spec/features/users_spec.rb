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

    expect(page).to have_content 'User was successfully created'
  end
  
  context "not logged" do
    scenario "only see welcome anonymous" do
      visit users_path

      expect(page).to have_content "Welcome anonymous visitor !"
      expect(page).not_to have_content "Estelle"
    end
  end

  context "as a logged user" do
    before { log_in_user user }

    scenario "login" do
      expect(page).to have_content "Welcome #{user.name} !!!!"
    end

    scenario "logs out when you click on the link" do
      visit advertisements_path
      click_on 'Logout'
      save_and_open_page

      expect(page).to have_content('You are now unlogged')
      expect(page).to have_content('Welcome anonymous visitor !')
    end
  end

  context "as an admin" do
    before { log_in_user admin }
    
    scenario "login" do
      expect(page).to have_content "Welcome #{admin.name} !!!!"
    end

    scenario "can edit another user" do
      find(:xpath, "//a[@href='/users/2/edit']").click

      expect(page).to have_content "Editing User"
      fill_in "user_name", with: 'Angelina'
      click_on 'Update User'
      expect(page).to have_content "Angelina"
    end

    scenario "can destroy another user" do
      find(:xpath, "/html/body/table/tbody/tr[1]/td[4]/a").click

      expect(page).to have_content "User was successfully destroyed."
    end

  end
end
