class WelcomeController < ApplicationController
  def index
  end

  def landing
  end

  def search
    @serach_name = params[:search]
    @problems = Problem.search(@serach_name)
  end
end
