#
# Cookbook:: kubernetes-cluster
# Recipe:: kube-scheduler
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/kubernetes/manifests/kube-scheduler.yaml' do
  source 'kube-scheduler.erb'
  mode '0640'
  variables(
    apiserver_registry: node['kubernetes']['hyperkube']['registry'],
    apiserver_tag:      node['kubernetes']['hyperkube']['tag']
  )
  action :create
end
