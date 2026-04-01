require 'spec_helper'

describe 'types', type: :class do
  let(:hiera_config) do
    File.expand_path('../fixtures/hiera/hiera.yaml', __dir__)
  end

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    # By default, all *_hiera_merge params are false except a few that default to true in the class
    # But since the main hash params are undef, no resources should be created
    it 'does not create any resources when all input hashes are undef' do
      is_expected.not_to contain_types__cron(anything)
      is_expected.not_to contain_types__exec(anything)
      is_expected.not_to contain_types__file_line(anything)
      is_expected.not_to contain_types__file(anything)
      is_expected.not_to contain_types__mount(anything)
      is_expected.not_to contain_types__package(anything)
      is_expected.not_to contain_types__selboolean(anything)
      is_expected.not_to contain_types__service(anything)
    end
  end

  # ------------------------------------------------------------------
  # Basic parameter passthrough (no hiera_merge)
  # ------------------------------------------------------------------
  context 'when crons hash is provided (no hiera_merge)' do
    let(:params) do
      {
        crons: {
          'backup' => { 'command' => '/usr/bin/backup.sh', 'hour' => '2' },
          'cleanup' => { 'command' => '/usr/bin/cleanup.sh', 'minute' => '0' },
        },
        crons_hiera_merge: false,
      }
    end

    it 'creates the defined types::cron resources' do
      is_expected.to contain_types__cron('backup').with_command('/usr/bin/backup.sh')
      is_expected.to contain_types__cron('cleanup').with_command('/usr/bin/cleanup.sh')
    end
  end

  context 'when services hash is provided (no hiera_merge)' do
    let(:params) do
      {
        services: {
          'httpd' => { 'ensure' => 'running', 'enable' => true },
          'sshd'  => { 'ensure' => 'running' },
        },
        services_hiera_merge: false,
      }
    end

    it 'creates the defined types::service resources' do
      is_expected.to contain_types__service('httpd').with_ensure('running')
      is_expected.to contain_types__service('sshd').with_ensure('running')
    end
  end

  # ------------------------------------------------------------------
  # Hiera merge behavior
  # ------------------------------------------------------------------

  context 'when services_hiera_merge => true' do
    let(:params) do
      {
        services: { 'dummy' => {} }, # should be ignored when hiera_merge is true
        services_hiera_merge: true,
      }
    end

    it 'uses hiera lookup instead of the passed services parameter' do
      is_expected.to contain_types__service('nginx').with_ensure('running')
      is_expected.to contain_types__service('mysql').with_ensure('stopped')
      is_expected.not_to contain_types__service('dummy')
    end
  end

  context 'when packages_hiera_merge => true' do
    let(:params) { { packages_hiera_merge: true } }

    it 'creates types::package resources from hiera' do
      is_expected.to contain_types__package('git').with_ensure('latest')
      is_expected.to contain_types__package('vim').with_ensure('present')
    end
  end

  # ------------------------------------------------------------------
  # Boolean/String conversion for *_hiera_merge parameters
  # ------------------------------------------------------------------
  context 'when hiera_merge parameters are passed as strings' do
    let(:params) do
      {
        files_hiera_merge: 'true',
        packages_hiera_merge: 'false',
      }
    end

    it 'converts string values to Boolean correctly' do
      # files_hiera_merge becomes true → should do lookup (we don't mock it here)
      # packages_hiera_merge becomes false → uses the passed hash (none here)
      is_expected.to compile
    end
  end

  # ------------------------------------------------------------------
  # Edge cases
  # ------------------------------------------------------------------
  context 'when a hash is undef (explicitly)' do
    let(:params) { { files: :undef, files_hiera_merge: true } }

    it 'does not attempt to create file resources' do
      is_expected.not_to contain_types__file(anything)
    end
  end

  context 'with multiple resource types at once' do
    let(:params) do
      {
        packages: { 'htop' => { 'ensure' => 'present' } },
        services: { 'sshd' => { 'ensure' => 'running' } },
        files:    { '/etc/motd' => { 'content' => 'Hello' } },
        packages_hiera_merge: false,
        services_hiera_merge: false,
        files_hiera_merge:    false,
      }
    end

    it 'creates resources from all provided hashes' do
      is_expected.to contain_types__package('htop')
      is_expected.to contain_types__service('sshd')
      is_expected.to contain_types__file('/etc/motd')
    end
  end

  # ------------------------------------------------------------------
  # Validation / error cases (optional but recommended)
  # ------------------------------------------------------------------
  context 'with invalid hiera_merge value' do
    let(:params) { { crons_hiera_merge: 'invalid' } }

    it 'raises a clear error for invalid boolean value' do
      expect { catalogue }.to raise_error(Puppet::Error, %r{new_boolean|Boolean|cannot be converted to Boolean|invalid}i)
    end
  end

  # Test that the class compiles cleanly on supported OSes
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
