class Confirmation < ActionMailer::Base
  default :from => "inet@rbw.goe.net"

  def confirmation
    mail( :to => 'johanneshass@googlemail.com',
          :subject => 'test')
  end
end
