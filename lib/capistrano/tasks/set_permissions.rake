task :set_permissions do
  on roles(:app) do
    shell_files = [Rails.root.join("lib", "judge", "run.sh"), Rails.root.join("lib", "judge", "compare.sh")]
    shell_files.each do |file|
      system("dos2unix #{file}")
    end
    execute "chmod +x $HOME/JudgeProject/current/lib/judge/*.sh"

    ActsAsTaggableOn.force_binary_collation = true
    ActsAsTaggableOn.force_lowercase = true
  end
end

after "deploy:published", "set_permissions"