FactoryGirl.define do
  factory :solution do
    user
    problem
    contest
    language "rb"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files','cpp', 'source.cpp'))

    [["cpp","cpp","cpp"],["java","java","java"],["ruby","rb","rb"], ["csharp", "csharp", "cs"],
     ["python","py2","py"],["python3","py3","py"] ].each do |lang|
      factory "#{lang[0]}_ok".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "source.#{lang[2]}"))
      end
      factory "#{lang[0]}_wa".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "wa.#{lang[2]}"))
      end
      unless ["ruby", "python", "python3"].include?(lang[0]) then
        factory "#{lang[0]}_ce" do
          language lang[1]
          solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "ce.#{lang[2]}"))
        end
      end
      factory "#{lang[0]}_rte".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "re.#{lang[2]}"))
      end
      factory "#{lang[0]}_tle".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "tle.#{lang[2]}"))
      end
    end

  end
end
