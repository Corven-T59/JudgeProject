require 'rails_helper'

RSpec.describe "Solutions", type: :request do

  let(:valid_for_create){
    {
        language: :rb,
        solutionFile: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec','support', 'files','ruby', 'source.rb'))
    }
  }

  describe "GET /contest/1/solutions" do
    it "works! (now write some real specs)" do
      contest= FactoryGirl.create(:contest)
      get solutions_path, params: {contest_id: contest.id}
      expect(response).to have_http_status(200)
    end
  end

end
