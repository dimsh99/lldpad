module LldpadCookbook
  module Helpers # :nodoc:
    PORTID_SUBTYPE = [:PORT_ID_MAC_ADDRESS, :PORT_ID_NETWORK_ADDRESS,
                      :PORT_ID_INTERFACE_NAME].freeze
    CHASSISID_SUBTYPE = [:CHASSIS_ID_MAC_ADDRESS, :CHASSIS_ID_NETWORK_ADDRESS,
                         :CHASSIS_ID_INTERFACE_NAME].freeze
    def am_i_vm_guest?
      node.attribute?('virtualization') &&
        node['virtualization']['role'] == 'guest'
    end
  end
end
