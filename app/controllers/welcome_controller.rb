class WelcomeController < ApplicationController
  def index
    @contests = Contest.next_contest.all.limit(3)
  end

  def landing
  end

  def search
    @serach_name = params[:search]
    @problems = Problem.search(@serach_name)
  end
end
