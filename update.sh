ssh root@`cat ip_config` "chef-solo -c /var/chef/solo.rb"
