#
# Cookbook:: kubernetes-cluster
# Recipe:: agent-kubeconfig
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/kubernetes/worker-kubeconfig.yaml' do
  source 'agent-kubeconfig.erb'
  mode '0640'
  variables(
    worker_fqdn: node['fqdn']
  )
  action :create
end
