#
# Cookbook:: kubelet
# Library:: kubelet_parameters
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

module KubeletCookbook
  module KubeletParameters
    def self.included(base)
      base.class_eval do
        property :address, String, default: '0.0.0.0'
        property :allow_privileged, [TrueClass, FalseClass]
        property :allowed_unsafe_sysctls, String
        property :alsologtostderr, [TrueClass, FalseClass]
        property :anonymous_auth, [TrueClass, FalseClass]
        property :application_metrics_count_limit, Integer
        property :authentication_token_webhook, [TrueClass, FalseClass]
        property :authentication_token_webhook_cache_ttl, String
        property :authorization_mode, String
        property :authorization_webhook_cache_authorized_ttl, String
        property :authorization_webhook_cache_unauthorized_ttl, String
        property :azure_container_registry_config, String
        property :boot_id_file, String
        property :bootstrap_checkpoint_path, String
        property :bootstrap_kubeconfig, String
        property :cadvisor_port, Integer
        property :cert_dir, String
        property :cgroup_driver, String
        property :cgroup_root, String
        property :cgroups_per_qos, [TrueClass, FalseClass]
        property :chaos_chance, Float
        property :client_ca_file, String
        property :cloud_config, String
        property :cloud_provider, String
        property :cluster_dns, String
        property :cluster_domain, String
        property :cni_bin_dir, String, default: '/opt/cni'
        property :cni_conf_dir, String
        property :config, String, default: lazy { "#{config_dir}/config.yaml" }
        property :container_hints, String
        property :container_log_max_files, Integer
        property :container_log_max_size, String
        property :container_runtime, String
        property :container_runtime_endpoint, String
        property :containerd, String
        property :containerized, [TrueClass, FalseClass]
        property :contention_profiling, [TrueClass, FalseClass]
        property :cpu_cfs_quota, [TrueClass, FalseClass]
        property :cpu_cfs_quota_period, String
        property :cpu_manager_policy, String
        property :cpu_manager_reconcile_period, String
        property :docker, String
        property :docker_disable_shared_pid, [TrueClass, FalseClass]
        property :docker_endpoint, String
        property :docker_env_metadata_whitelist, String
        property :docker_only, [TrueClass, FalseClass]
        property :docker_root, String
        property :docker_tls, [TrueClass, FalseClass]
        property :docker_tls_ca, String
        property :docker_tls_cert, String
        property :docker_tls_key, String
        property :dynamic_config_dir, String
        property :enable_controller_attach_detach, [TrueClass, FalseClass]
        property :enable_debugging_handlers, [TrueClass, FalseClass]
        property :enable_load_reader, [TrueClass, FalseClass]
        property :enable_server, [TrueClass, FalseClass]
        property :enforce_node_allocatable, String
        property :event_burst, Integer
        property :event_qps, Integer
        property :event_storage_age_limit, String
        property :event_storage_event_limit, String
        property :eviction_hard, String
        property :eviction_max_pod_grace_period, Integer
        property :eviction_minimum_reclaim, String
        property :eviction_pressure_transition_period, String
        property :eviction_soft, String
        property :eviction_soft_grace_period, String
        property :exit_on_lock_contention, [TrueClass, FalseClass]
        property :experimental_allocatable_ignore_eviction, [TrueClass, FalseClass]
        property :experimental_allowed_unsafe_sysctls, String
        property :experimental_check_node_capabilities_before_mount, [TrueClass, FalseClass]
        property :experimental_kernel_memcg_notification, [TrueClass, FalseClass]
        property :experimental_mounter_path, String
        property :fail_swap_on, [TrueClass, FalseClass]
        property :feature_gates, Hash
        property :file_check_frequency, String
        property :global_housekeeping_interval, String
        property :hairpin_mode, String
        property :healthz_bind_address, String
        property :healthz_port, Integer
        property :host_ipc_sources, String
        property :host_network_sources, String
        property :host_pid_sources, String
        property :hostname_override, String
        property :housekeeping_interval, String
        property :http_check_frequency, String
        property :image_gc_high_threshold, Integer
        property :image_gc_low_threshold, Integer
        property :image_pull_progress_deadline, String
        property :image_service_endpoint, String
        property :iptables_drop_bit, Integer
        property :iptables_masquerade_bit, Integer
        property :keep_terminated_pod_volumes, [TrueClass, FalseClass]
        property :kube_api_burst, Integer
        property :kube_api_content_type, String
        property :kube_api_qps, Integer
        property :kube_reserved, String
        property :kube_reserved_cgroup, String
        property :kubeconfig, String
        property :kubelet_cgroups, String
        property :lock_file, String
        property :log_backtrace_at, String
        property :log_cadvisor_usage, [TrueClass, FalseClass]
        property :log_dir, String
        property :log_flush_frequency, String
        property :logtostderr, [TrueClass, FalseClass]
        property :machine_id_file, String
        property :make_iptables_util_chains, [TrueClass, FalseClass]
        property :manifest_url, String
        property :manifest_url_header, String
        property :master_service_namespace, String
        property :max_open_files, Integer
        property :max_pods, Integer
        property :maximum_dead_containers, String
        property :maximum_dead_containers_per_container, String
        property :minimum_container_ttl_duration, String
        property :minimum_image_ttl_duration, String
        property :network_plugin, String
        property :network_plugin_mtu, Integer
        property :node_ip, String
        property :node_labels, String
        property :node_status_max_images, String
        property :node_status_update_frequency, String
        property :non_masquerade_cidr, String
        property :oom_score_adj, Integer
        property :pod_cidr, String
        property :pod_infra_container_image, String
        property :pod_manifest_path, String, default: lazy { "#{config_dir}/manifests" }
        property :pod_max_pids, Integer
        property :pods_per_core, Integer
        property :port, Integer, default: 10250
        property :protect_kernel_defaults, [TrueClass, FalseClass]
        property :provider_id, String
        property :qos_reserved, String
        property :read_only_port, Integer
        property :really_crash_for_testing, [TrueClass, FalseClass]
        property :redirect_container_streaming, [TrueClass, FalseClass]
        property :register_node, [TrueClass, FalseClass]
        property :register_schedulable, [TrueClass, FalseClass]
        property :register_with_taints, String
        property :registry_burst, Integer
        property :registry_qps, Integer
        property :resolv_conf, String
        property :root_dir, String
        property :rotate_certificates, [TrueClass, FalseClass]
        property :rotate_server_certificates, [TrueClass, FalseClass]
        property :runonce, [TrueClass, FalseClass]
        property :runtime_cgroups, String
        property :runtime_request_timeout, String
        property :seccomp_profile_root, String
        property :serialize_image_pulls, [TrueClass, FalseClass]
        property :stderrthreshold, Integer
        property :storage_driver_buffer_duration, String
        property :storage_driver_db, String
        property :storage_driver_host, String
        property :storage_driver_password, String
        property :storage_driver_secure, [TrueClass, FalseClass]
        property :storage_driver_table, String
        property :storage_driver_user, String
        property :streaming_connection_idle_timeout, String
        property :sync_frequency, String
        property :system_cgroups, String
        property :system_reserved, String
        property :system_reserved_cgroup, String
        property :tls_cert_file, String
        property :tls_cipher_suites, String
        property :tls_min_version, String
        property :tls_private_key_file, String
        property :v, Integer
        property :vmodule, String
        property :volume_plugin_dir, String
        property :volume_stats_agg_period, String
      end
    end
  end
end
