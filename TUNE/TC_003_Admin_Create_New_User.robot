*** Settings ***

Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${DATAFILE} =    			./TestData/TC_003_Admin_Create_New_User/data.csv
${CONNEXION} =    			./TestData/TC_003_Admin_Create_New_User/connexion.csv
${LA_DATA_FILE} =    			./TestData/TC_003_Admin_Create_New_User/la_data.csv
${GLOBALFILE} =             ./TestData/general_admin.csv

*** Test Cases ***
TC 003 Admin Create New User
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	# Log to console    ${general_data}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    Wait Until Loader Is Visible
    Goto Admin Menu    Users

    Click Create Button    Create User
    Fill User Creation Form from data file    ${DATAFILE}
    
    [Teardown]    Close Browser