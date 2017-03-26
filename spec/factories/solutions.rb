FactoryGirl.define do
  factory :solution do
    user
    problem
    contest
    language "rb"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files','cpp', 'source.cpp'))

    [["cpp","cpp"],["java","java"],["python","py2"],["python3","py3"],["ruby","rb"]].each do |lang|
      factory "#{lang[0]}_ok".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "source.#{lang[1]}"))
      end
      factory "#{lang[0]}_wa".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "wa.#{lang[1]}"))
      end
      factory "#{lang[0]}_ce" do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "ce.#{lang[1]}"))
      end
      factory "#{lang[0]}_rte".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "rte.#{lang[1]}"))
      end
      factory "#{lang[0]}_tle".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "tle.#{lang[1]}"))
      end
    end
  end
end
