require 'rails_helper'

RSpec.describe "Solutions", type: :request do

  let(:valid_for_create){
    {
        language: :rb,
        solutionFile: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec','support', 'files','ruby', 'source.rb'))
    }
  }

  xdescribe "GET /solutions" do
    it "works! (now write some real specs)" do
      get solutions_path
      expect(response).to have_http_status(200)
    end
  end

end
