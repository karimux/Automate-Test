*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_052_Authorise_PD_Capture/connexion.csv
${DATAFILE} =    			./TestData/TC_052_Authorise_PD_Capture/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 052 Authorise PD Capture
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?PD.MENU
    Goto Menu    ${credentials}[4]
    ${PD.CAP} =    Select data in Global File    ${GLOBALFILE}    PD.CAP
	Choose Action with Input    ${PD.CAP}    Perform an action on the contract
	Maximize Browser Window
    Take Screenshot    AUTH_PD_CAP_${PD.CAP}
	Choose Action  Authorises a deal

    [Teardown]    Close Browser
