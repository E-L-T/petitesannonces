class Advertisement < ApplicationRecord
  belongs_to :user
  enum state: { waiting: 0, published: 1 }
  validates :title, :content, :price, presence: true
end
