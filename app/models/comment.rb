class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement
  validates :content, :user_id, :advertisement_id, presence: true

end
