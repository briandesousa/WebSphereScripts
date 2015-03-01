import sys
global AdminTask

# Extract an existing server's configuration in to the specified properties file
def extractConfigProperties():
    propertiesFileName = sys.argv[0]
    print "Extracting server configuration into " + propertiesFileName
    AdminTask.extractConfigProperties("-propertiesFileName " + propertiesFileName + " -options [[PortablePropertiesFile true]]")
    
extractConfigProperties()