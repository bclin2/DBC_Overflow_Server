class Question < ActiveRecord::Base
  has_many :answers
  validates :title, :content, presence: true
end
