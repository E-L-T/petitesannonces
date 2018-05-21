class User < ApplicationRecord
  has_many :advertisements
  def admin?
    self.role == "admin"
  end
end
