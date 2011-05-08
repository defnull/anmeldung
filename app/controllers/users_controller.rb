class UsersController < ApplicationController
  
  def index
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '001122334455'
    if Host.exists?(:mac => mac)
      redirect_to status_url
    end
    @user = User.new
  end

  def condition
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '001122334455'
    @host = Host.find_by_mac(mac)
    Confirmation.confirmation.deliver
  end

  def confirm
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '001122334455'
    @host = Host.find_by_mac(mac)
    redirect_to index_url
  end

  def update
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '001122334455'
    @host = Host.find_by_mac(mac)
    redirect_to index_url
  end

  def resend
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '001122334455'
    @host = Host.find_by_mac(mac)
  end

  def create
    mac = (Rails.env == "production") ? `/sbin/ip neigh list dev eth2 | /bin/fgrep -w "#{request.remote_ip}" | /bin/egrep -o "[0-9a-fA-F:]{17}"` : '001122334455'
    @user = User.new(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email], :account => params[:account], :pin => rand(1000000))
    @user.assemble_adress(params[:house],params[:room_type],params[:room],params[:guest],params[:app],params[:not],params[:wohn])

    @host = Host.new(:mac => mac, :hostname => sprintf("%s_%d",(@user.adress.nil?) ? '' : @user.adress.sub(/-/,'_'), rand(10000)))
    @host.find_empty_ip_adress

    if !@user.adress.nil?
      @other_user = User.find_by_adress(@user.adress)
      if !@other_user.nil?
        @adress_conflict = true
        render :action => :index and return
      end
    end
    if @host.ip.nil?
      @ip_exhausted = true
      render :action => :index and return
    end

    if @user.valid? && @host.valid?
      @user.save
      @host.save
      @user.hosts << @host
      redirect_to confirm_url
    else
       render :action => :index
    end
  end
end
