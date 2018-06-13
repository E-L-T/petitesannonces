require "rails_helper"

describe Comment, type: :model do
  it { should belong_to :advertisement }
  it { should belong_to :user }
  it { should validate_presence_of :content }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :advertisement_id }
end