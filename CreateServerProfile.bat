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

@rem Ask user if they want to start the server after installation
choice /c yn /n /m "3. Do you want to start the server after the profile has been created? Select [y]es or [n]o: "
if ERRORLEVEL 1 set START_SERVER=true
if ERRORLEVEL 2 set START_SERVER=false 
echo.

@rem Set other variables
set PROFILE_NAME=%APP_PREFIX%Profile
set PROFILE_PATH=%WAS_INSTALL_DIR%\profiles\%PROFILE_NAME%
set PATH=%PATH%;%WAS_INSTALL_DIR%\bin
set CELL_NAME=%APP_PREFIX%Cell
set NODE_NAME=%APP_PREFIX%Node
set SERVER_NAME=%APP_PREFIX%

@rem Confirm inputs 
echo A server profile will be created using the following settings: 
echo  - profile name: %PROFILE_NAME%
echo  - profile path: %PROFILE_PATH%
echo  - cell name: %CELL_NAME%
echo  - node name: %NODE_NAME%
echo  - server name: %SERVER_NAME%
echo.
choice /c yn /n /m "4. Do you want to proceed? Select [y]es or [n]o: "
if ERRORLEVEL 2 echo. & pause

echo. 
echo The server profile is now being created...
echo. 

@rem Create server profile
call %WAS_INSTALL_DIR%\bin\manageprofiles -create -profileName %PROFILE_NAME% -templatePath default -profilePath "%PROFILE_PATH%" -enableAdminSecurity false -cellName %CELL_NAME% -nodeName %NODE_NAME% -serverName %SERVER_NAME% -portsFile %APP_PREFIX%Ports.props -applyPerfTuningSettings development -isDeveloperServer -omitAction defaultAppDeployAndConfig

@rem Restore server backup file
call %PROFILE_PATH%\bin\restoreConfig %PROFILE_NAME%.zip -force -profileName %PROFILE_NAME%

@rem Apply server configuration properties file
call %PROFILE_PATH%\bin\wsadmin -lang jython -conntype NONE -f applyConfig.py %PROFILE_NAME%.props

@rem Start server, output the URL of the server
if %START_SERVER% == true call "%PROFILE_PATH%\bin\startServer" %APP_PREFIX%

echo.
echo Server profile created successfully. 
echo Access the server's admin console at http://localhost:9060/ibm/console/login.doc (port will vary depending on the contenst of %APP_PREFIX%Ports.props).
echo.
pause

@endlocal