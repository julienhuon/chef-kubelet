#
# Cookbook:: kubelet
# Spec:: service
#
# Copyright:: 2018, Julien Huon
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe 'kubelet_test::service' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04', step_into: ['kubelet_service'])
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a /etc/kubernetes directory' do
      expect(chef_run).to create_directory('/etc/kubernetes')
    end

    it 'creates a kubelet config file with template' do
      expect(chef_run).to create_template('/etc/kubernetes/config.yaml')
    end

    it 'enables & start a kubelet service' do
      expect(chef_run).to enable_service('kubelet')
    end
  end
end
