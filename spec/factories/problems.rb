FactoryGirl.define do
  factory :problem do
    name "Test problem"
    baseName "source"
    timeLimit 2
    descriptionFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec','support', 'files', 'desc.txt')) }
    inputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec','support', 'files', 'input.in')) }
    outputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'output.out')) }
  end
end
