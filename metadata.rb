name 'kubelet'
maintainer 'Julien Huon'
maintainer_email 'julien@huon.email'
license 'Apache-2.0'
description 'Installs/Configures kubelet'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
chef_version '>= 14.4.56' if respond_to?(:chef_version)

issues_url 'https://github.com/julienhuon/chef-kubelet/issues'
source_url 'https://github.com/julienhuon/chef-kubelet'

depends 'ark', '~> 4.0.0'
depends 'systemd', '~> 3.2.3'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'ubuntu'
