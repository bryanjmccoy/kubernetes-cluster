#
# Cookbook:: kubernetes-cluster
# Recipe:: kube-controller-manager
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/kubernetes/manifests/kube-controller-manager.yaml' do
  source 'kube-controller-manager.erb'
  mode '0640'
  variables(
    apiserver_registry: node['kubernetes']['hyperkube']['registry'],
    apiserver_tag:      node['kubernetes']['hyperkube']['tag']
  )
  action :create
end
