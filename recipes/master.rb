#
# Cookbook:: kubernetes-cluster
# Recipe:: master
#
# Copyright:: 2017, The Authors, All Rights Reserved.

node.tag('kubernetes.master')

include_recipe 'kubernetes-cluster::default'

yum_package 'etcd' do
  "etcd ['kubernetes_cluster']['package']['etcd']['version']"
  action :install
end


include_recipe 'kubernetes-cluster::etcd'
include_recipe 'kubernetes-cluster::flanneld'
include_recipe 'kubernetes-cluster::docker'
include_recipe 'kubernetes-cluster::kubelet'
include_recipe 'kubernetes-cluster::kube-apiserver'
include_recipe 'kubernetes-cluster::kube-proxy'
include_recipe 'kubernetes-cluster::kube-controller-manager'
include_recipe 'kubernetes-cluster::kube-scheduler'

execute 'systemctl_reload' do
  command 'systemctl daemon-reload'
  action :run
end

service 'etcd' do
  action [:restart, :enable]
end

execute 'setnetwork' do
  command 'etcdctl set coreos.com/network/config < /tmp/flannel-network'
  action :run
end

service 'flanneld' do
  action [:restart, :enable]
end

service 'docker' do
  action :restart
end

service 'kubelet' do
  action [:restart, :enable]
end
