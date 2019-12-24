#
# Cookbook:: kubelet
# Resource:: kubelet_installation_binary
#
# Copyright:: 2018, Julien Huon
#
# License:: Apache License, Version 2.0
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
#

resource_name :kubelet_installation_binary

property :kubelet_binary_url,      String, default: lazy { "https://storage.googleapis.com/kubernetes-release/release/v#{kubelet_version}/bin/linux/amd64/kubelet" }
property :kubelet_binary_checksum, String, default: 'c2af77f501c3164e80171903028d35c632366f53dec0c8419828d4e55d86146f'
property :kubelet_version,         String, default: '1.17.0'
property :kubelet_dir,             String, default: '/opt/bin'
property :cni_tgz_url,             String, default: lazy { "https://github.com/containernetworking/plugins/releases/download/v#{cni_version}/cni-plugins-amd64-v#{cni_version}.tgz" }
property :cni_tgz_checksum,        String, default: '3ca15c0a18ee830520cf3a95408be826cbd255a1535a38e0be9608b25ad8bf64'
property :cni_version,             String, default: '0.7.5'
property :cni_prefix_dir,          String, default: '/opt'

action :create do
  directory new_resource.kubelet_dir do
    owner 'root'
    group 'root'
    mode '0755'
  end

  remote_file "#{new_resource.kubelet_dir}/kubelet" do
    source new_resource.kubelet_binary_url
    checksum new_resource.kubelet_binary_checksum
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  ark 'cni' do
    url new_resource.cni_tgz_url
    version new_resource.cni_version
    checksum new_resource.cni_tgz_checksum
    prefix_root new_resource.cni_prefix_dir
    prefix_home new_resource.cni_prefix_dir
    action :install
  end
end
