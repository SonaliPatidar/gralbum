class User < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :photos
  has_many :comments
  accepts_nested_attributes_for :photos, allow_destroy: true
  before_create :set_role
  validates_confirmation_of :password, :if => :is_password_change?
  attr_accessor :password_confirmation
  validates :first_name, :last_name, :user_name, :presence => true,
                        :length => { :maximum => 25 }                        
  validates :email, :presence => true,
                   :uniqueness => { message: "This email already in use" }, 
                   :length => { :maximum => 100 },
                   :format => {with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :password, :presence => true,
                      :length => { :within => 6..20 } 

  before_save :encrypt_sensitive                                   

  def is_password_change?
    return password_changed?
  end
  
  private
  def set_role
    self.role ||= 'Employee'
  end
end
