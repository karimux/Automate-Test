*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_058_PD_Authorise_written_off_loan/connexion.csv
${DATAFILE} =    			./TestData/TC_058_PD_Authorise_written_off_loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 058 2 PD Cancel Authorise written off loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ENQ MCR.AUTH.PD.WOF
    Tap on command line    ?3
    Goto Menu    ${credentials}[4]
    Clear Filter
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Rejeter les retards rayes")]
    Click Element    xpath: //*[contains(text(), "Rejeter les retards rayes")]
	
    Maximize Browser Window
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span    10s
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    reject_PD_auth_WOF
	Choose Action    Deletes a Deal
    

    [Teardown]    Close Browser
