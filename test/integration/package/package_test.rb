# # encoding: utf-8

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os.family == 'rhel' || os.family == 'fedora'
  describe yum.repo('Kubernetes') do
    it { should exist }
    it { should be_enabled }
    its('baseurl') { should include 'https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64' }
  end
elsif os.family == 'debian'
  describe apt('http://apt.kubernetes.io/') do
    it { should exist }
    it { should be_enabled }
  end
end

describe package('kubelet') do
  it { should be_installed }
  its('version') { should cmp >= '1.10' }
end

describe directory('/etc/kubernetes') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0700 }
end

describe directory('/etc/kubernetes/manifests') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0755 }
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
