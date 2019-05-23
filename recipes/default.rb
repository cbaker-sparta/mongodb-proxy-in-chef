#
# Cookbook:: correct_mongodb
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update' do
  action :update
end

apt_repository 'mongodb-org' do
    uri "http://repo.mongodb.org/apt/ubuntu"
    distribution 'xenial/mongodb-org/3.2'
    components ['multiverse']
    keyserver 'hkp://keyserver.ubuntu.com:80'
    key 'EA312927'
end

package 'mongodb-org' do
  action [:upgrade, :install]
end

service 'mongodb-org' do
  action [:enable, :start]
end

template '/etc/mongod/sites-available/mongod_proxy.conf' do
  source 'mongod_proxy.conf.erb'
  variables proxy_port: node['mongodb-org']['27017']
  notifies :restart, 'service[mongodb-org]'
end

link '/etc/mongod/sites-enabled/mongod_proxy.conf' do
  to '/etc/mongod/sites-available/mongod_proxy.conf'
  notifies :restart, 'service[mongodb-org]'
end

link '/etc/mongod/sites-enabled/default' do
  notifies :restart, 'service[mongodb-org]'
  action :delete
end
