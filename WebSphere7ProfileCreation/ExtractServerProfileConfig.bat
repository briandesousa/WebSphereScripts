@setlocal
@echo off

echo.
echo ---------------------------------------------------------------------------
echo This script will create an WebSphere 7 application server profile using
echo a server configuration archive and server configuration properties file as
echo inputs to configure the server. Before running the script, you must have 
echo WebSphere 7 installed on your machine. Also ensure that an 
echo AppServerConfig.props file has been provided/generated for the server 
echo profile you are restoring.
echo.
echo Press CTRL-C at any point to exit the program.
echo ---------------------------------------------------------------------------
echo.

@rem Prompt user for the name to be used when naming various components in the server profile.
set /p APP_PREFIX="1. Enter a prefix to be used to name your server profile and components within the profile (ex. AppServer01): "
echo.

@rem Prompt user to enter the path to their local WAS installation
set /p WAS_INSTALL_DIR="2. Enter the path to your WebSphere 7 installation (ex. C:\Program Files\IBM\SDP\runtimes\base_v7): "
echo.

@rem Set other variables
set PROFILE_NAME=%APP_PREFIX%Profile
set PROFILE_BIN_PATH=%WAS_INSTALL_DIR%\profiles\%PROFILE_NAME%\bin
set PATH=%PATH%;%WAS_INSTALL_DIR%\bin

@rem Create a server configuration archive
call %PROFILE_BIN_PATH%\backupConfig %PROFILE_NAME%.zip -profileName %PROFILE_NAME%

@rem Create a server configuration properties file
call %PROFILE_BIN_PATH%\wsadmin -lang jython -conntype NONE -f extractConfig.py %PROFILE_NAME%.props

@endlocal