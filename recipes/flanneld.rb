#
# Cookbook:: kubernetes-cluster
# Recipe:: flanneld
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory '/etc/flannel' do
  mode '0640'
  action :create
end

template '/etc/sysconfig/flanneld' do
  mode '0640'
  source 'flannel-options.erb'
  variables(
    advertise_ip: node['ipaddress'],
    etcd_members: node['kubernetes']['etcd']['members'],
    etcd_client_port: node['kubernetes']['etcd']['clientport']
  )
end

directory '/etc/systemd/system/flanneld.service.d' do
  mode '0640'
  action :create
end

template '/etc/systemd/system/flanneld.service.d/40-ExecStartPre-symlink.conf' do
  mode '0640'
  source 'flannel-service-dropin.erb'
end

template '/tmp/flannel-network' do
  mode '0640'
  source 'flannel-network.erb'
  variables(
    flannel_network:   node['kubernetes']['flannel']['network'],
    flannel_netlength: node['kubernetes']['flannel']['netlength']
  )
end
