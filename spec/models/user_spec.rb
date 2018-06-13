require "rails_helper"

RSpec.describe User, :type => :model do
  it "create an user" do
    user = User.create(name: 'Eric', password: 'password')

    expect(user.name).to eq('Eric')
  end
end