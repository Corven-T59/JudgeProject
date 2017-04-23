FactoryGirl.define do
  factory :solution do
    user
    problem
    contest
    language "rb"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'basic', 'cpp', 'source.cpp'))

    [["cpp", "cpp", "cpp"], ["java", "java", "java"], ["ruby", "rb", "rb"], ["csharp", "csharp", "cs"],
     ["python", "py2", "py"], ["python3", "py3", "py"]].each do |lang|
      factory :"#{lang[0]}_ok" do
        language "#{lang[1]}"
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'basic', "#{lang[0]}", "source.#{lang[2]}"))
      end
      factory :"#{lang[0]}_wa" do
        language "#{lang[1]}"
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'basic', "#{lang[0]}", "wa.#{lang[2]}"))
      end
      if lang[0]!="ruby" && lang[0]!="python" && lang[0] != "python3"
        factory :"#{lang[0]}_ce" do
          language "#{lang[1]}"
          solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'basic', "#{lang[0]}", "ce.#{lang[2]}"))
        end
      end
      factory :"#{lang[0]}_rte" do
        language "#{lang[1]}"
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'basic', "#{lang[0]}", "re.#{lang[2]}"))
      end
      factory :"#{lang[0]}_tle" do
        language "#{lang[1]}"
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'basic', "#{lang[0]}", "tl.#{lang[2]}"))
      end
    end
    #,["java","java","java"],["ruby","rb","rb"], ["csharp", "csharp", "cs"],
    #   ["python","py2","py"],["python3","py3","py"]
    [["cpp", "cpp", "cpp"]].each do |lang|
      factory :"#{lang[0]}_interval" do
        language "#{lang[1]}"
        solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files', 'interval_product', "#{lang[0]}", "source.#{lang[2]}"))
      end
    end

  end
end
