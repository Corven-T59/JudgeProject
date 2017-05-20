class UsersController < ApplicationController
	before_action :set_users, only: [:index]
	before_action :set_user, except: [:index]
  before_action :is_admin, except: [:index, :show]

  def index

  end

  def show  	
  end

  def edit
  	
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users
      #@users = User.all.where.not(id: current_user.id)
      @users = User.order(:email).page params[:page]
    end
    def set_user
    	@user = User.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:admin)
    end

end
