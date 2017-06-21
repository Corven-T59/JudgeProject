class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :submit, :scoreboard, :handles, :problems]
  before_action :is_admin, except: [:show, :index, :subscribe, :unsubscribe, :submit, :scoreboard, :handles, :problems]
  before_action :is_subscribed, only: [:submit]

  
  # GET /contests
  # GET /contests.json
  def index
    @new_contest = Contest.new
    @contests = Contest.order(startDate: :desc).page(params[:page])
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
    @problems = Problem.valid_problems
    @contest.endDate = Time.now + 1.hour
  end

  # GET /contests/1/edit
  def edit
    if @contest.status != 0
      respond_to do |format|
        format.html { redirect_to @contest, alert: 'Solo se pueden editar competencias que aún no hayan iniciado.' }
          format.json { render json: @contest_state, status: :forbidden }
      end
    end
  end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(contest_params)
    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to @contest, notice: 'Competencia actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    if @contest.status != 0
      respond_to do |format|
        format.html { redirect_to @contest, alert: 'Solo puede eliminar competencias que no hayan empezado.' }
        format.json { render json: @contest.status, status: :forbidden }
      end
    else
      @contest.destroy
      respond_to do |format|
        format.html { redirect_to contests_url, notice: 'La competencia ha sido eliminada satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    
  end

  def problems
    @problems = @contest.problems.page params[:page]
    render "problems/index"
  end

  def scoreboard
    @user_scores = @contest.scoreboard
    @problems = @contest.problems
    @color_cache = []
    @problems.each { |p| @color_cache << [p.id, p.color] }
  end
  def submit
    if @contest.status != 1
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only submit a solution while the contest is running' }
          format.json { render json: @contest.status, status: :forbidden }
      end
    else
      @solution = Solution.new()
      @problems = @contest.problems
    end
  end

  def subscribe
    if @contest.status == 2
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only subscribe to a contest before or once it already started' }
          format.json { render json: @contest.status, status: :forbidden }
      end
    elsif @contest.users.exists? current_user.try(:id)
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'Already subscribed to contest' }
          format.json { render json: @contest.errors, status: :forbidden }
      end

    else
      @contest.users << current_user

      respond_to do |format|
        format.html { redirect_to @contest, notice: 'Se ha subscrito correctamente.' }
        format.json { render json: @contest, status: :ok, location: @contest }
      end
    end

  end

  def unsubscribe
    if @contest.status != 0
      respond_to do |format|
        format.html { redirect_to @contest, alert: 'Solo puede cancelar la subscripción antes de que la competencia empiece' }
          format.json { render json: @contest.status, status: :forbidden }
      end
    elsif @contest.users.exists? current_user.try(:id)
      @contest.users.delete(current_user)
      respond_to do |format|
        format.html { redirect_to @contest, notice: 'Ha cancelado la subscripción a la competencia.' }
        format.json { render :show, status: :ok, location: @contest }
      end
    else
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You are not subscribed to this contest' }
          format.json { render json: @contest.errors, status: :unprocessable_entity }
      end

    end
  end

  def handles
    user_handles = @contest.users.pluck(:id, :email)
    respond_to do |format|
      format.json {render json: user_handles, status: :ok}
    end
  end
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:title, :description, :difficulty, :startDate, :endDate, problem_ids:[])
    end

    def is_subscribed
      if !@contest.users.exists? current_user.try(:id)
        redirect_to contest_path, id: @contest_id, :alert => "You are not subscribed to this contest"
      end
    end
    
end
