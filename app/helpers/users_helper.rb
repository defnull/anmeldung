module UsersHelper
  def user_has_to_reboot
    if request.remote_ip.split(".")[2].to_i == 8
      note = "<div class='ui-state-error ui-corner-all'>"
      note += "<h1>"
      note += t 'prelim.you_have_to_get_a_new_ip_adress'
      note += "</h1><h2>"
      note += t 'prelim.either_reboot_or_unplug'
      note += "</h2><h2>"
      note += t 'prelim.updates_all_ten_minutes'
      note += "</h2></div>"
      note.html_safe
    end
  end
end
