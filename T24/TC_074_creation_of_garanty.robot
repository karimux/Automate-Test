*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_074_creation_of_garanty/connexion.csv
${DATAFILE} =    			./TestData/TC_074_creation_of_garanty/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 074 creation of garanty
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${COL.ID.TO.CREATE} =    Select data in Global File    ${GLOBALFILE}    COL.ID.TO.CREATE
	Choose Action with Input    ${COL.ID.TO.CREATE}    Edit a contract
    
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Commit the deal
    ${COL.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    COL.ID;${COL.ID}\n  
    [Teardown]    Close Browser