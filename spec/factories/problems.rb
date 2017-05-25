FactoryGirl.define do
  factory :problem do
    name "Test problem"
    baseName "source"
    timeLimit 2
    descriptionFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec','support', 'files', 'desc.txt')) }
    inputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'basic', 'input.in')) }
    outputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'basic', 'output.out')) }

    factory :problem_interval do
      inputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'interval_product', 'input.in')) }
      outputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'interval_product', 'output.out')) }
    end

    factory :problem_interval_custom do
      inputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'interval_product_custom', 'input.in')) }
      outputFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'interval_product_custom', 'output.out')) }
    end
  end
end
