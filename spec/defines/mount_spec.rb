require 'spec_helper'

describe 'types::mount' do
  let(:title) { '/mnt' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with minimal parameters' do
        let(:params) do
          {
            device: '/dev/dvd',
            fstype: 'iso9660',
          }
        end

        it { is_expected.to compile }

        it do
          is_expected.to contain_mount('/mnt').with(
            ensure: 'mounted',
            name: '/mnt',
            atboot: true,
            device: '/dev/dvd',
            fstype: 'iso9660',
          )
        end
      end

      context 'with all parameters' do
        let(:params) do
          {
            device:      '/dev/fiction',
            fstype:      'iso9660',
            ensure:      'absent',
            atboot:      false,
            blockdevice: '/dev/blockdevice',
            dump:        1,
            options:     'ro',
            pass:        1,
            remounts:    true,
            # provider removed for cross-OS compatibility
          }
        end

        it { is_expected.to compile }

        it do
          is_expected.to contain_mount('/mnt').with(
            ensure:      'absent',
            atboot:      false,
            device:      '/dev/fiction',
            fstype:      'iso9660',
            name:        '/mnt',
            blockdevice: '/dev/blockdevice',
            dump:        1,
            options:     'ro',
            pass:        1,
            remounts:    true,
          )
        end
      end

      context 'with invalid ensure' do
        let(:params) do
          {
            device: '/dev/fiction',
            fstype: 'iso9660',
            ensure: '!invalid',
          }
        end

        it 'fails' do
          expect { catalogue }.to raise_error(
            Puppet::Error,
            %r{expects a match for Enum},
          )
        end
      end

      context "when ensure => 'absent'" do
        let(:title) { '/mnt/test' }
        let(:params) do
          {
            ensure: 'absent',
            device: '/dev/fiction',
            fstype: 'iso9660',
          }
        end

        it { is_expected.to compile }

        it do
          is_expected.not_to contain_common__mkdir_p('/mnt/test')
        end
      end

      context "when options => 'defaults'" do
        context 'on Solaris' do
          let(:facts) do
            os_facts.merge(
              os: { 'family' => 'Solaris' },
            )
          end

          let(:params) do
            {
              device: '/dev/fiction',
              fstype: 'iso9660',
              options: 'defaults',
            }
          end

          it { is_expected.to compile }

          it do
            is_expected.to contain_mount('/mnt').with(
              options: '-',
            )
          end
        end

        context 'on non-Solaris' do
          let(:params) do
            {
              device: '/dev/fiction',
              fstype: 'iso9660',
              options: 'defaults',
            }
          end

          it { is_expected.to compile }

          it do
            is_expected.to contain_mount('/mnt').with(
              options: 'defaults',
            )
          end
        end
      end
    end
  end
end
