class Answer < ActiveRecord::Base
  belongs_to :question
  validates :title, :content, presence: true
end
