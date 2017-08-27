#
# Cookbook:: kubernetes-cluster
# Recipe:: kube-proxy
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory '/etc/kubernetes/manifests' do
  mode '0640'
  action :create
end

if tagged?('kubernetes.master')
  template '/etc/kubernetes/manifests/kube-proxy.yaml' do
    source 'kube-proxy.erb'
    mode '0640'
    variables(
      apiserver_registry: node['kubernetes']['hyperkube']['registry'],
      apiserver_tag:      node['kubernetes']['hyperkube']['tag'],
    )
    action :create
  end
elsif tagged?('kubernetes.agent')
  template '/etc/kubernetes/manifests/kube-proxy.yaml' do
    source 'kube-proxy-agent.erb'
    mode   '0640'
    variables(
      apiserver_registry: node['kubernetes']['hyperkube']['registry'],
      apiserver_tag:      node['kubernetes']['hyperkube']['tag'],
      master_fqdn:        node['kubernetes']['master']['fqdn']
    )
  end
else
  raise 'Unable to detect correct node tag.'
end
