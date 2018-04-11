name 'elk'
maintainer 'Shan'
maintainer_email 'shanmugakarna89@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures elk'
long_description 'Installs/Configures elk'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/elk/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/elk'

depends 'java', '~> 1.50.0'
depends 'apt', '= 5.1.0'
depends 'ark', '= 2.2.1'
depends 'homebrew', '= 3.0.0'
depends 'windows', '= 2.1.1'
depends 'chef_handler', '= 2.1.2'
depends 'compat_resource', '~> 12.19.0'
depends 'chef-sugar', '= 3.6.0'
depends 'ohai', '= 4.2.3'
depends 'git', '= 5.0.2'
depends 'mingw', '= 1.2.5'
depends 'build-essential', '= 7.0.3'
depends 'dmg', '= 3.1.1'
depends 'yum', '= 4.2.0'
depends 'yum-epel', '~> 2.1.1'
depends 'limits', '~> 1.0.0'
