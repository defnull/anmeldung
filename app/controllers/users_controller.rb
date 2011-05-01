class UsersController < ApplicationController
  
  def index
    
  end

  def condition
  	
  end
  
  def create
    respond_to do |format|
      format.html { redirect_to confirm_url }
      format.js {}
    end
  end
end
