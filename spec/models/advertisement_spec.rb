require "rails_helper"

describe Advertisement, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should validate_presence_of :price }
  it { should define_enum_for(:state) }
end