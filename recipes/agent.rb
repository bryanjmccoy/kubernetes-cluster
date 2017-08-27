#
# Cookbook:: kubernetes-cluster
# Recipe:: agent
#
# Copyright:: 2017, The Authors, All Rights Reserved.

node.tag('kubernetes.agent')

include_recipe 'kubernetes-cluster::openssl'
include_recipe 'kubernetes-cluster::default'
include_recipe 'kubernetes-cluster::flanneld'
include_recipe 'kubernetes-cluster::docker'
include_recipe 'kubernetes-cluster::kubelet'
include_recipe 'kubernetes-cluster::kube-proxy'
include_recipe 'kubernetes-cluster::agent-kubeconfig'

execute 'systemd_reload' do
  command 'systemctl daemon-reload'
  action :run
end

service 'flanneld' do
  action [:restart, :enable]
end

service 'kubelet' do
  action [:restart, :enable]
end

service 'flanneld' do
  action :restart
end
