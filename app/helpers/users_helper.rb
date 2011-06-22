module UsersHelper
  def user_has_to_reboot
    if request.remote_ip.split(".")[2].to_i == 8 || Rails.env == "development"
      render :partial => 'has_to_reboot'
    end
  end
end
