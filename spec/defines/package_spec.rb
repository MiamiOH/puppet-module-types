require 'spec_helper'

describe 'types::package' do
  let(:title) { 'example_package' }

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    it 'declares the package resource with default ensure' do
      is_expected.to contain_package('example_package')
        .with_ensure('present')
    end
  end

  context 'when ensure => absent' do
    let(:params) { { ensure: 'absent' } }

    it { is_expected.to compile.with_all_deps }

    it 'removes the package' do
      is_expected.to contain_package('example_package')
        .with_ensure('absent')
    end
  end

  context 'when ensure => latest' do
    let(:params) { { ensure: 'latest' } }

    it { is_expected.to compile.with_all_deps }

    it 'ensures the latest version' do
      is_expected.to contain_package('example_package')
        .with_ensure('latest')
    end
  end

  context 'with provider and install_options' do
    let(:params) do
      {
        ensure:          'installed',
        provider:        'apt',
        install_options: ['--no-install-recommends']
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'passes the provider and install options' do
      is_expected.to contain_package('example_package')
        .with(
          'ensure'          => 'installed',
          'provider'        => 'apt',
          'install_options' => ['--no-install-recommends'],
        )
    end
  end

  context 'with source and responsefile' do
    let(:params) do
      {
        ensure:       'present',
        source:       '/path/to/package.deb',
        responsefile: '/tmp/response.txt'
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'passes source and responsefile to the package resource' do
      is_expected.to contain_package('example_package')
        .with(
          'source'       => '/path/to/package.deb',
          'responsefile' => '/tmp/response.txt',
        )
    end
  end
end
