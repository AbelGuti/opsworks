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
if node['elasticsearch']['version'] == "2.x" then
  execute 'install_elasticsearch_head' do
    command '/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head'
    action :run
    creates "/usr/share/elasticsearch/plugins/head"
  end
  execute 'install_elasticsearch_head' do
    command '/usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/v2.1.1'
    action :run
    creates "/usr/share/elasticsearch/plugins/kopf"
  end
end
