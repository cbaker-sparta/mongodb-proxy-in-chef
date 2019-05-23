#
# Cookbook:: correct_mongodb
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'correct_mongodb::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '18.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'updates all sources' do
      expect(chef_run).to update_apt_update 'update'
    end
    it 'should add mongo to the sources list' do
      expect(chef_run).to add_apt_repository 'mongodb-org'
    end
    it 'should upgrade mongodb' do
      expect(chef_run).to upgrade_package 'mongodb-org'
    end
    it 'should install mongodb' do
      expect(chef_run).to install_package 'mongodb-org'
    end
    it 'should enable mongodb' do
      expect(chef_run).to enable_service 'mongodb-org'
    end
    it 'should run mongodb' do
      expect(chef_run).to start_service 'mongodb-org'
    end
    it 'should create a mongod_proxy.conf template in /etc/mongod/sites-available' do
      expect(chef_run).to create_template("/etc/mongod/sites-available/mongod_proxy.conf").with_variables(proxy_port: 27017)
    end
    it 'should create a symlink of mongod_proxy.conf from sites-available to sites-enabled' do
      expect(chef_run).to create_link("/etc/mongod/sites-enabled/mongod_proxy.conf").with_link_type(:symbolic)
    end
    it 'should delete the symlink from the default config in sites-enabled' do
      expect(chef_run).to delete_link "/etc/mongod/sites-enabled/default"
    end
    at_exit {
      ChefSpec::Coverage.report! }
  end
end
