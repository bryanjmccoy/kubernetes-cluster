#
# Cookbook:: kubernetes-cluster
# Recipe:: openssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# yum_package 'openssl' do
#   action :install
# end

if tagged?('kubernetes.master')
  directory 'etc/kubernetes/ssl' do
    owerner 'root'
    recursive true
    group 'root'
    mode '0755'
    action :create
  end

  cookbook_file '/etc/kubernetes/ssl/ca.pem' do
    source 'ca.pem'
    owner 'root'
    group 'root'
    mode '0640'
    action :create
  end

  cookbook_file '/etc/kubernetes/ssl/openssl.cnf' do
    source 'openssl.cnf'
    owner 'root'
    group 'root'
    mode '0640'
    action :create
  end

  

elsif tagged?('kubernetes.agent')
  directory '/etc/kubernetes/ssl' do
    owner 'root'
    recursive true
    group 'root'
    mode '0755'
    action :create
  end

  cookbook_file '/etc/kubernetes/ssl/ca.pem' do
    source 'ca.pem'
    owner 'root'
    group 'root'
    mode '0640'
    action :create
  end

  cookbook_file '/etc/kubernetes/ssl/ca-key.pem' do
    source 'ca-key.pem'
    owner 'root'
    group 'root'
    mode '0640'
    action :create
  end

  template '/etc/kubernetes/ssl/worker-openssl.cnf' do
    source 'worker-openssl.cnf.erb'
    owner 'root'
    group 'root'
    mode '0640'
    variables(
      worker_ip: node['ipaddress']
    )
    action :create
  end

  execute 'genrsa' do
    command "openssl genrsa -out /etc/kubernetes/ssl/#{node['fqdn']}-worker-key.pem 2048"
    action :run
  end

  execute 'worker-key' do
    command "openssl req -new -key /etc/kubernetes/ssl/#{node['fqdn']}-worker-key.pem -out /etc/kubernetes/ssl/#{node['fqdn']}-worker.csr -subj \"/CN=#{node['fqdn']}\""
    action :run
  end

  execute 'worker-cert' do
    command "openssl x509 -req -in /etc/kubernetes/ssl/#{node['fqdn']}-worker.csr -CA /etc/kubernetes/ssl/ca.pem -CAkey /etc/kubernetes/ssl/ca-key.pem -CAcreateserial -out /etc/kubernetes/ssl/#{node['fqdn']}-worker.pem -days 365 -extensions v3_req -extfile /etc/kubernetes/ssl/worker-openssl.cnf"
    action :run
  end

  cookbook_file '/etc/kubernetes/ssl/ca-key.pem' do
    action :delete
  end

  file '/etc/kubernetes/ssl/ca.srl' do
    action :delete
  end

  template '/etc/kubernetes/ssl/worker-openssl.cnf' do
    action :delete
  end
else
  raise 'Unable to determine node. Check tags.'
end
