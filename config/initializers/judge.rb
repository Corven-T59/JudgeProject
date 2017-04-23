shell_files = [Rails.root.join("lib","judge","run.sh"), Rails.root.join("lib","judge","compare.sh")]
shell_files.each do |file|
  system("dos2unix #{file}")
end

ActsAsTaggableOn.force_binary_collation = true
ActsAsTaggableOn.force_lowercase = true