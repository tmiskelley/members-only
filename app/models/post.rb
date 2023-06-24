class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
  validates :body, length: { minimum: 10 }
end
