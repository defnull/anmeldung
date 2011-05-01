class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :adress, :email
  has_many :hosts, :dependent => :destroy
end
