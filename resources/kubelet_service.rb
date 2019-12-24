#
# Cookbook:: kubelet
# Resource:: kubelet_service
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

resource_name :kubelet_service

include KubeletCookbook::KubeletParameters

property :kubelet_bin, String, default: '/usr/bin/kubelet'
property :config_dir,  String, default: '/etc/kubernetes'

default_action :create

action :create do
  # config_dir
  directory new_resource.config_dir do
    user 'root'
    group 'root'
    mode '0700'
  end

  # manifests dir
  directory new_resource.pod_manifest_path do
    user 'root'
    group 'root'
    mode '0755'
  end

  # config file
  template new_resource.config do
    source 'kubeletconfig_v1beta1.yaml.erb'
    cookbook 'kubelet'
    user 'root'
    group 'root'
    mode '0755'
    variables(
      address: new_resource.address,
      authentication: kubelet_conf_authentication,
      authorization: kubelet_conf_authorization,
      cgroup_driver: new_resource.cgroup_driver,
      cgroup_root: new_resource.cgroup_root,
      cgroups_per_qos: new_resource.cgroups_per_qos,
      cluster_dns: new_resource.cluster_dns,
      cluster_domain: new_resource.cluster_domain,
      container_log_max_files: new_resource.container_log_max_files,
      container_log_max_size: new_resource.container_log_max_size,
      contention_profiling: new_resource.contention_profiling,
      cpu_cfs_quota: new_resource.cpu_cfs_quota,
      cpu_cfs_quota_period: new_resource.cpu_cfs_quota_period,
      cpu_manager_policy: new_resource.cpu_manager_policy,
      cpu_manager_reconcile_period: new_resource.cpu_manager_reconcile_period,
      enable_controller_attach_detach: new_resource.enable_controller_attach_detach,
      enable_debugging_handlers: new_resource.enable_debugging_handlers,
      enforce_node_allocatable: new_resource.enforce_node_allocatable,
      event_burst: new_resource.event_burst,
      event_qps: new_resource.event_qps,
      eviction_hard: new_resource.eviction_hard,
      eviction_max_pod_grace_period: new_resource.eviction_max_pod_grace_period,
      eviction_minimum_reclaim: new_resource.eviction_minimum_reclaim,
      eviction_pressure_transition_period: new_resource.eviction_pressure_transition_period,
      eviction_soft_grace_period: new_resource.eviction_soft_grace_period,
      eviction_soft: new_resource.eviction_soft,
      fail_swap_on: new_resource.fail_swap_on,
      feature_gates: new_resource.feature_gates,
      file_check_frequency: new_resource.file_check_frequency,
      hairpin_mode: new_resource.hairpin_mode,
      healthz_bind_address: new_resource.healthz_bind_address,
      healthz_port: new_resource.healthz_port,
      http_check_frequency: new_resource.http_check_frequency,
      image_gc_high_threshold: new_resource.image_gc_high_threshold,
      image_gc_low_threshold: new_resource.image_gc_low_threshold,
      iptables_drop_bit: new_resource.iptables_drop_bit,
      iptables_masquerade_bit: new_resource.iptables_masquerade_bit,
      kube_api_burst: new_resource.kube_api_burst,
      kube_api_content_type: new_resource.kube_api_content_type,
      kube_api_qps: new_resource.kube_api_qps,
      kubelet_cgroups: new_resource.kubelet_cgroups,
      kube_reserved_cgroup: new_resource.kube_reserved_cgroup,
      kube_reserved: new_resource.kube_reserved,
      make_iptables_util_chains: new_resource.make_iptables_util_chains,
      manifest_url_header: new_resource.manifest_url_header,
      manifest_url: new_resource.manifest_url,
      max_open_files: new_resource.max_open_files,
      max_pods: new_resource.max_pods,
      minimum_image_ttl_duration: new_resource.minimum_image_ttl_duration,
      node_status_update_frequency: new_resource.node_status_update_frequency,
      oom_score_adj: new_resource.oom_score_adj,
      pod_cidr: new_resource.pod_cidr,
      pod_manifest_path: new_resource.pod_manifest_path,
      pod_max_pids: new_resource.pod_max_pids,
      pods_per_core: new_resource.pods_per_core,
      port: new_resource.port,
      protect_kernel_defaults: new_resource.protect_kernel_defaults,
      qos_reserved: new_resource.qos_reserved,
      read_only_port: new_resource.read_only_port,
      registry_burst: new_resource.registry_burst,
      registry_qps: new_resource.registry_qps,
      resolv_conf: new_resource.resolv_conf,
      rotate_certificates: new_resource.rotate_certificates,
      rotate_server_certificates: new_resource.rotate_server_certificates,
      runtime_request_timeout: new_resource.runtime_request_timeout,
      serialize_image_pulls: new_resource.serialize_image_pulls,
      streaming_connection_idle_timeout: new_resource.streaming_connection_idle_timeout,
      sync_frequency: new_resource.sync_frequency,
      system_cgroups: new_resource.system_cgroups,
      system_reserved_cgroup: new_resource.system_reserved_cgroup,
      tls_cert_file: new_resource.tls_cert_file,
      tls_cipher_suites: new_resource.tls_cipher_suites,
      tls_min_version: new_resource.tls_min_version,
      tls_private_key_file: new_resource.tls_private_key_file,
      volume_stats_agg_period: new_resource.volume_stats_agg_period
    )
  end

  # systemd service
  systemd_unit "#{new_resource.name}.service" do
    content(
      Unit: {
        Description: 'kubelet: The Kubernetes Node Agent',
        Documentation: 'http://kubernetes.io/docs/',
      },
      Service: {
        ExecStart: kubelet_cmd,
        RestartSec: '10',
        Restart: 'always',
        User: 'root',
      },
      Install: {
        WantedBy: 'multi-user.target',
      }
    )

    action [:create, :enable, :start]
  end
end
