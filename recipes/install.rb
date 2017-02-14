Chef::Recipe.send(:include, LldpadCookbook::Helper)

if am_i_vm_guest?
  return unless node['lldpad']['install_on_vm_guest']
end

package 'lldpad' do
  action :upgrade
end

service 'lldpad' do
  action [:start, :enable]
end
