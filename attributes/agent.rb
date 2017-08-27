#
# Cookbook: kubernetes-cluster
# License: Apache 2.0
#
# Copyright 2017, Cory Twitty
#

# master fqdn or ip
default['kubernetes']['master']['fqdn'] = "kube-proxy.novalocal"

# dns service endpoint
default['kubernetes']['service']['dns'] = '10.3.0.10'
