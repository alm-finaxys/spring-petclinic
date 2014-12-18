# XL DEPLOY INFRA/DICTIONARY/ENVIRONMENT/APPLICATION PROVISIONING THROUGH PUPPET MODULE ON A PROVISIONED UNIX+TOMCAT7 VM 

# XL DEPLOY SERVER SETTINGS
deployit { 'deployit-pipeline-demo': 
  username => $username_deployit, 
  password => $password_deployit, 
  url => $url_deployit
} 

# INFRA SETTINGS
deployit_container { $dev_cloud_host_id :
  ensure => present, 
  type => 'overthere.SshHost', 
  properties => 
    { os => UNIX, 
	  address => $dev_cloud_host_address, 
	  username => $dev_cloud_host_username, 
	  password => $dev_cloud_host_password, 
	  connectionType => 'SUDO', 
	  sudoUsername => $dev_cloud_host_sudousername},
   server => Deployit['deployit-pipeline-demo'], 
} 

deployit_container { $dev_cloud_tomcat_id: 
  ensure => present,
  type => 'tomcat.Server',
  require => Deployit_container[$dev_cloud_host_id],
  properties => { 
    startCommand => $dev_cloud_tomcat_startcommand
	stopCommand => $dev_cloud_tomcat_stopcommand
	home => $dev_cloud_tomcat_home 
  server => Deployit['deployit-pipeline-demo'], 
} 

deployit_container { $dev_cloud_tomcat_virtualhost_id : 
  type => 'tomcat.VirtualHost', 
  require => Deployit_container[$dev_cloud_tomcat_id], 
  server => Deployit['deployit-pipeline-demo'], 
}
 
deployit_container { $dev_cloud_tomcat_http_test_env_id :
  type => 'tests2.TestRunner', 
  require => Deployit_container[ $dev_cloud_host_id ] ,
  properties => {
    deploymentGroup => 2
  }, 
  # TBC : HOW TO INCLUDE TAGS?
  server => Deployit['deployit-pipeline-demo'] 
  } 
  
deployit_container { $dev_cloud_tomcat_http_test_version_id :
  type => 'tests2.TestRunner', 
  require => Deployit_container[ $dev_cloud_host_id ] ,
  properties => {
    deploymentGroup => 3
  },
  # TBC : HOW TO INCLUDE TAGS?
  server => Deployit['deployit-pipeline-demo'] 
  }
  
# DICTIONARIES SETTINGS  
deployit_ dictionary { $dev_cloud_dictionary_id : 
  before => $dev_cloud_env_id,   
  entries => {
    'test.url' => $dev_cloud_test_url_id,
    'environment' => $dev_cloud_environment
    }
  server => Deployit['deployit-pipeline-demo'] 
}

# ENVIRONMENT SETTINGS
TBC
