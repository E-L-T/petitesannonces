require "rails_helper"

describe User, type: :model do
  it { should have_many :advertisements }
  it { should validate_presence_of :name }
  it { should validate_presence_of :password }
end