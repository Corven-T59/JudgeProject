class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :submit, :scoreboard, :handles]
  before_action :is_admin, except: [:show, :index, :subscribe, :unsubscribe, :submit, :scoreboard, :handles]
  before_action :is_subscribed, only: [:submit]
  before_action :set_contest_state, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :submit, :scoreboard, :handles]

  
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
    @problems = @contest.problems.order(id: :asc)
    @users =  @contest.users.pluck(:id,:email)
    @solutions = @contest.solutions.order(user_id: :asc, problem_id: :asc, created_at: :asc).pluck(:user_id,:problem_id, :status, :created_at)

    
    #base score row
    problems_sent_base = Hash.new
    problems_accepted_base = Hash.new
    #fill with columns hash submitions, hash OK, total ok, total time
    @problems.each do |problem|
      problems_sent_base[problem.id] = 0
      problems_accepted_base[problem.id] = [0,0]
    end

    @scores = Hash.new

    #each user has its own score row
    @users.each do |user|
      @scores[user[0]] = [problems_sent_base.clone, problems_accepted_base.clone, 0, 0]
    end

    submition_count = 0
    accepted_count = 0
    total_accepted_count = 0
    problems_sent = problems_sent_base.clone
    problems_accepted = problems_accepted_base.clone

    total_time_submit = 0
    time_submition = -1

    solutions_size = @solutions.size
    #for each solution sent within this contest
    for i in 0..solutions_size - 1
      solution = @solutions[i]

      #update counters
      submition_count = submition_count + 1
      if solution[2] == 4 #status == ok ?
        accepted_count = accepted_count + 1    
        #has the user an ok before on this submition ?    
        if time_submition < 0
          time_submition = solution[3] - @contest.startDate #created_at
          total_time_submit = total_time_submit + time_submition
          total_accepted_count = total_accepted_count + 1
        end

      end
      #if the next solution is out of bounds or the next solution is for another problem or belongs to another user
      if i + 1 == solutions_size || @solutions[i + 1][1] != solution[1] || @solutions[i + 1][0] != solution[0] #problem_id || user_id
        problems_sent[solution[1]] = submition_count        
        if time_submition < 0
          time_submition = 0
        end
        problems_accepted[solution[1]] = [accepted_count, time_submition]
        accepted_count = 0
        submition_count = 0
        time_submition = -1
      end
      #if the next solution is out of bounds or the next solution is for another user
      if i + 1 == solutions_size || @solutions[i + 1][0] != solution[0] #user_id
        if @scores.key?(solution[0])
          @scores[solution[0]] = [problems_sent, problems_accepted, total_accepted_count, total_time_submit]
        end
        problems_sent = problems_sent_base.clone
        problems_accepted = problems_accepted_base.clone
        total_time_submit = 0
        total_accepted_count = 0
      end

    end 
    #sort the scores by the most OK and less time
    @scores = @scores.sort_by{|k,v| [v[2] * -1,v[3]]} #v[2] OK count, V[3] time score

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
