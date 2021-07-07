*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_073_generate_collateral_ownership/connexion.csv
${DATAFILE} =    			./TestData/TC_073_generate_collateral_ownership/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 073 generate collateral ownership
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${COL.OWNER} =    Select data in Global File    ${GLOBALFILE}    COL.OWNER
	Choose Action with Input    ${COL.OWNER}    Edit a contract
    
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Commit the deal
    ${COL.RIGHT.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    COL.RIGHT.ID;${COL.RIGHT.ID}\n  
    [Teardown]    Close Browser