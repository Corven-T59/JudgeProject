[["cpp","cpp","cpp"],["java","java","java"],["ruby","rb","rb"], ["csharp", "csharp", "cs"],
 ["python","py2","py"],["python3","py3","py"] ].each do |lang|
  string = <<END
  factory :#{lang[0]}_ok do
    language "#{lang[1]}"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"#{lang[0]}", "source.#{lang[2]}"))
  end
  factory :#{lang[0]}_wa do
    language "#{lang[1]}"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"#{lang[0]}", "wa.#{lang[2]}"))
  end
  factory :#{lang[0]}_ce do
    language "#{lang[1]}"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"#{lang[0]}", "ce.#{lang[2]}"))
  end
  factory :#{lang[0]}_rte do
    language "#{lang[1]}"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"#{lang[0]}", "re.#{lang[2]}"))
  end
  factory :#{lang[0]}_tle do
    language "#{lang[1]}"
    solutionFile File.open(File.join(Rails.root, 'spec', 'support', 'files',"#{lang[0]}", "tl.#{lang[2]}"))
  end
END
  puts string
end