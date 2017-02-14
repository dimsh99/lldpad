# lldpad Cookbook

This cookbooks contains recipes and custom resource to install and configure lldpad

## Requirements

### Platforms
- `centos`     - not fully tested on centos, but should work
- `redhat`     - not fully tested on centos, but should work
- `scientific` - not fully tested on centos, but should work

### Chef

- Chef 12.0 or later

## Attributes

### lldpad::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['lldpad']['install_on_vm_guest']</tt></td>
    <td>Boolean</td>
    <td>whether to install lldpad on virtual machines</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['disabled_int_type']</tt></td>
    <td>Array</td>
    <td>Types of interfaces that should be disabled (adminStatus=disabled)</td>
    <td><tt>%w(team bond)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['ignored_int_type']</tt></td>
    <td>Array</td>
    <td>Types of interfaces that should be left unconfigured</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['adminStatus']</tt></td>
    <td>Symbol</td>
    <td>Default lldp setting for interface.
        :rx - Receive lldp packets
        :tx - Transmit lldp packets
        :rxtx - Receive and transmit lldp packets
        :disabled - lldp doesn't work on this interface</td>
    <td><tt>:rxtx</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['sysName']</tt></td>
    <td>Boolean</td>
    <td>Whether to transmit System Name TLV</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['sysDesc']</tt></td>
    <td>Boolean</td>
    <td>Whether to transmit System Description TLV</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['sysCap']</tt></td>
    <td>Boolean</td>
    <td>Whether to transmit System Caption TLV</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['portDesc']</tt></td>
    <td>Boolean</td>
    <td>Whether to transmit Port Description TLV</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['portID']['enableTx']</tt></td>
    <td>Boolean</td>
    <td>Whether to transmit Port ID TLV</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['portID']['subtype']</tt></td>
    <td>Symbol</td>
    <td>Value of Port ID TLV to be transmitted
        :PORT_ID_INTERFACE_NAME - Interface name
        :PORT_ID_MAC_ADDRESS - Mac address
        :PORT_ID_NETWORK_ADDRESS - IP address</td>
    <td><tt>:PORT_ID_INTERFACE_NAME</tt></td>
  </tr>
   <tr>
    <td><tt>['lldpad']['chassisID']['enableTx']</tt></td>
    <td>Boolean</td>
    <td>Whether to transmit Chassis ID TLV</td>
    <td><tt>%w(docker)</tt></td>
  </tr>
  <tr>
    <td><tt>['lldpad']['chassisID']['subtype']</tt></td>
    <td>Symbol</td>
    <td>Value of Port ID TLV to be transmitted
        :CHASSIS_ID_INTERFACE_NAME - Interface name
        :CHASSIS_ID_MAC_ADDRESS - Mac address
        :CHASSIS_ID_NETWORK_ADDRESS - IP address</td>
    <td><tt>:PORT_ID_MAC_ADDRESS</tt></td>
  </tr>
</table>

## Usage

### lldpad::default

Just include `lldpad` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[lldpad]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: Dmitry Shestoperov

