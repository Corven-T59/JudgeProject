class SolutionsController < ApplicationController
  respond_to :html, :js, :json
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  before_action :set_contest
  before_action :authenticate_user!, only: [:create, :new]
  # GET /solutions
  # GET /solutions.json
  def index
    @solutions = @contest.solutions.includes(:problem, :user).all
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
  end

  # GET /solutions/new
  def new
    @solution = Solution.new
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(solution_params)
    @solution.contest = @contest
    @solution.user = current_user
    respond_to do |format|
      if @solution.save
        format.js { render "solutions/create" }
        format.html { redirect_to [@contest, @solution], notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.js {render json: @solution, status: 422}
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update
    respond_to do |format|
      if @solution.update(solution_params)
        format.html { redirect_to @solution, notice: 'Solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to solutions_url, notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    def set_contest
      @contest = Contest.find(params[:contest_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:problem_id, :contest_id, :solutionFile, :language)
    end
end
