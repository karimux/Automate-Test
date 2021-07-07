*** Settings ***

Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${DATAFILE} =    			./TestData/TC_005_Admin_Approve_New_Role/customers.csv
${CONNEXION} =    			./TestData/TC_005_Admin_Approve_New_Role/connexion.csv
${GLOBALFILE} =             ./TestData/general_admin.csv

*** Test Cases ***
TC 005 Admin Approve New Role
    #[Setup]
    ${general_data} =    Read Tune Connection Data    ${CONNEXION}
    ${roles} =   Read general file and prepare data to use  ${GLOBALFILE}    ROLE.NAME
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    Goto Admin Menu    Roles
    FOR    ${role}    IN    @{roles}
        Search Role By Name    ${role}
        Open Selected Role in the list    ${role}
        Make a Decision in Selected Role    Approve
		Click on Button by label    Confirm
		Wait Until Loader Is Visible
    END
    
    [Teardown]    Close Browser