FactoryGirl.define do
  factory :solution do
    user
    problem
    contest
    language "rb"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files','cpp', 'source.cpp'))
    factory :cpp_ok do
      language "cpp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"cpp", "source.cpp"))
    end
    factory :cpp_wa do
      language "cpp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"cpp", "wa.cpp"))
    end
    factory :cpp_ce do
      language "cpp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"cpp", "ce.cpp"))
    end
    factory :cpp_rte do
      language "cpp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"cpp", "re.cpp"))
    end
    factory :cpp_tle do
      language "cpp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"cpp", "tl.cpp"))
    end
    factory :java_ok do
      language "java"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"java", "source.java"))
    end
    factory :java_wa do
      language "java"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"java", "wa.java"))
    end
    factory :java_ce do
      language "java"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"java", "ce.java"))
    end
    factory :java_rte do
      language "java"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"java", "re.java"))
    end
    factory :java_tle do
      language "java"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"java", "tl.java"))
    end
    factory :ruby_ok do
      language "rb"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"ruby", "source.rb"))
    end
    factory :ruby_wa do
      language "rb"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"ruby", "wa.rb"))
    end
    factory :ruby_rte do
      language "rb"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"ruby", "re.rb"))
    end
    factory :ruby_tle do
      language "rb"
      solutionFile { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files',"ruby", "tl.rb"), 'text/plain') }
    end
    factory :csharp_ok do
      language "csharp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"csharp", "source.cs"))
    end
    factory :csharp_wa do
      language "csharp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"csharp", "wa.cs"))
    end
    factory :csharp_ce do
      language "csharp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"csharp", "ce.cs"))
    end
    factory :csharp_rte do
      language "csharp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"csharp", "re.cs"))
    end
    factory :csharp_tle do
      language "csharp"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"csharp", "tl.cs"))
    end
    factory :python_ok do
      language "py2"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python", "source.py"))
    end
    factory :python_wa do
      language "py2"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python", "wa.py"))
    end
    factory :python_rte do
      language "py2"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python", "re.py"))
    end
    factory :python_tle do
      language "py2"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python", "tl.py"))
    end
    factory :python3_ok do
      language "py3"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python3", "source.py"))
    end
    factory :python3_wa do
      language "py3"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python3", "wa.py"))
    end

    factory :python3_rte do
      language "py3"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python3", "re.py"))
    end
    factory :python3_tle do
      language "py3"
      solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"python3", "tl.py"))
    end

  end
end
