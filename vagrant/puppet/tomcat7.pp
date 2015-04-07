# Project: vagrantnode
# Author: S. Guclu
# description: main driver script for Puppet
# read more puppet syntax @ http://www.puppetcookbook.com/
#make sure the puppet is installed on the .box otherwise rest of the puppet provisioning will not function
group { "puppet":
ensure => "present",
}
 
File { owner => 0, group => 0, mode => 0644 }
file { '/etc/motd':
content => "FINAXYS ALM service center (generated by Puppet over Vagrant)\n"
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


# S. GUCLU : tweak used to disable authentication issues on sudo-managed deployments
class sudo-grant {
  exec { 'sudo grant for vagrant account on tomcat7 account':
     command => 'sudo echo "tomcat7 ALL=NOPASSWD:ALL" >> /etc/sudoers.d/vagrant',
     }
     
 
class system-update {
  exec { 'apt-get update':
    command => 'apt-get update',
  }
 
  $sysPackages = [ "build-essential" ]
  package { $sysPackages:
    ensure => "installed",
    require => Exec['apt-get update'],
    require => Exec['sudo grant for vagrant account on tomcat7 account'],
  }
}

class tomcat7 {
  package { "tomcat7":
    ensure => present,
    require => Class["system-update"],
  }
 
  service { "tomcat7":
    ensure => "running",
    require => Package["tomcat7"],
  }
 
}
 
include tomcat7
include system-update

# S. GUCLU : tweak used to generate missing links on Tomcat 7 for runtime
file { '/var/lib/tomcat7/bin':
   ensure => 'link',
   require => Package["tomcat7"],
   target => '/usr/share/tomcat7/bin',
}
file { '/var/lib/tomcat7/lib':
   ensure => 'link',
   require => Package["tomcat7"],
   target => '/usr/share/tomcat7/lib',
}

