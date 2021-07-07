*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${CONNEXION} =    			./TestData/TC_002_Assign_Loan/connexion.csv
${GLOBALFILE} =             ./TestData/general.csv

*** Test Cases ***
TC 002 Assign Loan
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	# Log to console    ${general_data}
    ${IDs} =  Read general file and prepare loans to assign  ${GLOBALFILE}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    Goto Menu    Demandes
    Goto LAs to assign
    Log to console  ${IDs}
     FOR    ${ID}    IN    @{IDs}
         Assign LA to GP  ${ID}
    
    END
    
    [Teardown]    Close Browser