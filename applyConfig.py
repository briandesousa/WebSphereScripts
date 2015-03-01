import sys
global AdminTask
global AdminConfig

# Overlay server configuration defined in the specified properties file
def applyConfigProperties():
    propertiesFileName = sys.argv[0]
    print "Overlaying server config defined in " + propertiesFileName + ", refer to " + propertiesFileName + ".report.txt for details"
    AdminTask.applyConfigProperties('-propertiesFileName ' + propertiesFileName + " -reportFileName " + propertiesFileName + ".report.txt -reportFilterMechanism Errors_And_Changes")
    AdminConfig.save();
    
applyConfigProperties()