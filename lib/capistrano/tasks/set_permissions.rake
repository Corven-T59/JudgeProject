task :set_permissions do
  on roles(:app) do
    execute "chmod +x $HOME/JudgeProject/current/lib/judge/*.sh"
    execute "dos2unix $HOME/JudgeProject/current/lib/judge/*.sh"

    ActsAsTaggableOn.force_binary_collation = true
    ActsAsTaggableOn.force_lowercase = true
  end
end

after "deploy:published", "set_permissions"