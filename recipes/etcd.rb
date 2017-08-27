#
# Cookbook:: kubernetes-cluster
# Recipe:: etcd
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/etcd/etcd.conf' do
  source 'etcd-conf.erb'
  mode '0640'
  variables(
    advertise_ip: node['ipaddress'],
    etcd_members: node['kubernetes']['etcd']['members'],
    etcd_name: node['kubernetes']['etcd']['name'],
    etcd_peer_port: node['kubernetes']['etcd']['peerport'],
    etcd_client_port: node['kubernetes']['etcd']['clientport']
  )
  action :create
end
