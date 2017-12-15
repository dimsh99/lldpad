extend LldpadCookbook::Helpers

if am_i_vm_guest?
  return unless node['lldpad']['install_on_vm_guest']
end

node['network']['interfaces'].each_pair do |iface_name, iface_desc|
  next unless iface_desc['encapsulation'] == 'Ethernet'
  next if node['lldpad']['ignored_int_type'].include?(iface_desc['type']) ||
          node['lldpad']['ignored_int_name'].any? { |ignore_name| iface_name =~ /^#{ignore_name}$/ } ||
          iface_desc['state'] == 'down' ||
          iface_desc['vlan']
  if node['lldpad']['disabled_int_type'].include?(iface_desc['type'])
    lldpad iface_name do
      adminStatus :disabled
    end
  else
    lldpad iface_name do
      action :apply
    end
  end
end
