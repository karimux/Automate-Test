*** Settings ***
Documentation       TC 037 authorisation ALIP
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_037_authorisation_ALIP/connexion.csv
${DATAFILE} =    			./TestData/TC_037_authorisation_ALIP/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 037 authorisation ALIP
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?324
    Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1    30s
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser le deblocage")]
    Click Element    xpath: //*[contains(text(), "Autoriser le deblocage")]
    
    Choose Action    Authorises a deal
    Choose Action    Authorises a deal

    [Teardown]    Close Browser
