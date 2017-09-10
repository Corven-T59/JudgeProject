class UsersController < ApplicationController
	before_action :set_users, only: [:index]
  before_action :set_user, except: [:index, :profile]
  before_action :is_admin, except: [:index, :show, :profile]

  def index

  end

  def show  	
  end

  def profile
    if current_user
      @user = current_user
      @stadistics = ContestsUser.stadistics.where(user_id: @user.id).take
      #@last_solution = Solution.last_solution_info(@user.id)
      @total_solved = Solution.total_solved(@user.id)

      @data_for_results = {
          ok: @stadistics.try(:total_ok) || 0,
          wa: @stadistics.try(:total_wa) || 0,
          re: @stadistics.try(:total_re) || 0,
          ce: @stadistics.try(:total_ce) || 0,
          tle: @stadistics.try(:total_tle) || 0,
      }
    else
      redirect_to root_path
    end
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
