# frozen_string_literal: true

require 'rails_helper'

describe "Advertisements", type: :feature do
  let!(:user) { create :user }
  let!(:admin) { create :user, :administrateur, name: 'Admin' }
  let!(:published_advertisement) { create :advertisement }
  let!(:waiting_advertisement) { create :advertisement, title: 'Old bike', state: 'waiting' }
  
  context "not logged" do
    scenario "cannot post an advertisement" do
      visit new_advertisement_path
      fill_in "advertisement_title", with: 'Canon 5D'
      fill_in "advertisement_content", with: 'Great camera'
      fill_in "advertisement_price", with: '800 euros'
      click_on 'Create Advertisement'

      expect(page).to have_content "User must exist"
    end

    scenario "can see only published advertisements" do
      visit advertisements_path
      expect(page).to have_content "Comics collection"
      expect(page).not_to have_content "Old bike"
    end
  end

  context "as a logged user" do
    scenario "can post a new advertisement" do
      log_in_user user
      visit new_advertisement_path
      expect do
      fill_in "advertisement_title", with: 'Canon 5D'
      fill_in "advertisement_content", with: 'Great camera'
      fill_in "advertisement_price", with: '800 euros'
      click_on 'Create Advertisement'
    end.to change { Advertisement.count }.by(1)
  end
end

context "as an admin" do
  before { log_in_user admin }
  
  scenario "can see all advertisements" do
    visit advertisements_path
    expect(page).to have_content "Comics collection"
    expect(page).to have_content "Old bike"
    end

    scenario "can publish an advertisement" do
      visit advertisement_path waiting_advertisement
      click_on 'Publish'
      expect(page).to have_content "Advertisement was successfully published."
      log_in_user user
      visit advertisements_path
      expect(page).to have_content "Old bike"
    end
  end
end
