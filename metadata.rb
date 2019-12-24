name 'kubelet'
maintainer 'Julien Huon'
maintainer_email 'julien@huon.email'
license 'Apache-2.0'
description 'Installs/Configures kubelet'
version '0.3.0'
chef_version '>= 14.4.56'

issues_url 'https://github.com/julienhuon/chef-kubelet/issues'
source_url 'https://github.com/julienhuon/chef-kubelet'

depends 'ark', '~> 4.0.0'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'ubuntu'
