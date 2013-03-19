# Install packages
%w(
  git-core
  imagemagick
  ).each {|pkg| package pkg }

# Setup deployment group
node[:groups].each do |g|
  group g[:name] do
    gid g[:gid]
  end
end

# Setup user directories
include_recipe "users"
node[:users].each do |user|
  directories = %w[git tmp private xfer backup]

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

  # Setup other directories
  directories.each do |dir|
    directory "/home/#{user[:username]}/#{dir}" do
      owner user[:username]
    end
  end

end

# Include recipes
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

# Setup nginx config for rails applications
node[:rails_applications][:sites].each do |site|
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
