class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :album
	has_many :comments, dependent: :destroy
	has_attached_file :image, default_url: "/images/:style/missing.png"
	validates_attachment :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
