class Host < ActiveRecord::Base
  validates_presence_of :ip, :ip_numeric, :mac, :hostname
  validates_format_of :ip, :with => /\A10\.10\.(?:[89]|1[0-5])\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])\Z/i
  #validates_format_of :mac, :with => /\A((?:[a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2})\Z/i
  validates_format_of :mac, :with => /\A((?:[a-fA-F0-9]{2}){6})\Z/i
  validates_format_of :hostname, :with => /(^[a-z0-9_]+$)/i
  validates_uniqueness_of :ip, :ip_numeric, :mac, :hostname
  validates_numericality_of :ip_numeric

  belongs_to :user
  has_one :hostflag, :dependent => :destroy

  after_create :create_hostflag_for_new_host

  def find_empty_ip_adress
    #First, find out if the 10.10.9.0 adress is in use. If it isn't, use that. If it is, use the SQL-script to find
    #a free IP adress.
    #If none is available , the ip-Value will be left nil which prompts a corresponding message to the user, namely
    #that the adress pool is exhausted and they'll have to talk to a administrator
    #10.10.9.0 is addressed as 168429824 in ip_numeric (9*256+10*256^2+10*256^3)

    if !Host.exists?(:ip_numeric => 168429824)
      self.ip_numeric = 168429824
    else
      sql = "SELECT l.ip_numeric+1 AS start FROM hosts AS l LEFT OUTER JOIN hosts AS r ON l.ip_numeric+1 = r.ip_numeric WHERE r.ip_numeric IS NULL AND l.ip_numeric >= 168429824 AND l.ip_numeric < 168431615 LIMIT 1;"
      self.ip_numeric = Host.connection.select_value(sql)
    end
    temp_num = ip_numeric - (256*256*256*10) - (256*256*10)
    self.ip = (self.ip_numeric.nil?) ? nil : sprintf("10.10.%d.%d",self.temp_num.divmod(256)[0],self.temp_num.divmod(256)[1])
  end

  private
  #noinspection RubyArgCount
  def create_hostflag_for_new_host
    flag = Flag.find_by_species("limited")
    self.create_hostflag(:description => 'Neuer Host', :flag_id => flag.id, :message => nil)
  end
end
