class UsersController < ApplicationController
  
  def index
    @host = (Rails.env == "production") ? "10.10.8.1" : "127.0.0.1"
    mac = get_remote_mac
    if Host.exists?(:mac => mac)
      redirect_to status_url
    end
    @user = User.new
  end

  def condition
    mac = get_remote_mac
    @host = Host.find_by_mac(mac)
    @user = @host.user
    redirect_to index_url if @host.nil?
  end

  def confirm
    mac = get_remote_mac
    @host = Host.find_by_mac(mac)
    redirect_to index_url if @host.nil?
    pin = (params[:pin] == 'form') ? params[:pin_form].to_i : params[:pin].to_i
    if pin == @host.user.pin
      flash[:notice] = t('confirm.correct_pin')
      flag = Flag.find_by_species('valid')
      user = @host.user
      user.hosts.each do |host|
        if host.hostflag.flag.species = 'limited'
          host.hostflag.flag=(flag)
          host.hostflag.save
        end
      end
    else
      flash[:error] = t('confirm.wrong_pin')
    end
    redirect_to status_url
  end

  def update
    mac = get_remote_mac
    @host = Host.find_by_mac(mac)
    redirect_to index_url if @host.nil?

    user = @host.user
    old_email = user.email
    user.update_attributes({:firstname => params[:firstname], :lastname => params[:lastname], :account => params[:account], :email => params[:email]})
    if old_email != params[:email]
      Confirmation.email(user).deliver
      flash.notice = t('email.resent')
    end

    redirect_to status_url
  end

  def resend
    mac = get_remote_mac
    @host = Host.find_by_mac(mac)
    redirect_to index_url if @host.nil?
    Confirmation.email(@host.user).deliver
    flash.notice = t('email.resent')
    redirect_to status_url
  end

  def create
    mac = get_remote_mac
    @user = User.new(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email], :account => params[:account], :pin => rand(1000000))
    @user.assemble_adress(params[:house],params[:room],params[:special_room])

    @host = Host.new(:mac => mac, :hostname => sprintf("%sx%d",(@user.adress.nil?) ? '' : @user.adress.sub(/-/,'x'), rand(1000000)))
    @host.find_empty_ip_adress

    if @host.ip.nil?
      @ip_exhausted = true
      render :action => :index and return
    end

    if @user.adress
      @other_user = User.find_by_adress(@user.adress)
      if @other_user
        if params[:adress_conflict] == 'new_resident'
          if @user.valid? && @host.valid?
            @user.save
            @host.save
            @user.hosts << @host
            Confirmation.email(@user).deliver
            redirect_to status_url and return
          else
            render :action => :index and return
          end
        elsif params[:adress_conflict] == 'add_computer' || params[:adress_conflict] == 'new_computer'
          current_status = @other_user.hosts.first.hostflag.flag.id
          @host.save
          hostflag = @host.hostflag
          hostflag.flag_id = current_status
          hostflag.save
          @other_user.hosts << @host
          redirect_to status_url and return
        else
          @adress_conflict = true
          @user.valid?
          render :action => :index and return
        end
      elsif @user.valid? && @host.valid?
        @user.save
        @host.save
        @user.hosts << @host
        Confirmation.email(@user).deliver
        redirect_to status_url and return
      end
    end
    @user.errors.add(:adress, "is invalid!")
    render :action => :index
  end
end
