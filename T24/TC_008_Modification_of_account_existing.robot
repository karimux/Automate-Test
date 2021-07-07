*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_008_Modification_of_account_existing/connexion.csv
${DATAFILE} =    			./TestData/TC_008_Modification_of_account_existing/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 008 Modification of account existing
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
    ${GEN.ACCOUNT.NO} =    Select data in Global File    ${GLOBALFILE}    GEN.ACCOUNT.NO
    Choose Action with Input    ${GEN.ACCOUNT.NO}    Edit a contract
    
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal
    
	Take Screenshot    modification

    Choose Action  Commit the deal
    [Teardown]    Close Browser