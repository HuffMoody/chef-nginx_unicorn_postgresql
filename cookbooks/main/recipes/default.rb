%w(
  git-core
  imagemagick
  ).each {|pkg| package pkg }

node[:groups].each do |g|
  group g[:name] do
    gid g[:gid]
  end
end

include_recipe "users"

# Setup directories
# Setup user directories
node[:users].each do |user|
  directories = %w[git tmp private xfer]

  # setup web directory
  if FileTest.exists?('/data')
    directory "/data/#{user[:username]}/web" do
      recursive true
      owner user[:username]
    end
    execute "symlink web directory" do
      command "ln -s /data/#{user[:username]}/web /home/#{user[:username]}/web"
      creates "/home/#{user[:username]}/web"
      action :run
    end
  else
    directories += %[web]
  end

  directories.each do |dir|
    directory "/home/#{user[:username]}/#{dir}" do
      owner user[:username]
    end
  end
end

%w(
   ruby-shadow
   ruby_build
   rbenv::system
   nginx::source
   nginx::rails_unicorn
   postgresql::server
   postgresql::client
   nodejs::install_from_source
   logrotate
   sudo
   memcached
   ).each {|recipe| include_recipe recipe }

# create a git repo for every rails_unicorn site
node[:rails_unicorn][:sites].each do |site|

  git_dir = "/home/#{site[:deploy_user]}/git/#{site[:sitename]}.git"

  bash "Create git repo #{git_dir}" do
    user site[:deploy_user]
    code <<-EOH
      mkdir #{git_dir}
      cd #{git_dir}
      git init --bare
    EOH
    not_if "test -d #{git_dir}"
  end

end
