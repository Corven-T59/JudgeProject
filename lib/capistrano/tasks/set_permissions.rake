task :set_permissions do
  on roles(:app) do
    execute "chmod +x $HOME/JudgeProject/current/lib/judge/*.sh"
  end
end
after "deploy:published", "set_permissions"