class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale

  def get_remote_mac
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '00:11:22:33:44:54'
    mac.gsub(':','').strip
  end

  private
  
    def set_locale
      locales = ["de","en"]
  	  I18n.locale = (locales.include?(params[:locale])) ? params[:locale] : "en"
    end
  
    def default_url_options(options={})
      { :locale => I18n.locale }
    end
end
