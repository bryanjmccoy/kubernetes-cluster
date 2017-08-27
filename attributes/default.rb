#
# Cookbook: kubernetes-cluster
# License: Apache 2.0
#
# Copyright 2017, Cory Twitty
#

# package version
default['kubernetes_cluster']['package']['flannel']['version'] = '>= 0.2.0'
default['kubernetes_cluster']['package']['docker']['name'] = 'docker'
default['kubernetes_cluster']['package']['docker']['version'] = '>= 0.0.0'
default['kubernetes_cluster']['package']['kubernetes_node']['version'] = '>= 1.5.2'
