class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :submit, :scoreboard, :handles]
  before_action :is_admin, except: [:show, :index, :subscribe, :unsubscribe, :submit, :scoreboard, :handles]
  before_action :is_subscribed, only: [:submit]
  before_action :set_contest_state, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :submit, :scoreboard, :handles]

  
  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.order(startDate: :desc).all
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
    @problems = Problem.all
    @contest.endDate = Time.now + 1.hour
  end

  # GET /contests/1/edit
  def edit
    if @contest_state != 0
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only edit a contest that has not started yet' }
          format.json { render json: @contest_state, status: :forbidden }
      end
    end
  end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(contest_params)
    contest_duration = @contest.endDate - @contest.startDate

    if contest_duration >= 3600 && Time.now < @contest.startDate 
      respond_to do |format|
        if @contest.save
          format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
          format.json { render :show, status: :created, location: @contest }
        else
          format.html { render :new }
          format.json { render json: @contest.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_contest_path, notice: 'The contest must last at least 1 hour and the start date must not be in the past'}
        format.json { render json: @contest.errors, status: :forbidden }
      end
    end
    
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    new_contest = Contest.new(contest_params)
    contest_duration = new_contest.endDate - new_contest.startDate
   
    if contest_duration >= 3600 && Time.now < @contest.startDate 
      if @contest_state != 0
        respond_to do |format|
            format.html { redirect_to @contest, alert: 'You can only update a contest that has not started yet' }
            format.json { render json: @contest_state, status: :forbidden }
        end
      else
        respond_to do |format|
          if @contest.update(contest_params)
            format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
            format.json { render :show, status: :ok, location: @contest }
          else
            format.html { render :edit }
            format.json { render json: @contest.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_contest_path, notice: 'The contest must last at least 1 hour and the start date must not be in the past'}
        format.json { render json: @contest.errors, status: :forbidden }
      end
    end

  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    if @contest_state != 0
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only destroy a contest that has not started yet' }
          format.json { render json: @contest_state, status: :forbidden }
      end
    else
      @contest.destroy
      respond_to do |format|
        format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    
  end

  def scoreboard
    @user_scores = @contest.scoreboard
    @problems = @contest.problems
    @color_cache = []
    @problems.each { |p| @color_cache << [p.id, p.color] }
  end
  def submit
    if @contest_state != 1
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only submit a solution while the contest is running' }
          format.json { render json: @contest_state, status: :forbidden }
      end
    else
      @solution = Solution.new()
      @problems = @contest.problems
    end
  end

  def subscribe
    if @contest_state == 2
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only subscribe to a contest before or once it already started' }
          format.json { render json: @contest_state, status: :forbidden }
      end
    elsif @contest.users.exists? current_user
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'Already subscribed to contest' }
          format.json { render json: @contest.errors, status: :forbidden }
      end

    else
      @contest.users << current_user

      respond_to do |format|
        format.html { redirect_to @contest, notice: 'Subscribed to contest successfully.' }
        format.json { render json: @contest, status: :ok, location: @contest }
      end
    end

  end

  def unsubscribe
     if @contest_state != 0
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'You can only unsubscribe from a contest before it already started' }
          format.json { render json: @contest_state, status: :forbidden }
      end
    elsif @contest.users.exists? current_user
      @contest.users.delete(current_user)
      respond_to do |format|
        format.html { redirect_to @contest, notice: 'Unsubscribed to contest successfully.' }
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
      if !@contest.users.exists? current_user
        redirect_to contest_path, id: @contest_id, :alert => "You are not subscribed to this contest"
      end
    end

    def set_contest_state
      current_time = Time.now
      if current_time < @contest.startDate
        @contest_state = 0
      elsif current_time >= @contest.startDate && current_time <= @contest.endDate
        @contest_state = 1
      else
        @contest_state = 2
      end       
    end
    
end
