class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :albums, dependent: :destroy
  has_many :photos
  has_many :comments
  has_many :friends, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true
  before_create :set_role
  validates :first_name, :last_name, :user_name, :presence => true,
                        :length => { :maximum => 25 }
  
  private
  def set_role
    self.role ||= 'Employee'
  end
end
