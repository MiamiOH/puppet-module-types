# require 'spec_helper'

# describe 'types::exec' do
#   let(:title) { 'testing' }

#   on_supported_os.each do |os, os_facts|
#     context "on #{os}" do
#       let(:facts) { os_facts }

#       describe 'parameter validation' do
#         context 'when no parameters are provided' do
#           it 'fails' do
#             expect { catalogue }.to raise_error(
#               Puppet::Error,
#               %r{expects a value for parameter 'command'|Must pass command to},
#             )
#           end
#         end

#         context 'when only command is provided' do
#           let(:params) { { command: '/spec/testing.sh' } }

#           it { is_expected.to compile }

#           it do
#             is_expected.to contain_exec('testing')
#               .with_command('/spec/testing.sh')
#           end
#         end

#         context 'when all parameters are provided' do
#           let(:params) do
#             {
#               command: '/spec/testing.sh',
#               creates: '/creates',
#               cwd: '/spec',
#               environment: 'test=true',
#               group: 'group',
#               logoutput: true,
#               onlyif: '/onlyif.sh',
#               path: '/path',
#               provider: 'shell',
#               refresh: '/refresh.sh',
#               refreshonly: true,
#               returns: 242,
#               timeout: 3,
#               tries: 3,
#               try_sleep: 3,
#               unless: '/unless.sh',
#               user: 'tester',
#             }
#           end

#           it { is_expected.to compile }

#           it do
#             is_expected.to contain_exec('testing').with(
#               command: '/spec/testing.sh',
#               creates: '/creates',
#               cwd: '/spec',
#               environment: 'test=true',
#               group: 'group',
#               logoutput: true,
#               onlyif: '/onlyif.sh',
#               path: '/path',
#               provider: 'shell',
#               refresh: '/refresh.sh',
#               refreshonly: true,
#               returns: 242,
#               timeout: 3,
#               tries: 3,
#               try_sleep: 3,
#               unless: '/unless.sh',
#               user: 'tester',
#             )
#           end
#         end

#         context 'when provider is invalid' do
#           let(:params) do
#             {
#               command: '/spec/testing.sh',
#               provider: 'invalid',
#             }
#           end

#           it 'fails' do
#             expect { catalogue }.to raise_error(
#               Puppet::Error,
#               %r{expects a match for Enum},
#             )
#           end
#         end
#       end

#       describe 'type validations' do
#         let(:mandatory_params) { { command: '/spec/testing.sh' } }

#         {
#           'absolute path validation' => {
#             fields: [:creates, :cwd],
#             valid: ['/absolute/filepath', '/absolute/directory/'],
#             invalid: ['./relative/path', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, nil],
#             message: 'is not an absolute path',
#           },
#           'provider validation' => {
#             fields: [:provider],
#             valid: ['posix', 'shell', 'windows'],
#             invalid: ['string', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, nil],
#             message: 'expects a match for Enum',
#           },
#         }.each do |validation, data|
#           context validation do
#             data[:fields].each do |field|
#               data[:valid].each do |value|
#                 context "when #{field} is #{value.inspect} (valid)" do
#                   let(:params) { mandatory_params.merge(field => value) }

#                   it { is_expected.to compile }
#                 end
#               end

#               data[:invalid].each do |value|
#                 context "when #{field} is #{value.inspect} (invalid)" do
#                   let(:params) { mandatory_params.merge(field => value) }

#                   it 'fails' do
#                     expect { catalogue }.to raise_error(
#                       Puppet::Error,
#                       %r{#{data[:message]}},
#                     )
#                   end
#                 end
#               end
#             end
#           end
#         end
#       end
#     end
#   end
# end
