#!/bin/bash
# properties of the deployit server
export FACTER_XLDEPLOY_REST_URL="${XLDEPLOY_REST_URL}"

# properties of the host
export FACTER_DEV_CLOUD_HOST_ID="Infrastructure/PIPELINE_DEMO/DEV/TOMCAT (VAGRANT+PUPPET)"
export FACTER_DEV_CLOUD_HOST_ADDRESS="192.168.1.50" # PROVIDED BY CLOUD PROVISIONER "IRL"
export FACTER_DEV_CLOUD_HOST_USERNAME="vagrant" # PROVIDED BY CLOUD PROVISIONER "IRL"
export FACTER_DEV_CLOUD_HOST_PASSWORD="vagrant" # PROVIDED BY CLOUD PROVISIONER "IRL"
export FACTER_DEV_CLOUD_HOST_SUDOUSERNAME="vagrant" # PROVIDED BY CLOUD PROVISIONER "IRL"

# properties of the tomcat server
export FACTER_DEV_CLOUD_TOMCAT_ID="Infrastructure/PIPELINE_DEMO/DEV/TOMCAT (VAGRANT+PUPPET)/tomcat-dev-cloud"
export FACTER_DEV_CLOUD_TOMCAT_STARTCOMMAND="/var/lib/tomcat7/bin/startup.sh"
export FACTER_DEV_CLOUD_TOMCAT_STOPCOMMAND="/var/lib/tomcat7/bin/shutdown.sh"
export FACTER_DEV_CLOUD_TOMCAT_HOME="/var/lib/tomcat7"

# properties of the tomcat virtual host
export FACTER_DEV_CLOUD_TOMCAT_VIRTUALHOST_ID="Infrastructure/PIPELINE_DEMO/DEV/TOMCAT (VAGRANT+PUPPET)/tomcat-dev-cloud/tomcat-dev-cloud-vh"

# properties of the test runners
export FACTER_DEV_CLOUD_TOMCAT_HTTP_TEST_ENV_ID="Infrastructure/PIPELINE_DEMO/DEV/TOMCAT (VAGRANT+PUPPET)/http-test-env"
export FACTER_DEV_CLOUD_TOMCAT_HTTP_TEST_ENV_TAG="TEST-ENV"
export FACTER_DEV_CLOUD_TOMCAT_HTTP_TEST_VERSION_ID="Infrastructure/PIPELINE_DEMO/DEV/TOMCAT (VAGRANT+PUPPET)/http-test-version"
export FACTER_DEV_CLOUD_TOMCAT_HTTP_TEST_VERSION_TAG="TEST-VERSION"

# properties of the dictionary
export FACTER_DEV_CLOUD_ENV_DICTIONARY_ID="Environments/POC/POC-PIPELINE-CD/DEV/dev.dico"
export FACTER_DEV_CLOUD_TEST_URL="http://192.168.1.50:8080/petclinic"
export FACTER_DEV_CLOUD_ENVIRONMENT="DEVELOPMENT"

# properties of the environment

# properties of the application
export FACTER_DEV_CLOUD_DEPLOYED_APPLICATION="CLOUD/SYSTEM/SERVER/APPLICATION PROVISIONING DONE." 
export FACTER_DEV_CLOUD_DEPLOYABLE_ID="Applications/PIPELINE_DEMO/petclinic/${PIPELINE_VERSION}"

# MAIN LOOP
mkdir -p ~/.puppet/modules
cp -rf ${PUPPET_XLDEPLOY_MODULE_HOME} ~/.puppet/modules/ 

facter >> /dev/null

echo "show modulepath content"
ls -lrt ~/.puppet/modules/xebialabs-xldeploy-1.2.4/lib/puppet_x/xebialabs/xldeploy/ci.rb

echo "puppet version used and modulepath"
puppet --version

#echo PUPPET_XLDEPLOY_MODULE_HOME : ${PUPPET_XLDEPLOY_MODULE_HOME}
echo "RUNNING puppet apply vagrant/puppet/xl-deploy-provin.pp --detailed-exitcodes"
puppet apply --modulepath=~/.puppet/modules vagrant/puppet/xl-deploy-provin.pp --detailed-exitcodes --debug
exit $?
