class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :submit, :scoreboard]
  before_action :is_admin, except: [:show, :index, :subscribe, :unsubscribe, :submit, :scoreboard]
  before_action :is_subscribed, only: [:submit]
  
  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.all
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
    @problems = Problem.all
  end

  # GET /contests/1/edit
  def edit
    
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
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
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
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def scoreboard
    @problems = @contest.problems
    @users =  @contest.users.pluck(:id,:email)
    @solutions = @contest.solutions.order(user_id: :asc, problem_id: :asc).pluck(:user_id,:problem_id, :status, :created_at)

    @scores = Hash.new
    
    submition_count = 0
    accepted_count = 0
    problems_sent = Hash.new
    problems_accepted = Hash.new
    total_temp = 300
    time_temp = 20

    #TODO order by users and then by problem
    #this way you dont have to deal with existing data
    solutions_size = @solutions.size
    for i in 0..solutions_size - 1
      solution = @solutions[i]

      submition_count = submition_count + 1
      if solution[2] == 4 #status
        accepted_count = accepted_count + 1
      end

      if i + 1 == solutions_size || @solutions[i + 1][1] != solution[1] || @solutions[i + 1][0] != solution[0] #problem_id || user_id
        problems_sent[solution[1]] = submition_count        
        problems_accepted[solution[1]] = [accepted_count, time_temp]
        accepted_count = 0
        submition_count = 0
      end

      if i + 1 == solutions_size || @solutions[i + 1][0] != solution[0] #user_id
        @scores[solution[0]] = [problems_sent, problems_accepted, total_temp]
        problems_sent = Hash.new
        problems_accepted = Hash.new
      end

    end 

  end
  def submit
    @solution = Solution.new()
    @problems = @contest.problems
  end

  def subscribe
    if @contest.users.exists? current_user
      respond_to do |format|
          format.html { redirect_to @contest, alert: 'Already subscribed to contest' }
          format.json { render json: @contest.errors, status: :unprocessable_entity }
      end

    else
      @contest.users << current_user

      respond_to do |format|
        format.html { redirect_to @contest, notice: 'Subscribed to contest successfully.' }
        format.json { render :show, status: :ok, location: @contest }
      end
    end

  end

  def unsubscribe
    if @contest.users.exists? current_user
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.includes(:solutions).find(params[:id])
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
end
