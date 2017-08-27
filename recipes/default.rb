#
# Cookbook:: kubernetes-cluster
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'nslookup' do
  command 'nslookup kube-master1.novalocal > /tmp/nslookup'
  action :run
end


case node['platform']
when 'redhat', 'centos', 'fedora'
  yum_package 'python-wheel'
  yum_package 'python2-pip'
  yum_package "flannel #{node['kubernetes_cluster']['package']['flannel']['version']}"
  yum_package "#{node['kubernetes_cluster']['package']['docker']['name']} #{node['kubernetes_cluster']['package']['docker']['version']}"
  yum_package "kubernetes-node #{node['kubernetes_cluster']['package']['kubernetes_node']['version']}"

  cookbook_file '/tmp/dydns-1.1.tar.gz' do
    source 'dydns-1.1.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  execute 'pip install' do
    command 'pip install /tmp/dydns-1.1.tar.gz'
    action :run
  end

  execute 'pynsupdate' do
    command '/usr/bin/pynsupdate'
    action :run
  end

  service 'firewalld' do
    action [:disable, :stop]
  end
  service 'iptables' do
    action [:disable, :stop]
  end
end
