#
# Cookbook:: kubelet
# Resource:: kubelet_installation_package
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

resource_name :kubelet_installation_package

property :setup_repo,      [true, false], default: true
property :repo_url,        String, default: lazy { default_repo_url }
property :repo_key_url,    String, default: lazy { default_repo_key_url }
property :version,         String, default: '1.17.0'
property :package_name,    String, default: 'kubelet'
property :package_version, String, default: lazy { get_package_version(version) }
property :package_options, String

action :create do
  if new_resource.setup_repo
    if platform_family?('rhel', 'fedora')
      yum_repository 'Kubernetes' do
        baseurl new_resource.repo_url
        gpgkey new_resource.repo_key_url.split(' ')
        description 'Kubernetes repository'
        gpgcheck true
        enabled true
      end
    elsif platform_family?('debian')
      apt_repository 'Kubernetes' do
        uri new_resource.repo_url
        arch 'amd64'
        components ['main']
        distribution 'kubernetes-xenial'
        key new_resource.repo_key_url
      end
    else
      log "Cannot setup the Kubernetes repo for platform #{node['platform']}. Skipping..." do
        level :warn
      end
    end
  end

  package new_resource.package_name do
    version new_resource.package_version
    options new_resource.package_options
    action :install
  end
end

def default_repo_url
  if platform_family?('rhel', 'fedora')
    'https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64'
  elsif platform_family?('debian')
    'http://apt.kubernetes.io/'
  end
end

def default_repo_key_url
  if platform_family?('rhel', 'fedora')
    'https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg'
  elsif platform_family?('debian')
    'https://packages.cloud.google.com/apt/doc/apt-key.gpg'
  end
end

def get_package_version(v)
  if platform_family?('rhel', 'fedora')
    v
  elsif platform_family?('debian')
    "#{v}-00"
  end
end
