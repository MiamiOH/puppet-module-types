require 'spec_helper'

describe 'types::service', type: :define do
  let(:title) { 'myservice' }

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    it 'declares the service resource with defaults' do
      is_expected.to contain_service('myservice').with(
        'ensure'     => 'running',
        'enable'     => true,
        'binary'     => nil,
        'control'    => nil,
        'hasrestart' => nil,
        'hasstatus'  => nil,
        'manifest'   => nil,
        'path'       => nil,
        'pattern'    => nil,
        'provider'   => nil,
        'restart'    => nil,
        'start'      => nil,
        'status'     => nil,
        'stop'       => nil,
      )
    end
  end

  context 'when ensure => stopped' do
    let(:params) { { ensure: 'stopped' } }

    it { is_expected.to contain_service('myservice').with_ensure('stopped') }
  end

  context 'when ensure => false' do
    let(:params) { { ensure: 'false' } }

    it { is_expected.to contain_service('myservice').with_ensure('false') }
  end

  context 'when enable => false' do
    let(:params) { { enable: false } }

    it { is_expected.to contain_service('myservice').with_enable(false) }
  end

  context 'when enable => manual' do
    let(:params) { { enable: 'manual' } }

    it { is_expected.to contain_service('myservice').with_enable('manual') }
  end

  context 'with all optional parameters set' do
    let(:params) do
      {
        ensure:     'running',
        binary:     '/usr/sbin/myservice',
        control:    '/usr/bin/service-control',
        enable:     true,
        hasrestart: true,
        hasstatus:  true,
        manifest:   '/lib/svc/manifest/myservice.xml',
        path:       '/usr/sbin',
        pattern:    'myservice',
        provider:   'systemd',
        restart:    '/usr/sbin/service myservice restart',
        start:      '/usr/sbin/service myservice start',
        status:     '/usr/sbin/service myservice status',
        stop:       '/usr/sbin/service myservice stop',
      }
    end

    it 'passes all parameters to the native service resource' do
      is_expected.to contain_service('myservice').with(
        'ensure'     => 'running',
        'binary'     => '/usr/sbin/myservice',
        'control'    => '/usr/bin/service-control',
        'enable'     => true,
        'hasrestart' => true,
        'hasstatus'  => true,
        'manifest'   => '/lib/svc/manifest/myservice.xml',
        'path'       => '/usr/sbin',
        'pattern'    => 'myservice',
        'provider'   => 'systemd',
        'restart'    => '/usr/sbin/service myservice restart',
        'start'      => '/usr/sbin/service myservice start',
        'status'     => '/usr/sbin/service myservice status',
        'stop'       => '/usr/sbin/service myservice stop',
      )
    end
  end

  # Test parameter validation (Puppet 7+ style)
  context 'with invalid ensure value' do
    let(:params) { { ensure: 'invalid' } }

    it { is_expected.to raise_error(Puppet::Error, %r{parameter 'ensure' expects a match}) }
  end

  context 'with invalid enable value' do
    let(:params) { { enable: 'invalid' } }

    it { is_expected.to raise_error(Puppet::Error, %r{parameter 'enable' expects}) }
  end

  # Test that the define works with different titles
  context 'with a different title' do
    let(:title) { 'another-service' }

    it { is_expected.to contain_service('another-service') }
  end
end
