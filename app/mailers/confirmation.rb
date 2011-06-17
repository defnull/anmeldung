class Confirmation < ActionMailer::Base
  include ActionController::UrlWriter
  default_url_options[:host] = '10.10.8.1'
  default :from => "inet@rbw.goe.net"

  def email user
    subject     t('email.welcome')
    recipients  user.email
    from        'inet@rbw.goe.net'
    sent_on     Time.now
    body        :firstname => user.firstname.html_safe, :lastname => user.lastname.html_safe, :pin => user.pin, :confirm_url => confirm_url(:locale=>I18n.locale,:pin => user.pin).html_safe
  end
end
