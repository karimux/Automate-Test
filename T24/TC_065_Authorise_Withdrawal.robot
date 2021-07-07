*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_065_Authorise_Withdrawal/connexion.csv
${DATAFILE} =    			./TestData/TC_065_Authorise_Withdrawal/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 065 Authorise Withdrawal
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Tap on command line  ?3
    Goto Menu on Default Page    ${credentials}[4]
    
	#${TELLER.AUTHORISE} =    Select data in Global File    ${GLOBALFILE}    TT.WITH.ID
	
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser Retrait")]
    Click Element    xpath: //*[contains(text(), "Autoriser Retrait")]
	
    Maximize Browser Window
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span    10s
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    auth_with
	Choose Action    Authorises a deal
    [Teardown]    Close Browser