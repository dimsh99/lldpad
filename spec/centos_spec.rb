require 'spec_helper'

describe 'centos::lldpad::default::physical' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(
      platform: 'centos', version: '6.4'
    ) do |node|
      node.automatic['memory']['total'] = '2048kB'
      node.automatic['ipaddress'] = '1.1.1.1'
      node.automatic['network']['interfaces']['eth0']['encapsulation'] = 'Ethernet'
      node.automatic['network']['interfaces']['eth0']['type'] = 'eth'
      node.automatic['network']['interfaces']['bond0']['encapsulation'] = 'Ethernet'
      node.automatic['network']['interfaces']['bond0']['type'] = 'bond'
      node.automatic['network']['interfaces']['docker0']['encapsulation'] = 'Ethernet'
      node.automatic['network']['interfaces']['docker0']['type'] = 'docker'
      node.override['virtualization'].delete('role')
    end
    runner.converge('lldpad::default')
  end

  it 'Installs lldpad package' do
    expect(chef_run).to upgrade_package('lldpad')
  end

  it 'Start lldpad service' do
    expect(chef_run).to start_service('lldpad')
  end
  it 'Configure enabled interface (eth0)' do
    expect(chef_run).to apply_lldpad('eth0').with(adminStatus: :rxtx)
  end
  it 'Configure disabled interface (bond0)' do
    expect(chef_run).to apply_lldpad('bond0').with(adminStatus: :disabled)
  end
  it 'Don t configure ignored interface (docker0)' do
    expect(chef_run).not_to apply_lldpad('docker0')
  end
end

describe 'centos::lldpad::default::virtual' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(
      platform: 'centos', version: '6.4'
    ) do |node|
      node.automatic['memory']['total'] = '2048kB'
      node.automatic['ipaddress'] = '1.1.1.1'
      node.automatic['network']['interfaces']['eth0']['encapsulation'] = 'Ethernet'
      node.automatic['network']['interfaces']['eth0']['type'] = 'eth'
      node.automatic['network']['interfaces']['bond0']['encapsulation'] = 'Ethernet'
      node.automatic['network']['interfaces']['bond0']['type'] = 'bond'
      node.automatic['network']['interfaces']['docker0']['encapsulation'] = 'Ethernet'
      node.automatic['network']['interfaces']['docker0']['type'] = 'docker'
      node.automatic['virtualization']['role'] = 'guest'
    end
    runner.converge('lldpad::default')
  end

  it 'Dont installs lldpad package' do
    expect(chef_run).not_to upgrade_package('lldpad')
  end

  it 'Dont start lldpad service' do
    expect(chef_run).not_to start_service('lldpad')
  end
  it 'Dont configure enabled interface (eth0)' do
    expect(chef_run).not_to apply_lldpad('eth0').with(adminStatus: :rxtx)
  end
  it 'Dont configure disabled interface (bond0)' do
    expect(chef_run).not_to apply_lldpad('bond0').with(adminStatus: :disabled)
  end
  it 'Dont configure ignored interface (docker0)' do
    expect(chef_run).not_to apply_lldpad('docker0')
  end
end
