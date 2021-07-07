*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_005_Generation_account_number/connexion.csv
${DATAFILE} =    			./TestData/TC_005_Generation_account_number/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 005 Generation account number
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
    ${CUSTOMER.NO} =    Select data in Global File    ${GLOBALFILE}    CUSTOMER.NO
    Wait Until Element Is Visible    fieldName:CUSTOMER.NO
    Input T24 textfield  fieldName:CUSTOMER.NO  ${CUSTOMER.NO}
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal

    #Copier le numéro de compte   from textfield fieldName:GEN.ACCOUNT.NO
    Wait Until Element Is Visible    id:fieldName:GEN.ACCOUNT.NO
    ${GEN.ACCOUNT.NO} =     Get Element Attribute    fieldName:GEN.ACCOUNT.NO    value
    Log to console    account gen : ${GEN.ACCOUNT.NO}

    Append to file    ${GLOBALFILE}    GEN.ACCOUNT.NO;${GEN.ACCOUNT.NO}\n
    Choose Action  Commit the deal
    [Teardown]    Close Browser