#
# Cookbook:: ops-jenkins
# Recipe:: setup
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'java'
include_recipe 'apt'

execute 'docker' do
  command 'wget -qO- https://get.docker.com | sh'
  action :run
  creates '/lib/systemd/system/docker.service'
end

case node['platform_family']
when 'debian'
  package 'apt-transport-https'
  apt_repository 'jenkins' do
    uri          'https://pkg.jenkins.io/debian-stable'
    distribution 'binary/'
    key          'https://pkg.jenkins.io/debian-stable/jenkins.io.key'
  end

when 'rhel', 'amazon'
  yum_repository 'jenkins-ci' do
    baseurl 'https://pkg.jenkins.io/redhat-stable'
    gpgkey  'https://pkg.jenkins.io/redhat-stable/jenkins.io.key'
  end
end

package 'jenkins'

group 'docker' do
  action :modify
  members 'jenkins'
  append true
  notifies :restart, 'service[jenkins]', :delayed
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
