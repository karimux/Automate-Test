*** Settings ***

Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${DATAFILE} =    			./TestData/TC_004_Admin_Create_New_Role/data.csv
${CONNEXION} =    			./TestData/TC_004_Admin_Create_New_Role/connexion.csv
${GLOBALFILE} =             ./TestData/general_admin.csv

*** Test Cases ***
TC 004 Admin Create New Role
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	# Log to console    ${general_data}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    # ${customers} =  Get Customer Code from data file  ${DATAFILE}
    Goto Admin Menu    Roles

    Click Create Button    Create Role
    Fill Role Creation Form    ${DATAFILE}
    #Append to file    ${GLOBALFILE}    ROLE.NAME;${LAB.ID}\n
    
    [Teardown]    Close Browser