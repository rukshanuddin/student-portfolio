class User < ActiveRecord::Base
  has_many  :projects
  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

end
