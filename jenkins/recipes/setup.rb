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

package [ 'jenkins', 'unzip', 'python-pip' ]

template '/etc/default/jenkins' do
  source 'jenkins-default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[jenkins]', :delayed
end

bash 'dsiable_install_wizrd' do
  user 'jenkins'
  group 'jenkins'
  cwd '/var/lib/jenkins'
  code <<-EOH
  echo $(dpkg-query -W -f='${Version}' jenkins) > jenkins.install.InstallUtil.lastExecVersion
  echo $(dpkg-query -W -f='${Version}' jenkins) > jenkins.install.UpgradeWizard.state
  EOH
end

template '/var/lib/jenkins/init.groovy' do
  source 'init.groovy.erb'
  owner 'root'
  group 'root'
  mode '0744'
  notifies :restart, 'service[jenkins]', :delayed
end

cookbook_file '/usr/share/jenkins/install-plugins.sh' do
  source 'install-plugins.sh'
  mode '0775'
end

cookbook_file '/usr/local/bin/jenkins-support' do
  source 'jenkins-support'
  mode '0775'
end

cookbook_file '/usr/share/jenkins/plugins.txt' do
  source 'plugins.txt'
  mode '0775'
end

bash 'install_plugins' do
  cwd '/tmp'
  code <<-EOH
  rm -rf /usr/share/jenkins/ref/plugins/*
  cat /usr/share/jenkins/plugins.txt | /usr/share/jenkins/install-plugins.sh
  mv /usr/share/jenkins/ref/plugins/* /var/lib/jenkins/plugins/
  touch /usr/share/jenkins/plugins_installed
  EOH
  not_if { ::File.exist?('/usr/share/jenkins/plugins_installed') }
end

execute 'install_awscli' do
  command 'pip install -U awscli ecs-deploy'
  action :run
end

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
