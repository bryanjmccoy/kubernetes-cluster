#
# Cookbook:: kubernetes-cluster
# Recipe:: kubelet
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if tagged?('kubernetes.master')
  template '/etc/kubernetes/kubelet' do
    source 'kubelet-master-config.erb'
    mode '0640'
    variables(
      advertise_ip:     node['ipaddress'],
      dns_ip:           node['kubernetes']['service']['dns']
    )
    action :create
  end
  template '/etc/kubernetes/config' do
    source 'kube-config-master.erb'
    mode '0640'
    action :create
  end
  template '/etc/kubernetes/cloud-config' do
    source 'cloud-config.erb'
    mode '0640'
    action :create
  end
elsif tagged?('kubernetes.agent')
  template '/etc/kubernetes/kubelet' do
    source 'kubelet-agent-config.erb'
    mode '0640'
    variables(
      worker_ip:        node['ipaddress'],
      master_fqdn:      node['kubernetes']['master']['fqdn'],
      advertise_ip:     node['ipaddress'],
      dns_ip:           node['kubernetes']['service']['dns'],
      worker_fqdn:      node['fqdn']
    )
    action :create
  end
  template '/etc/kubernetes/config' do
    source 'kube-config-agent.erb'
    mode '0640'
    variables(
      master_ip: node['kubernetes']['master']['fqdn']
    )
    action :create
  end
  template '/etc/kubernetes/cloud-config' do
    source 'cloud-config.erb'
    mode '0640'
    action :create
  end
else
  raise 'Unable to determine node. Check tags.'
end
