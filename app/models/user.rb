class User < ApplicationRecord
  has_many :advertisements
  validates :name, :password, presence: true

  def admin?
    self.role == "admin"
  end
end
