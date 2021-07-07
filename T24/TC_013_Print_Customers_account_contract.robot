*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_013_Print_Customers_account_contract/connexion.csv
${DATAFILE} =    			./TestData/TC_013_Print_Customers_account_contract/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 013 Print Customers account contract
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
    ${GEN.ACCOUNT.NO} =    Select data in Global File    ${GLOBALFILE}    GEN.ACCOUNT.NO
    
    
    #Read File and Fill input    ${DATAFILE}
	Input T24 textfield    fieldName:ACCOUNT.ID       ${GEN.ACCOUNT.NO}
    
    Choose Action  Validate a deal

    Choose Action  Commit the deal
    [Teardown]    Close Browser