#
# Cookbook:: kubelet
# Library:: helpers
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

def kubelet_cmd
  [new_resource.kubelet_bin, kubelet_flags].join(' ').strip
end

def kubelet_flags
  flags = []

  # kubelet flags (see https://github.com/kubernetes/kubernetes/blob/v1.11.3/cmd/kubelet/app/options/options.go#L333)
  flags << "--kubeconfig=#{new_resource.kubeconfig}" unless new_resource.kubeconfig.nil?
  flags << "--bootstrap-kubeconfig=#{new_resource.bootstrap_kubeconfig}" unless new_resource.bootstrap_kubeconfig.nil?
  flags << "--chaos-chance=#{new_resource.chaos_chance}" unless new_resource.chaos_chance.nil?
  flags << "--really-crash-for-testing=#{new_resource.really_crash_for_testing}" unless new_resource.really_crash_for_testing.nil?
  flags << "--runonce=#{new_resource.runonce}" unless new_resource.runonce.nil?
  flags << "--enable-server=#{new_resource.enable_server}" unless new_resource.enable_server.nil?
  flags << "--hostname-override=#{new_resource.hostname_override}" unless new_resource.hostname_override.nil?
  flags << "--node-ip=#{new_resource.node_ip}" unless new_resource.node_ip.nil?
  flags << "--provider-id=#{new_resource.provider_id}" unless new_resource.provider_id.nil?
  flags << "--cert-dir=#{new_resource.cert_dir}" unless new_resource.cert_dir.nil?
  flags << "--cloud-provider=#{new_resource.cloud_provider}" unless new_resource.cloud_provider.nil?
  flags << "--cloud-config=#{new_resource.cloud_config}" unless new_resource.cloud_config.nil?
  flags << "--root-dir=#{new_resource.root_dir}" unless new_resource.root_dir.nil?
  flags << "--dynamic-config-dir=#{new_resource.dynamic_config_dir}" unless new_resource.dynamic_config_dir.nil?
  flags << "--config=#{new_resource.config}" unless new_resource.config.nil?
  flags << "--register-node=#{new_resource.register_node}" unless new_resource.register_node.nil?
  flags << "--register-with-taint=#{new_resource.register_with_taints}" unless new_resource.register_with_taints.nil?
  flags << "--cadvisor-port=#{new_resource.cadvisor_port}" unless new_resource.cadvisor_port.nil?
  flags << "--allowed-unsafe-sysctls=#{new_resource.allowed_unsafe_sysctls}" unless new_resource.allowed_unsafe_sysctls.nil?
  flags << "--experimental-allowed-unsafe-sysctls=#{new_resource.experimental_allowed_unsafe_sysctls}" unless new_resource.experimental_allowed_unsafe_sysctls.nil?
  flags << "--containerized=#{new_resource.containerized}" unless new_resource.containerized.nil?
  flags << "--container-runtime-endpoint=#{new_resource.container_runtime_endpoint}" unless new_resource.container_runtime_endpoint.nil?
  flags << "--image-service-endpoint=#{new_resource.image_service_endpoint}" unless new_resource.image_service_endpoint.nil?
  flags << "--experimental-mounter-path=#{new_resource.experimental_mounter_path}" unless new_resource.experimental_mounter_path.nil?
  flags << "--experimental-kernel-memcg-notification=#{new_resource.experimental_kernel_memcg_notification}" unless new_resource.experimental_kernel_memcg_notification.nil?
  flags << "--experimental-check-node-capabilities-before-mount=#{new_resource.experimental_check_node_capabilities_before_mount}" unless new_resource.experimental_check_node_capabilities_before_mount.nil?
  flags << "--experimental-allocatable-ignore-eviction=#{new_resource.experimental_allocatable_ignore_eviction}" unless new_resource.experimental_allocatable_ignore_eviction.nil?
  flags << "--node-labels=#{new_resource.node_labels}" unless new_resource.node_labels.nil?
  flags << "--volume-plugin-dir=#{new_resource.volume_plugin_dir}" unless new_resource.volume_plugin_dir.nil?
  flags << "--lock-file=#{new_resource.lock_file}" unless new_resource.lock_file.nil?
  flags << "--exit-on-lock-contention=#{new_resource.exit_on_lock_contention}" unless new_resource.exit_on_lock_contention.nil?
  flags << "--seccomp-profile-root=#{new_resource.seccomp_profile_root}" unless new_resource.seccomp_profile_root.nil?
  flags << "--bootstrap-checkpoint-path=#{new_resource.bootstrap_checkpoint_path}" unless new_resource.bootstrap_checkpoint_path.nil?
  flags << "--node-status-max-images=#{new_resource.node_status_max_images}" unless new_resource.node_status_max_images.nil?
  flags << "--minimum-container-ttl-duration=#{new_resource.minimum_container_ttl_duration}" unless new_resource.minimum_container_ttl_duration.nil?
  flags << "--maximum-dead-containers-per-container=#{new_resource.maximum_dead_containers_per_container}" unless new_resource.maximum_dead_containers_per_container.nil?
  flags << "--maximum-dead-containers=#{new_resource.maximum_dead_containers}" unless new_resource.maximum_dead_containers.nil?
  flags << "--master-service-namespace=#{new_resource.master_service_namespace}" unless new_resource.master_service_namespace.nil?
  flags << "--register-schedulable=#{new_resource.register_schedulable}" unless new_resource.register_schedulable.nil?
  flags << "--non-masquerade-cidr=#{new_resource.non_masquerade_cidr}" unless new_resource.non_masquerade_cidr.nil?
  flags << "--keep-terminated-pod-volumes=#{keep_terminated_pod_volumes}" unless new_resource.keep_terminated_pod_volumes.nil?
  flags << "--allow-privileged=#{new_resource.allow_privileged}" unless new_resource.allow_privileged.nil?
  flags << "--host-network-sources=#{new_resource.host_network_sources}" unless new_resource.host_network_sources.nil?
  flags << "--host-pid-sources=#{new_resource.host_pid_sources}" unless new_resource.host_pid_sources.nil?
  flags << "--host-ipc-sources=#{new_resource.host_ipc_sources}" unless new_resource.host_ipc_sources.nil?

  # cadvisor flags (see https://github.com/kubernetes/kubernetes/blob/v1.11.3/cmd/kubelet/app/options/globalflags_linux.go)
  flags << "--application-metrics-count-limit=#{new_resource.application_metrics_count_limit}" unless new_resource.application_metrics_count_limit.nil?
  flags << "--boot-id-file=#{new_resource.boot_id_file}" unless new_resource.boot_id_file.nil?
  flags << "--container-hints=#{new_resource.container_hints}" unless new_resource.container_hints.nil?
  flags << "--containerd=#{new_resource.containerd}" unless new_resource.containerd.nil?
  flags << "--docker-env-metadata-whitelist=#{new_resource.docker_env_metadata_whitelist}" unless new_resource.docker_env_metadata_whitelist.nil?
  flags << "--docker=#{new_resource.docker}" unless new_resource.docker.nil?
  flags << "--docker-only=#{new_resource.docker_only}" unless new_resource.docker_only.nil?
  flags << "--docker-tls=#{new_resource.docker_tls}" unless new_resource.docker_tls.nil?
  flags << "--docker-tls-ca=#{new_resource.docker_tls_ca}" unless new_resource.docker_tls_ca.nil?
  flags << "--docker-tls-cert=#{new_resource.docker_tls_cert}" unless new_resource.docker_tls_cert.nil?
  flags << "--docker-tls-key=#{new_resource.docker_tls_key}" unless new_resource.docker_tls_key.nil?
  flags << "--enable-load-reader=#{new_resource.enable_load_reader}" unless new_resource.enable_load_reader.nil?
  flags << "--event-storage-age-limit=#{new_resource.event_storage_age_limit}" unless new_resource.event_storage_age_limit.nil?
  flags << "--event-storage-event-limit=#{new_resource.event_storage_event_limit}" unless new_resource.event_storage_event_limit.nil?
  flags << "--global-housekeeping-internal=#{new_resource.global_housekeeping_interval}" unless new_resource.global_housekeeping_interval.nil?
  flags << "--log-cadvisor-usage=#{new_resource.log_cadvisor_usage}" unless new_resource.log_cadvisor_usage.nil?
  flags << "--machine-id-file=#{new_resource.machine_id_file}" unless new_resource.machine_id_file.nil?
  flags << "--storage-driver-user=#{new_resource.storage_driver_user}" unless new_resource.storage_driver_user.nil?
  flags << "--storage-driver-password#{new_resource.storage_driver_password}" unless new_resource.storage_driver_password.nil?
  flags << "--storage-driver-host#{new_resource.storage_driver_host}" unless new_resource.storage_driver_host.nil?
  flags << "--storage-driver-db#{new_resource.storage_driver_db}" unless new_resource.storage_driver_db.nil?
  flags << "--storage-driver-table#{new_resource.storage_driver_table}" unless new_resource.storage_driver_table.nil?
  flags << "--storage-driver-secure#{new_resource.storage_driver_secure}" unless new_resource.storage_driver_secure.nil?
  flags << "--storage-driver-buffer-duration#{new_resource.storage_driver_buffer_duration}" unless new_resource.storage_driver_buffer_duration.nil?
  flags << "--docker-root=#{new_resource.docker_root}" unless new_resource.docker_root.nil?
  flags << "--housekeeping-interval=#{new_resource.housekeeping_interval}" unless new_resource.housekeeping_interval.nil?

  # credential provider flags (see https://github.com/kubernetes/kubernetes/blob/v1.11.3/cmd/kubelet/app/options/globalflags.go#L88)
  flags << "--azure-container-registry-config=#{new_resource.azure_container_registry_config}" unless new_resource.azure_container_registry_config.nil?

  # container runtime flags (see https://github.com/kubernetes/kubernetes/blob/v1.11.3/pkg/kubelet/config/flags.go)
  flags << "--container-runtime=#{new_resource.container_runtime}" unless new_resource.container_runtime.nil?
  flags << "--runtime-cgroups#{new_resource.runtime_cgroups}" unless new_resource.runtime_cgroups.nil?
  flags << "--redirect-container-streaming=#{new_resource.redirect_container_streaming}" unless new_resource.redirect_container_streaming.nil?
  flags << "--docker-disable-shared-pid=#{new_resource.docker_disable_shared_pid}" unless new_resource.docker_disable_shared_pid.nil?
  flags << "--pod-infra-container-image=#{new_resource.pod_infra_container_image}" unless new_resource.pod_infra_container_image.nil?
  flags << "--docker-endpoint=#{new_resource.docker_endpoint}" unless new_resource.docker_endpoint.nil?
  flags << "--image-pull-progress-deadline=#{new_resource.image_pull_progress_deadline}" unless new_resource.image_pull_progress_deadline.nil?
  flags << "--network-plugin=#{new_resource.network_plugin}" unless new_resource.network_plugin.nil?
  flags << "--cni-conf-dir=#{new_resource.cni_conf_dir}" unless new_resource.cni_conf_dir.nil?
  flags << "--cni-bin-dir=#{new_resource.cni_bin_dir}" unless new_resource.cni_bin_dir.nil?
  flags << "--network-plugin-mtu=#{new_resource.network_plugin_mtu}" unless new_resource.network_plugin_mtu.nil?

  # global flags (see https://github.com/kubernetes/kubernetes/blob/v1.11.3/cmd/kubelet/app/options/globalflags.go)
  flags << "--logtostderr=#{new_resource.logtostderr}" unless new_resource.logtostderr.nil?
  flags << "--alsologtostderr=#{new_resource.alsologtostderr}" unless new_resource.alsologtostderr.nil?
  flags << "--v=#{new_resource.v}" unless new_resource.v.nil?
  flags << "--stderrthreshold=#{new_resource.stderrthreshold}" unless new_resource.stderrthreshold.nil?
  flags << "--vmodule=#{new_resource.vmodule}" unless new_resource.vmodule.nil?
  flags << "--log-backtrace-at=#{new_resource.log_backtrace_at}" unless new_resource.log_backtrace_at.nil?
  flags << "--log-dir=#{new_resource.log_dir}" unless new_resource.log_dir.nil?
  flags << "--log-flush-frequency=#{new_resource.log_flush_frequency}" unless new_resource.log_flush_frequency.nil?

  flags
end

def kubelet_conf_authentication
  authentication = {}
  unless new_resource.anonymous_auth.nil?
    authentication['anonymous'] = {}
    authentication['anonymous']['enabled'] = new_resource.anonymous_auth
  end

  unless new_resource.client_ca_file.nil?
    authentication['x509'] = {}
    authentication['x509']['clientCAFile'] = new_resource.client_ca_file
  end

  unless new_resource.authentication_token_webhook.nil? && new_resource.authentication_token_webhook_cache_ttl.nil?
    authentication['webhook'] = {}
    authentication['webhook']['enabled'] = new_resource.authentication_token_webhook unless new_resource.authentication_token_webhook.nil?
    authentication['webhook']['cacheTTL'] = new_resource.authentication_token_webhook_cache_ttl unless new_resource.authentication_token_webhook_cache_ttl.nil?
  end

  authentication
end

def kubelet_conf_authorization
  authorization = {}
  authorization['mode'] = new_resource.authorization_mode unless new_resource.authorization_mode.nil?

  unless new_resource.authorization_webhook_cache_authorized_ttl.nil? && new_resource.authorization_webhook_cache_unauthorized_ttl.nil?
    authorization['webhook']['cacheAuthorizedTTL'] = new_resource.authorization_webhook_cache_authorized_ttl unless new_resource.authorization_webhook_cache_authorized_ttl.nil?
    authorization['webhook']['cacheUnauthorizedTTL'] = new_resource.authorization_webhook_cache_unauthorized_ttl unless new_resource.authorization_webhook_cache_unauthorized_ttl.nil?
  end

  authorization
end
