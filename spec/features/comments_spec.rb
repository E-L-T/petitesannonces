# frozen_string_literal: true

require 'rails_helper'

describe "Comments", type: :feature do
  let!(:user) { create :user }
  let!(:admin) { create :user, :administrateur, name: 'Admin' }
  let!(:advertisement) { create :advertisement }
  
  context "not logged" do
    scenario "cannot comment an advertisement" do
      visit advertisement_path advertisement

      expect(page).not_to have_content('Create Comment')
    end
  end

  context "as a logged user" do
    scenario "can comment an advertisement" do
      log_in_user user
      visit advertisement_path advertisement

      expect do
        fill_in "comment_content", with: 'Great stuff !'
        click_on 'Create Comment'
      end.to change { Comment.count }.by(1)
      expect(page).to have_content('Great stuff !')
      expect(page).to have_content(user.name)
    end
  end
end
