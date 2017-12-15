include LldpadCookbook::Helpers::Lldpad

provides :lldpad

property :interface, kind_of: String, name_property: true,
                     equal_to: node['network']['interfaces'].keys
property :adminStatus, kind_of: Symbol,
                       equal_to: [:disabled, :rx, :tx, :rxtx],
                       default: node['lldpad']['adminStatus']
property :sysName, kind_of: [TrueClass, FalseClass],
                   default: node['lldpad']['sysName']
property :sysCap, kind_of: [TrueClass, FalseClass],
                  default: node['lldpad']['sysCap']
property :sysDesc, kind_of: [TrueClass, FalseClass],
                   default: node['lldpad']['sysDesc']
property :portDesc, kind_of: [TrueClass, FalseClass],
                    default: node['lldpad']['portDesc']
property :chassisID, kind_of: Hash, default: node['lldpad']['chassisID'].to_h,
                     coerce: proc { |value|
                               case value
                               when TrueClass, FalseClass
                                 { 'enableTx' => value,
                                   'subtype' => node['lldpad']['chassisID']['subtype'] }
                               when Symbol, String
                                 { 'enableTx' => node['lldpad']['chassisID']['enableTx'],
                                   'subtype' => value.to_sym }
                               when Hash
                                 value['enableTx'] = node['lldpad']['chassisID']['enableTx'] \
                                   unless value.key?('enableTx')
                                 value['subtype'] = node['lldpad']['chassisID']['subtype'] \
                                   unless value.key?('subtype')
                                 value
                               end
                             },
                     callbacks: {
                       'portID has to be Hash, Boolean, Symbol or String' => \
                         proc do |value|
                           return false unless value.key?('enableTx') && \
                                               value['enableTx'].is_a?(TrueClass) ||
                                               value['enableTx'].is_a?(FalseClass)
                           return false unless value.key?('subtype') && \
                                               CHASSISID_SUBTYPE.include?(value['subtype'])
                           true
                         end,
                     }
property :portID, kind_of: Hash, default: node['lldpad']['portID'].to_h,
                  coerce: proc { |value|
                            case value
                            when TrueClass, FalseClass
                              { 'enableTx' => value,
                                'subtype' => node['lldpad']['portID']['subtype'] }
                            when Symbol, String
                              { 'enableTx' => node['lldpad']['portID']['enableTx'],
                                'subtype' => value.to_sym }
                            when Hash
                              value['enableTx'] = node['lldpad']['portID']['enableTx'] \
                                unless value.key?('enableTx')
                              value['subtype'] = node['lldpad']['portID']['subtype'] \
                                unless value.key?('subtype')
                              value
                            end
                          },
                  callbacks: {
                    'portID has to be Hash, Boolean, Symbol or String' => \
                      proc do |value|
                        false unless value.key?('enableTx') && \
                                     value['enableTx'].is_a?(TrueClass) ||
                                     value['enableTx'].is_a?(FalseClass)
                        false unless value.key?('subtype') && \
                                     PORTID_SUBTYPE.include?(value['subtype'])
                        true
                      end,
                  }
default_action :apply

action :apply do
  unless get_lldp(interface, 'adminStatus') == adminStatus
    converge_by("Set adminStatus to #{adminStatus}") do
      set_lldp(interface, 'adminStatus', adminStatus)
    end
  end
  [:sysName, :sysCap, :sysDesc, :portDesc, :portID, :chassisID].each do |vtl|
    vtl_args = send(vtl).is_a?(Hash) ? send(vtl) : { enableTx: send(vtl) }
    vtl_args.each_pair do |arg_name, arg_val|
      # AFAIK: lldptool in Ubuntu 12.0.4 supports only enableTx
      next if arg_name != 'enableTx' && node['platform'] == 'ubuntu' && \
              node['platform_version'].to_i == 12
      next if get_vtl(interface, vtl, arg_name) == arg_val
      converge_by("Set #{vtl} #{arg_name} to #{arg_val}") do
        set_vtl(interface, vtl.to_s, arg_name, arg_val)
      end
    end
  end
end
