class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user
  validates :comment_name, :presence => true
end
