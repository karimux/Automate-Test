*** Settings ***

Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${CONNEXION} =    			./TestData/TC_001_Admin_Connection/connexion.csv
${DATAFILE} =    			./TestData/TC_002_Admin_Show_Users_List/customers.csv
${LA_DATA_FILE} =    			./TestData/TC_002_Admin_Show_Users_List/la_data.csv
${GLOBALFILE} =             ./TestData/general_admin.csv

*** Test Cases ***
TC 002 Admin Show Users List
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	# Log to console    ${general_data}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    # ${customers} =  Get Customer Code from data file  ${DATAFILE}
    Wait Until Loader Is Visible
    Goto Admin Menu    Users
    Sleep   4s
    Take Screenshot    users
    
    [Teardown]    Close Browser
