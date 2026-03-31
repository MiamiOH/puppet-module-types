require 'spec_helper'

describe 'types::file' do
  let(:title) { '/tmp/foo' }

  context 'with default parameters' do
    it do
      is_expected.to contain_file(title).with(
        ensure: 'present',
        owner:  'root',
        group:  'root',
        mode:   '0644',
      )
    end
  end

  context 'with many parameters set' do
    let(:params) do
      {
        ensure:       'directory',
        mode:         '0755',
        owner:        'www-data',
        group:        'www-data',
        content:      "# Managed by Puppet\n",
        backup:       '.puppet-bak',
        checksum:     'sha256',
        force:        true,
        ignore:       ['.git', '*.bak'],
        links:        'follow',
        purge:        true,
        recurse:      true,
        recurselimit: 3,
        replace:      false,
        show_diff:    false,
        seluser:      'system_u',
        selrole:      'object_r',
        seltype:      'httpd_sys_content_t',
        selrange:     's0'
      }
    end

    it { is_expected.to compile }
    it { is_expected.to contain_file(title).with(**params) }
  end

  describe 'ensure parameter' do
    ['present', 'absent', 'file', 'directory', 'link'].each do |val|
      context "with ensure => #{val}" do
        let(:params) { { ensure: val } }

        it { is_expected.to compile }
        it { is_expected.to contain_file(title).with_ensure(val) }
      end
    end

    context 'with invalid ensure' do
      let(:params) { { ensure: 'broken' } }

      it { is_expected.not_to compile }
    end
  end

  describe 'mode parameter' do
    ['0644', '0755', '0440', '1755'].each do |val|
      context "with mode => #{val}" do
        let(:params) { { mode: val } }

        it { is_expected.to compile }
        it { is_expected.to contain_file(title).with_mode(val) }
      end
    end

    ['666', '10644', 'abc', '06441', '064'].each do |val|
      context "with invalid mode => #{val}" do
        let(:params) { { mode: val } }

        it { is_expected.not_to compile }
      end
    end
  end

  context 'when both content and source are set' do
    let(:params) { { content: 'hi', source: 'puppet:///test' } }

    it { is_expected.not_to compile }
  end
end
