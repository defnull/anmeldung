module UsersHelper
  def user_has_to_reboot
    if request.remote_ip.split(".")[2].to_i == 8
      note = "<h1 class='reboot_note reboot_top'>"
      note += t 'prelim.you_have_to_get_a_new_ip_adress'
      note += "</h1><h2 class='reboot_note reboot_bottom'>"
      note += t 'prelim.either_reboot_or_unplug'
      note += "</h2>"
      note.html_safe
    end
  end
end
