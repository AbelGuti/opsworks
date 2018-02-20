#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java'
include_recipe 'apt'

package 'apt-transport-https'

apt_repository 'elasticsearch' do
  uri 'https://artifacts.elastic.co/packages/6.x/apt'
  components ['main']
  distribution 'stable'
  key 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  action :add
end

package 'elasticsearch' do
  action :install
end
