*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_038_DELETE_a_alip_created_and_waiting_authorisation/connexion.csv
${DATAFILE} =    			./TestData/TC_038_DELETE_a_alip_created_and_waiting_authorisation/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 038 DELETE a alip created and waiting authorisation
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?324
    Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Annuler le deblocage credit")]    120s
    Click Element    xpath: //*[contains(text(), "Annuler le deblocage credit")]
	
    Maximize Browser Window
	Take Screenshot    cancel_alip
	
	Choose Action    Deletes a Deal
	
	Sleep    1s
	Handle Alert    ACCEPT
	Wait Until T24 Processing Is Visible

    [Teardown]    Close Browser
