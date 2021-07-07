*** Settings ***

Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${CONNEXION} =    			./TestData/TC_005_Disburse_LA/connexion.csv
${DATAFILE} =    			./TestData/TC_005_Disburse_LA/customers.csv
${LA_DATA_FILE} =    			./TestData/TC_005_Disburse_LA/la_data.csv
${GLOBALFILE} =             ./TestData/general.csv

*** Test Cases ***
TC 005 Disburse LA
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	${la_data} =   Get LA Data  ${LA_DATA_FILE}
    ${IDs} =  Read general file and prepare loans to assign  ${GLOBALFILE}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    Goto Menu    Demandes
    Goto Results tab
    Log to console  ${IDs}
     FOR    ${ID}    IN    @{IDs}
        Open LA to disburse  ${ID}
		Disburse LA
    END
    [Teardown]    Close Browser