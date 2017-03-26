FactoryGirl.define do
  factory :solution do
    user
    problem
    contest
    language "rb"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files','cpp', 'source.cpp'))

    [["cpp","cpp"],["java","java"],["ruby","rb"]].each do |lang|
      factory "#{lang[0]}_ok".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "source.#{lang[1]}"))
      end
      factory "#{lang[0]}_wa".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "wa.#{lang[1]}"))
      end
      unless ["ruby", "python", "python3"].include?(lang[0]) then
        factory "#{lang[0]}_ce" do
          language lang[1]
          solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "ce.#{lang[1]}"))
        end
      end
      factory "#{lang[0]}_rte".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "re.#{lang[1]}"))
      end
      factory "#{lang[0]}_tle".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "tle.#{lang[1]}"))
      end
    end


    [["python","py2"],["python3","py3"]].each do |lang|
      factory "#{lang[0]}_ok".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "source.py"))
      end
      factory "#{lang[0]}_wa".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "wa.py"))
      end
      unless ["ruby", "python", "python3"].include?(lang[0]) then
        factory "#{lang[0]}_ce" do
          language lang[1]
          solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "ce.py"))
        end
      end
      factory "#{lang[0]}_rte".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "re.py"))
      end
      factory "#{lang[0]}_tle".to_sym do
        language lang[1]
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',lang[0], "tle.py"))
      end
    end

  end
end
