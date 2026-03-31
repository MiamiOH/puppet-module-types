require 'spec_helper'

describe 'types::selboolean' do
  let(:title) { 'httpd_can_network_connect' }

  context 'with default parameters' do
    let(:params) { { value: 'on' } }

    it { is_expected.to compile.with_all_deps }

    it 'sets the SELinux boolean to on (non-persistent by default)' do
      is_expected.to contain_selboolean('httpd_can_network_connect')
        .with(
          'value'      => 'on',
          'persistent' => false,
        )
    end
  end

  context 'when value => off' do
    let(:params) { { value: 'off' } }

    it { is_expected.to compile.with_all_deps }

    it 'turns the boolean off' do
      is_expected.to contain_selboolean('httpd_can_network_connect')
        .with_value('off')
    end
  end

  context 'when persistent => true' do
    let(:params) do
      {
        value:      'on',
        persistent: true
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'makes the change persistent across reboots' do
      is_expected.to contain_selboolean('httpd_can_network_connect')
        .with(
          'value'      => 'on',
          'persistent' => true,
        )
    end
  end

  context 'with a custom provider' do
    let(:params) do
      {
        value:    'off',
        provider: 'getsetsebool'   # ← fixed
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'uses the specified provider' do
      is_expected.to contain_selboolean('httpd_can_network_connect')
        .with_provider('getsetsebool')
    end
  end

  context 'with both value and persistent set' do
    let(:params) do
      {
        value:      'off',
        persistent: true
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'correctly passes all parameters to the selboolean resource' do
      is_expected.to contain_selboolean('httpd_can_network_connect')
        .with(
          'value'      => 'off',
          'persistent' => true,
        )
    end
  end
end
