*** Settings ***

Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${CONNEXION} =    			./TestData/TC_001_Admin_Connection/connexion.csv
${DATAFILE} =    			./TestData/TC_001_Admin_Connection/customers.csv
${LA_DATA_FILE} =    			./TestData/TC_001_Admin_Connection/la_data.csv
${GLOBALFILE} =             ./TestData/general_admin.csv

*** Test Cases ***
TC 001 Admin Connection
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	# Log to console    ${general_data}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    Sleep    2s
    
    [Teardown]    Close Browser