# # encoding: utf-8

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/opt/bin/kubelet') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0755 }
end

describe command('/opt/bin/kubelet --version') do
  its('stdout') { should include 'Kubernetes v1.1' }
  its('exit_status') { should eq 0 }
end

describe directory('/opt/cni') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0755 }
end

describe directory('/etc/kubernetes') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0600 }
end

describe file('/etc/kubernetes/config.yaml') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0755 }
end

describe yaml('/etc/kubernetes/config.yaml') do
  its('kind') { should eq 'KubeletConfiguration' }
  its('apiVersion') { should eq 'kubelet.config.k8s.io/v1beta1' }
  its('address') { should eq '127.0.0.1' }
  its('port') { should eq 10250 }
  its('failSwapOn') { should eq false }
  its(%w(authentication anonymous enabled)) { should eq true }
  its(%w(authentication webhook enabled)) { should eq false }
  its(%w(authorization mode)) { should eq 'AlwaysAllow' }
end

describe systemd_service('kubelet') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

puts 'Sleeping to make sure the services are started'
sleep 10

describe port(10250) do
  it { should be_listening }
  its('processes') { should include 'kubelet' }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '127.0.0.1' }
end
