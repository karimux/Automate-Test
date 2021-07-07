*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***

${DATAFILE} =    			./TestData/TC_003_Evaluate_LA/customers.csv
${CONNEXION} =    			./TestData/TC_003_Evaluate_LA/connexion.csv
${GLOBALFILE} =             ./TestData/general.csv

*** Test Cases ***
TC 003 Evaluate LA
    #[Setup]
     ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	# Log to console    ${general_data}
    ${IDs} =  Read general file and prepare loans to assign  ${GLOBALFILE}
    Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    # ${customers} =  Get Customer Code from data file  ${DATAFILE}
    Goto Menu    Demandes
    Goto LAs to evaluate
    Log to console  ${IDs}
     FOR    ${ID}    IN    @{IDs}
        Evaluate LA  ${ID}
    
    END
    
    [Teardown]    Close Browser