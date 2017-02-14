module LldpadCookbook
  module Helpers # :nodoc:
    module Lldpad # :nodoc:
      PORTID_SUBTYPE = [:PORT_ID_MAC_ADDRESS, :PORT_ID_NETWORK_ADDRESS,
                        :PORT_ID_INTERFACE_NAME].freeze
      CHASSISID_SUBTYPE = [:CHASSIS_ID_MAC_ADDRESS, :CHASSIS_ID_NETWORK_ADDRESS,
                           :CHASSIS_ID_INTERFACE_NAME].freeze
      def parse_val(arg_name, stdout)
        value = stdout.match(/^#{arg_name}=(.*)$/).captures[0]
        case value
        when 'yes'
          true
        when 'no'
          false
        else
          value.to_sym
        end
      end

      def convert_val(value)
        case value
        when true
          'yes'
        when false
          'no'
        else
          value.to_s
        end
      end

      def set_lldp(iface, param_name, value)
        shell_out!('lldptool', '-L',
                   '-i', iface,
                   "#{param_name}=#{convert_val(value)}")
      end

      def get_lldp(iface, param_name)
        parse_val(param_name,
                  shell_out!(
                    'lldptool', '-l',
                    '-i', iface,
                    param_name
                  ).stdout)
      end

      def set_vtl(iface, vtl_name, command_arg, value)
        shell_out!('lldptool', '-T',
                   '-i', iface,
                   '-V', vtl_name.to_s,
                   '-c', "#{command_arg}=#{convert_val(value)}")
      end

      def get_vtl(iface, vtl_name, command_arg)
        parse_val(command_arg, shell_out!(
          'lldptool', '-t',
          '-i', iface,
          '-V', vtl_name.to_s,
          '-c', command_arg.to_s
        ).stdout)
      end
    end
  end
end
