#
# Cookbook:: kubernetes-cluster
# Recipe:: kube-apiserver
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory '/etc/kubernetes/manifests' do
  mode '0640'
  action :create
end

template '/etc/kubernetes/manifests/kube-apiserver.yaml' do
  source 'kube-apiserver.erb'
  mode '0640'
  variables(
    apiserver_registry: node['kubernetes']['hyperkube']['registry'],
    apiserver_tag:      node['kubernetes']['hyperkube']['tag'],
    service_ip_range:   node['kubernetes']['service']['iprange'],
    advertise_ip:       node['ipaddress']
  )
  action :create
end
