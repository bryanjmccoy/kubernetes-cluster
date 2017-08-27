#
# Cookbook:: kubernetes-cluster
# Recipe:: docker
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/sysconfig/docker-network' do
  mode '640'
  source 'docker-opts-cni.erb'
end

directory '/etc/kubernetes/cni/net.d/' do
  mode '0640'
  recursive true
  action :create
end

template '/etc/kubernetes/cni/net.d/10-flannel.conf' do
  mode '640'
  source 'flannel-netd.erb'
end

service 'docker' do
  action :restart
end
