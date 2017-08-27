#
# Cookbook: kubernetes-cluster
# License: Apache 2.0
#
# Copyright 2017, Cory Twitty
#

# etcd config
default['kubernetes_cluster']['package']['etcd']['version'] = '>= 2.0.0'

# etcd configuration
default['kubernetes']['etcd']['members'] = %w(kube-master0.novalocal kube-master1.novalocal kube-master2.novalocal)
default['kubernetes']['etcd']['clientport'] = '2379'
default['kubernetes']['etcd']['peerport'] = '2380'
default['kubernetes']['etcd']['name'] = node['fqdn']

# hyperkube container
default['kubernetes']['hyperkube']['registry'] = 'quay.io/coreos/hyperkube'
default['kubernetes']['hyperkube']['tag'] = 'v1.6.6_coreos.1'

# service configuration
default['kubernetes']['service']['iprange'] = '10.3.0.0/16'
default['kubernetes']['service']['dns'] = '10.3.0.10'

# flannel configuration
default['kubernetes']['flannel']['network'] = '10.2.0.0/16'
default['kubernetes']['flannel']['netlength'] = '24'
