include_recipe "#{cookbook_name}::install"

ohai cookbook_name do
  action :nothing
end

cookbook_file "#{cookbook_name} ohai plugin" do
  source 'lldpad.rb'
  path "#{node['ohai']['plugin_path']}/lldpad.rb"
  mode '0755'
  purge false
  action :create_if_missing
  notifies :reload, "ohai[#{cookbook_name}]"
end
