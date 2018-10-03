#
# Cookbook:: kubelet_test
# Attributes:: default
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

default['kubelet_test']['version'] = '1.11.3'
default['kubelet_test']['checksum'] = '7d0767b6efdc565075f0ba219653e8f6b037643ddee946e0d88cccb6714e8f8f'
default['kubelet_test']['kubelet_bin'] = '/usr/bin/kubelet'
