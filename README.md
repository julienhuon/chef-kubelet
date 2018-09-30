# Kubelet cookbook

[![Build Status](https://travis-ci.org/julienhuon/chef-kubelet.svg?branch=master)](https://travis-ci.org/julienhuon/chef-kubelet)

The Kubelet Cookbook is a library cookbook that provides custom resources for use in recipes.

## Scope

This cookbook is only concerned with the [Kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) node agent distributed in Kubernetes.

## Requirements

- Chef 14.4+
- Network accessible web server hosting the kubelet binary

## Platform Support

The following platforms have been tested with Test Kitchen. It will most likely work on other platforms as well

```
|---------------+--------+--------+
|               | 1.10.7 | 1.11.3 |
|---------------+--------+--------+
| centos-7      |   X    |   X    |
|---------------+--------+--------+
| debian-9      |   X    |   X    |
|---------------+--------+--------+
| fedora-28     |   X    |   X    |
|---------------+--------+--------+
| ubuntu-18.04  |   X    |   X    |
|---------------+--------+--------+
```

## Cookbook Dependencies

- [ark](https://supermarket.chef.io/cookbooks/ark)
- [systemd](https://supermarket.chef.io/cookbooks/systemd)

## Usage

- Add `depends 'kubelet'` to your cookbook's metadata.rb
- Use the resources shipped in cookbook in a recipe, the same way you'd use core Chef resources (file, template, directory, package, etc).

```ruby
kubelet_installation_binary 'default' do
  kubelet_version '1.11.3'
  kubelet_binary_checksum '7d0767b6efdc565075f0ba219653e8f6b037643ddee946e0d88cccb6714e8f8f'
  action :create
end

kubelet_service 'kubelet' do
  address '127.0.0.1'
  port 10250
  fail_swap_on false
  authorization_mode 'AlwaysAllow'
  anonymous_auth true
  authentication_token_webhook false
end
```

## Test Cookbooks as Examples

The cookbooks ran under test-kitchen make excellent usage examples.

The test recipes are found at:

```ruby
test/cookbooks/kubelet_test/
```

## Resources Overview

- `kubelet_installation_binary`: copies a pre-compiled kubelet binary onto disk
- `kubelet_installation_package`: installs kubelet with an yum/apt package
- `kubelet_service` : creates an kubelet instance with a systemd_service

## Resources Details

### kubelet_installation_binary

The `kubelet_installation_binary` resource copies the precompiled Go binaries (kubelet & cni) onto the disk.

#### Properties

Name                  | Type                                              | Description
--------------------- | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------
`kubelet_binary_url`        | String (Optional)     | URL where to fetch the kubelet binary _Default: https://storage.googleapis.com/kubernetes-release/release/v#{kubelet_version}/bin/linux/amd64/kubelet_
`kubelet_binary_checksum`   | String (Optional)     | SHA256 checksum of the fetched kubelet binary _Default: 7d0767b6efdc565075f0ba219653e8f6b037643ddee946e0d88cccb6714e8f8f_
`kubelet_version`           | String (Optional)     | Desired version of kubelet _Default: 1.11.3_
`kubelet_dir`               | String (Optional)     | Where the kubelet binary will be installed (will be created if it doesn't exists) _Default: /opt/bin_
`cni_tgz_url`               | String (Optional)     | URL where to fetch the cni tar.gz file _Default: https://github.com/containernetworking/plugins/releases/download/v#{cni_version}/cni-plugins-amd64-v#{cni_version}.tgz_
`cni_tgz_checksum`          | String (Optional)     | SHA256 checksum of the fetched cni tar.gz file _Default: f04339a21b8edf76d415e7f17b620e63b8f37a76b2f706671587ab6464411f2d_
`cni_version`               | String (Optional)     | Desired version of cni _Default: 0.6.0_
`cni_prefix_dir`            | String (Optional)     | Where to extract the cni tar.gz file

#### Example

In this example, kubelet 1.11.3 will be installed in `/opt/bin` and cni 0.6.0 in `/opt/cni`:

```ruby
kubelet_installation_binary 'default' do
  kubelet_binary_checksum '7d0767b6efdc565075f0ba219653e8f6b037643ddee946e0d88cccb6714e8f8f'
  kubelet_version '1.11.3'
  kubelet_dir '/opt/bin'
  cni_prefix_dir '/opt'
  cni_version '0.6.0'
  cni_tgz_checksum 'f04339a21b8edf76d415e7f17b620e63b8f37a76b2f706671587ab6464411f2d'
  action :create
end
```

### kubelet_installation_package

The `kubelet_installation_package` resource install kubelet with apt or yum package systems.

#### Properties

Name                  | Type                                              | Description
--------------------- | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------
`setup_repo`                | Boolean (Optional)    | Setup the kubelet repo. If you would like to manage the repo yourself so you can use an internal repo then set this to false _Default: true_
`repo_url`                  | String (Optional)     | Kubelet repo URL _Default https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64 (CentOS/Fedora) http://apt.kubernetes.io/ (Debian/Ubuntu)_
`repo_key_url`              | String (Optional)     | Kubelet repo Key URL _Default: https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg(CentOS/Fedora) https://packages.cloud.google.com/apt/doc/apt-key.gpg (Debian/Ubuntu)_
`version`                   | String (Optional)     | Desired version of kubelet _Default: 1.11.3_
`package_name`              | String (Optional)     | Kubelet package Name _Default: kubelet_
`package_options`           | String (Optional)     | Apt/Yum options _Default: nil_

#### Example

In this example, kubelet 1.10.7 will be installed:

```ruby
kubelet_installation_package 'default' do
  version '1.10.7'
  action :create
end
```

### kubelet_service

The `kubelet_service` resource create a kubelet instance (configuration & service) using the given kubelet binary path.

#### Properties

Name                  | Type                                              | Description
--------------------- | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------
`kubelet_bin`               | String (Optional)     | Path of the kubelet binary _Default: /usr/bin/kubelet_
`config_dir`                | String (Optional)     | Configuration directory to create _Default: /etc/kubernetes_

All the [Kubelet Configuration Flags](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) are also available :

- address, String, default: '0.0.0.0'
- allow_privileged, [TrueClass, FalseClass]
- allowed_unsafe_sysctls, String
- alsologtostderr, [TrueClass, FalseClass]
- anonymous_auth, [TrueClass, FalseClass]
- application_metrics_count_limit, Integer
- authentication_token_webhook, [TrueClass, FalseClass]
- authentication_token_webhook_cache_ttl, String
- authorization_mode, String
- authorization_webhook_cache_authorized_ttl, String
- authorization_webhook_cache_unauthorized_ttl, String
- azure_container_registry_config, String
- boot_id_file, String
- bootstrap_checkpoint_path, String
- bootstrap_kubeconfig, String
- cadvisor_port, Integer
- cert_dir, String
- cgroup_driver, String
- cgroup_root, String
- cgroups_per_qos, [TrueClass, FalseClass]
- chaos_chance, Float
- client_ca_file, String
- cloud_config, String
- cloud_provider, String
- cluster_dns, String
- cluster_domain, String
- cni_bin_dir, String, default: '/opt/cni'
- cni_conf_dir, String
- config, String, default: lazy { "#{config_dir}/config.yaml" }
- container_hints, String
- container_log_max_files, Integer
- container_log_max_size, String
- container_runtime, String
- container_runtime_endpoint, String
- containerd, String
- containerized, [TrueClass, FalseClass]
- contention_profiling, [TrueClass, FalseClass]
- cpu_cfs_quota, [TrueClass, FalseClass]
- cpu_manager_policy, String
- cpu_manager_reconcile_period, String
- docker, String
- docker_disable_shared_pid, [TrueClass, FalseClass]
- docker_endpoint, String
- docker_env_metadata_whitelist, String
- docker_only, [TrueClass, FalseClass]
- docker_root, String
- docker_tls, [TrueClass, FalseClass]
- docker_tls_ca, String
- docker_tls_cert, String
- docker_tls_key, String
- dynamic_config_dir, String
- enable_controller_attach_detach, [TrueClass, FalseClass]
- enable_debugging_handlers, [TrueClass, FalseClass]
- enable_load_reader, [TrueClass, FalseClass]
- enable_server, [TrueClass, FalseClass]
- enforce_node_allocatable, String
- event_burst, Integer
- event_qps, Integer
- event_storage_age_limit, String
- event_storage_event_limit, String
- eviction_hard, String
- eviction_max_pod_grace_period, Integer
- eviction_minimum_reclaim, String
- eviction_pressure_transition_period, String
- eviction_soft, String
- eviction_soft_grace_period, String
- exit_on_lock_contention, [TrueClass, FalseClass]
- experimental_allocatable_ignore_eviction, [TrueClass, FalseClass]
- experimental_allowed_unsafe_sysctls, String
- experimental_check_node_capabilities_before_mount, [TrueClass, FalseClass]
- experimental_kernel_memcg_notification, [TrueClass, FalseClass]
- experimental_mounter_path, String
- fail_swap_on, [TrueClass, FalseClass]
- feature_gates, Hash
- file_check_frequency, String
- global_housekeeping_interval, String
- hairpin_mode, String
- healthz_bind_address, String
- healthz_port, Integer
- host_ipc_sources, String
- host_network_sources, String
- host_pid_sources, String
- hostname_override, String
- housekeeping_interval, String
- http_check_frequency, String
- image_gc_high_threshold, Integer
- image_gc_low_threshold, Integer
- image_pull_progress_deadline, String
- image_service_endpoint, String
- iptables_drop_bit, Integer
- iptables_masquerade_bit, Integer
- keep_terminated_pod_volumes, [TrueClass, FalseClass]
- kube_api_burst, Integer
- kube_api_content_type, String
- kube_api_qps, Integer
- kube_reserved, String
- kube_reserved_cgroup, String
- kubeconfig, String
- kubelet_cgroups, String
- lock_file, String
- log_backtrace_at, String
- log_cadvisor_usage, [TrueClass, FalseClass]
- log_cadvisor_usage, [TrueClass, FalseClass]
- log_dir, String
- log_flush_frequency, String
- logtostderr, [TrueClass, FalseClass]
- machine_id_file, String
- make_iptables_util_chains, [TrueClass, FalseClass]
- manifest_url, String
- manifest_url_header, String
- master_service_namespace, String
- max_open_files, Integer
- max_pods, Integer
- maximum_dead_containers, String
- maximum_dead_containers_per_container, String
- minimum_container_ttl_duration, String
- minimum_image_ttl_duration, String
- network_plugin, String
- network_plugin_mtu, Integer
- node_ip, String
- node_labels, String
- node_status_max_images, String
- node_status_update_frequency, String
- non_masquerade_cidr, String
- oom_score_adj, Integer
- pod_cidr, String
- pod_infra_container_image, String
- pod_manifest_path, String, default: lazy { "#{config_dir}/manifests" }
- pod_max_pids, Integer
- pods_per_core, Integer
- port, Integer, default: 10250
- protect_kernel_defaults, [TrueClass, FalseClass]
- provider_id, String
- qos_reserved, String
- read_only_port, Integer
- really_crash_for_testing, [TrueClass, FalseClass]
- redirect_container_streaming, [TrueClass, FalseClass]
- register_node, [TrueClass, FalseClass]
- register_schedulable, [TrueClass, FalseClass]
- register_with_taints, String
- registry_burst, Integer
- registry_qps, Integer
- resolv_conf, String
- root_dir, String
- rotate_certificates, [TrueClass, FalseClass]
- rotate_server_certificates, [TrueClass, FalseClass]
- runonce, [TrueClass, FalseClass]
- runtime_cgroups, String
- runtime_request_timeout, String
- seccomp_profile_root, String
- serialize_image_pulls, [TrueClass, FalseClass]
- stderrthreshold, Integer
- storage_driver_buffer_duration, String
- storage_driver_db, String
- storage_driver_host, String
- storage_driver_password, String
- storage_driver_secure, [TrueClass, FalseClass]
- storage_driver_table, String
- storage_driver_user, String
- streaming_connection_idle_timeout, String
- sync_frequency, String
- system_cgroups, String
- system_reserved, String
- system_reserved_cgroup, String
- tls_cert_file, String
- tls_cipher_suites, String
- tls_min_version, String
- tls_private_key_file, String
- v, Integer
- vmodule, String
- volume_plugin_dir, String
- volume_stats_agg_period, String

#### Example

In this example, a standalone instance of kubelet will be created.

```ruby
kubelet_installation_package 'default' do
  address '127.0.0.1'
  port 10250
  fail_swap_on false
  authorization_mode 'AlwaysAllow'
  anonymous_auth true
  authentication_token_webhook false
  action :create
end
```

A `/etc/kubernetes` directory will be created with a kubelet config file in it. A systemd service will also be created.

## Maintainers

- [Julien Huon](https://github.com/julienhuon)

## License

**Copyright** | 2018, Julien Huon

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
