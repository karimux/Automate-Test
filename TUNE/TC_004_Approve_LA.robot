*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${DATAFILE} =    			./TestData/TC_004_Approve_LA/customers.csv
${CONNEXION} =    			./TestData/TC_004_Approve_LA/connexion.csv
${LA_DATA_FILE} =    			./TestData/TC_004_Approve_LA/la_data.csv
${GLOBALFILE} =             ./TestData/general.csv

*** Test Cases ***
TC 004 Approve LA
    #[Setup]
    ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	${la_data} =   Get LA Data  ${LA_DATA_FILE}
    ${IDs} =  Read general file and prepare loans to assign  ${GLOBALFILE}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    Goto Menu    Demandes
    Goto LAs in comite
    Log to console  ${IDs}
     FOR    ${ID}    IN    @{IDs}
        Approve LA  ${ID}  ${la_data}[0]  ${la_data}[1]  ${la_data}[2]
    
    END
    
    [Teardown]    Close Browser