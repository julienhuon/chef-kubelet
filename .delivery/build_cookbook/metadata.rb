name 'build_cookbook'
maintainer 'Julien Huon'
maintainer_email 'julien@huon.email'
license 'apachev2'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'delivery-truck'
