#
# Cookbook:: kubelet
# Spec:: installation
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

describe 'kubelet_test::installation_package' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04', step_into: ['kubelet_installation_package'])
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'adds a Kubernetes apt_repository' do
      expect(chef_run).to add_apt_repository('Kubernetes')
    end

    it 'installs a Kubelet package' do
      expect(chef_run).to install_package('kubelet').with(version: '1.11.3-00')
    end
  end

  context 'When all attributes are default, on CentOS 7.5' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.5.1804', step_into: ['kubelet_installation_package'])
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a Kubernetes yum_repository' do
      expect(chef_run).to create_yum_repository('Kubernetes')
    end

    it 'installs a Kubelet package' do
      expect(chef_run).to install_package('kubelet').with(version: '1.11.3')
    end
  end
end

describe 'kubelet_test::installation_binary' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04', step_into: ['kubelet_installation_binary'])
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a /opt/bin directory' do
      expect(chef_run).to create_directory('/opt/bin')
    end

    it 'creates a remote_file with kubelet' do
      expect(chef_run).to create_remote_file('/opt/bin/kubelet')
    end
  end
end
