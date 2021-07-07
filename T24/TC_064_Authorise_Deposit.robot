*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_064_Authorise_Deposit/connexion.csv
${DATAFILE} =    			./TestData/TC_064_Authorise_Deposit/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 064 Authorise Deposit
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    #Tap on command line  ?3
    Goto Menu on Default Page    ${credentials}[4]
    #Tap on command line   ENQ MCR.AUTO.DEPOSIT
	#${TELLER.AUTHORISE} =    Select data in Global File    ${GLOBALFILE}    TT.DEP.ID
	
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser")]
    Click Element    xpath: //*[contains(text(), "Autoriser")]
	
    Maximize Browser Window
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span    10s
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    auth_recover_deposit
	Choose Action    Authorises a deal
    [Teardown]    Close Browser