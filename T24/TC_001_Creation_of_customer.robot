*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_001_Creation_of_customer/connexion.csv
${DATAFILE} =    			./TestData/TC_001_Creation_of_customer/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 001 Creation of Customer
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    Choose Action  New Deal
    Get transactionId to create
    Read File and Fill input    ${DATAFILE}
    Choose Action  Validate a deal
    Sleep    2s
    Choose Action  Commit the deal
    ${CUSTOMER.NO} =   Get transactionId created
    Append to file    ${GLOBALFILE}    CUSTOMER.NO;${CUSTOMER.NO}\n  
    [Teardown]    Close Browser