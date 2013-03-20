ssh root@`cat ip` "chef-solo -c /var/chef/solo.rb -j /var/chef/node.json"
