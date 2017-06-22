#
# Cookbook Name:: lldpad
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "#{cookbook_name}::install"
include_recipe "#{cookbook_name}::configure"
include_recipe "#{cookbook_name}::plugin"
