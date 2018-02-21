#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java'
include_recipe 'apt'

package 'apt-transport-https'

apt_repository 'elasticsearch' do
  uri "#{node['elasticsearch']['repo']['url'][node['elasticsearch']['version']]}"
  components ['main']
  distribution 'stable'
  key "#{node['elasticsearch']['repo']['gpg'][node['elasticsearch']['version']]}"
  action :add
end

package 'elasticsearch' do
  action :install
end
