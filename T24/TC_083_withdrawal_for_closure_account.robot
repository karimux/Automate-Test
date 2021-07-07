*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_083_withdrawal_for_closure_account/connexion.csv
${DATAFILE} =    			./TestData/TC_083_withdrawal_for_closure_account/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 083 withdrawal for closure account
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    Choose Action  New Deal
    
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Commit the deal
    ${TT.AC.CLOSED} =   Get transactionId created
    Append to file    ${GLOBALFILE}    TT.AC.CLOSED;${TT.AC.CLOSED}\n  
    [Teardown]    Close Browser