*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_086_Delete_VIP_card/connexion.csv
${DATAFILE} =    			./TestData/TC_086_Delete_VIP_card/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 086 Delete VIP card
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${DAT.MODIF} =    Select data in Global File    ${GLOBALFILE}    VIP.ACCOUNT
	Choose Action with Input    ${DAT.MODIF}    Edit a contract
   
    Read File and Fill input    ${DATAFILE}
    
	Take Screenshot    DEL_VIP_${DAT.MODIF}
    Choose Action  Commit the deal
    
    [Teardown]    Close Browser