class HostsController < ApplicationController
  def add
    mac = get_remote_mac
    host = Host.find_by_mac(mac)
    user = host.user
    new_host = Host.new(:mac => params[:mac], :hostname => sprintf("%s_%d",user.adress.sub(/-/,'_'), rand(1000000)))
    new_host.find_empty_ip_adress
    if new_host.ip.nil?
      flash[:error] = t 'conflict.ip_adresses_exhausted'
    elsif !new_host.valid?
      flash[:error] = t 'host.adding_new_computer_not_possible_at_this_time'
    else
      flash[:notice] = t 'host.new_computer_added'
      flag = Flag.find_by_species('valid')
      new_host.save
      new_host.hostflag.flag=(flag)
      new_host.hostflag.save
      user.hosts << new_host
    end
    redirect_to status_url
  end
end
