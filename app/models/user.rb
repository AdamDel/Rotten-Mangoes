class User < ActiveRecord::Base

  attr_accessor :admincode 
  before_create :valid_admincode
  has_many :reviews

  has_secure_password

  validates :email,
    presence: true

  validates :firstname,
    presence: true

  validates :lastname,
    presence: true

  validates :password,
    length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end

  def  valid_admincode
    if admincode == "admin"
      puts "admin added"
      self.admin = true
    end
  end

end
