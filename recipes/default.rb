#
# Cookbook:: correct_mongodb
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update' do
  action :update
end

apt_repository 'mongodb-org-3.2' do
    uri "http://repo.mongodb.org/apt/ubuntu"
    distribution 'trusty/mongodb-org/3.2'
    components ['multiverse']
    keyserver 'hkp://keyserver.ubuntu.com:80'
    key 'EA312927'
    action :add
end

package 'mongo_db' do
  action [:upgrade, :start]
end
