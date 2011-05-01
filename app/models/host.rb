class Host < ActiveRecord::Base
  validates_presence_of :ip, :ip_numeric, :mac, :hostname
  validates_format_of :ip, :with => /\A10\.10\.(?:[89]|1[0-5])\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])\Z/i
  validates_format_of :mac, :with => /\A((?:[a-f0-9]{2}){6})\Z/i
  validates_format_of :hostname, :with => /(^[a-z0-9_]+$)/i

  belongs_to :user
  has_one :hostflag, :dependent => :destroy
end
