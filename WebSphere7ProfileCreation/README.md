# Overview 
The scripts and configuration files contained within this package can be used to create a WebSphere 7 application server profile.
  - These scripts enable a developer to create and start an application server in under 5 minutes.
  - Server configurations can be customized for a specific worksation by modifying the properties file.
  - The scripts were designed to run against WebSphere Application Server 7 but may also work with v8 or v8.5.

**Important:** There are certain server configuration settings that are workstation-specific. These settings must be modified prior to running these scripts to create a server profile. Refer to the section "Modifying Server Configuraitons for a Specific Machine".

# Package Contents 
This package contains the following files and folders:

CreateProfile.bat - batch script that can be used to create a server profile

ExtractProfileConfig.bat - batch script that can be used to extract configurations from an existing server profile

AppServer01Profile.zip - a sample server configuration archive file for a server profile named "AppServer01"

AppServer01Profile.props - a sample server configuration properties file for a server profile named "AppServer01"

AppServer01Ports.props - a sample ports configuration file for a server profile named "AppServer01"

applyConfig.py - Jython script for apply server configuration properties files to a server profile

extractConfig.py - Jython script for extracting server configuration properties files from an existing server profile


# Profile Creation Script 
A server profile is created, configured and started automatically using the CreateServerProfile.bat script on a Windows workstation. That batch script will do the following:

  1. Use IBM's manageprofiles command to automate the creation of the empty server profile
  2. Use IBM's restoreConfig command to restore the base set of configurations for the server from a ZIP file
  3. Use IBM's wsadmin command to invoke a Jython script that applies an additional "overlay" of configuration defined in a properties file to the server profile. 

# Configuration Extraction Script
The ExtractProfileConfig.bat script automates the process of extracting a configuration archive file and server configuration properties file using built-in IBM scripts and custom Jython scripts. The *backupConfig* script is used to create the server configuration archive. The *wsadmin* script is used to invoke a custom Jython script that contains calls to IBM's WebSphere APIs to generate a server configuration properties file. 

# Modifying Server Configurations for a Specific Machine
The properties files defined within AppServer01Profile.props can be modified manually prior to creating a server profile. There are a few key things that you should understand about these properties files:
  - configuration is organized in sections that contain titles describing the specific type configuration (see below for some example server configuraiton headings)
  - certain types of configuration sections may appear up to 3 times in the file if that configuration can be defined at different scopes on the server (cell, node and server)
  - common environment variables are included at the very end of the properties file, these must match the server profile for which this configuration is being applied to

Here are the section headings for some of the most common server configurations:

  - *WebSphere variables* are found under section headings containing *VariableMap*. Since these can be defined at all 3 scopes you will find up to 3 *VariableMap* sections in the properties file.
  - *JVM classpath* is found under the section heading *JVM Section*
  - *JVM custom properties* are found under the section heading *System Properties*. Since these are defined at the server scope only, the *System Properties* heading is found only once in the properties file.
  - *JAAS J2C authnentication aliases* are found under section headings containing *JAASAuthData*
  - *JMS connection factories* are found under section headings containing *MQConnectionFactory attributes*
  - *JMS queues* are found under section headings containing *MQQueue attributes*
  - *JDBC providers* are found under section headings containing *JDBCProvider attributes*
  - *JDBC data sources* are found under section headings containing *DataSource attributes*
  - *SSL configurations* are found under section headings containing *SSLConfig Section*
  - *Keystores* are found under section headings containing *KeyStore Section*

Here are the machine-specific properties that you will likely need to modify before running the script to create the profile:

  - The following WebSphere variables should be modified with valid local paths:
    - *USER_INSTALL_ROOT* - the path the server profile being configured (ex. C:/Program Files/IBM/SDP/runtimes/base_v7/profiles/C3Profile)
    - *WAS_INSTALL_ROOT* - the path to where WebSphere is installed on your machine (ex. C:/Program Files/IBM/SDP/runtimes/base_v7) 


# References
http://www-01.ibm.com/support/knowledgecenter/SSEQTP_7.0.0/com.ibm.websphere.base.doc/info/aes/ae/rxml_7propbasedconfig.html

ftp://ftp.software.ibm.com/software/iea/content/com.ibm.iea.was_v7/was/7.0/Administration/WASv7_PropertiesFileConfig.pdf

http://www-01.ibm.com/support/knowledgecenter/SS7JFU_8.5.5/com.ibm.websphere.express.doc/ae/rxml_manageprofiles.html

