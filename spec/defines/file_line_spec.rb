# require 'spec_helper'

# describe 'types::file_line' do
#   let(:title) { 'some_file' }

#   on_supported_os.each do |os, os_facts|
#     context "on #{os}" do
#       let(:facts) { os_facts }

#       context 'with minimal parameters' do
#         let(:params) do
#           {
#             path: '/tmp/foo',
#             line: 'option=asdf',
#           }
#         end

#         it { is_expected.to compile }

#         it do
#           is_expected.to contain_file_line('some_file').with(
#             path: '/tmp/foo',
#             line: 'option=asdf',
#             match: nil,
#           )
#         end
#       end

#       context 'with all parameters' do
#         let(:params) do
#           {
#             ensure: 'present',
#             path: '/tmp/foo',
#             line: 'option=asdf',
#             match: '^option',
#           }
#         end

#         it { is_expected.to compile }

#         it do
#           is_expected.to contain_file_line('some_file').with(
#             ensure: 'present',
#             path: '/tmp/foo',
#             line: 'option=asdf',
#             match: '^option',
#           )
#         end
#       end

#       context 'with invalid path value' do
#         let(:params) do
#           {
#             path: 'invalid/path',
#             line: 'option=asdf',
#           }
#         end

#         it 'fails' do
#           expect { catalogue }.to raise_error(
#             Puppet::Error,
#             %r{not an absolute path},
#           )
#         end
#       end

#       context 'with invalid ensure value' do
#         let(:params) do
#           {
#             ensure: '!invalid',
#             path: '/tmp/foo',
#             line: 'option=asdf',
#           }
#         end

#         it 'fails' do
#           expect { catalogue }.to raise_error(
#             Puppet::Error,
#             %r{expects a match for Enum},
#           )
#         end
#       end

#       describe 'type validation failures' do
#         context 'when path is wrong type' do
#           let(:params) do
#             {
#               path: true,
#               line: 'option=asdf',
#             }
#           end

#           it 'fails' do
#             expect { catalogue }.to raise_error(
#               Puppet::Error,
#               %r{not an absolute path},
#             )
#           end
#         end

#         context 'when line is wrong type' do
#           let(:params) do
#             {
#               path: '/tmp/foo',
#               line: ['invalid', 'type'],
#             }
#           end

#           it 'fails' do
#             expect { catalogue }.to raise_error(
#               Puppet::Error,
#               %r{expects a String},
#             )
#           end
#         end

#         context 'when match is wrong type' do
#           let(:params) do
#             {
#               path: '/tmp/foo',
#               line: 'option=asdf',
#               match: ['invalid', 'type'],
#             }
#           end

#           it 'fails' do
#             expect { catalogue }.to raise_error(
#               Puppet::Error,
#               %r{expects a String},
#             )
#           end
#         end
#       end
#     end
#   end
# end
