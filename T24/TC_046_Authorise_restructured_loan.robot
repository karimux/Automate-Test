*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_046_Authorise_restructured_loan/connexion.csv
${DATAFILE} =    			./TestData/TC_046_Authorise_restructured_loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 046 Authorise restructured loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ENQ MCR.AUTH.LD.RESTRUCTURE
    Tap on command line  ?58
    Goto Menu    ${credentials}[4]
    Clear Filter
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser restructuration")]    10s
    Click Element    xpath: //*[contains(text(), "Autoriser restructuration")]
	
	Maximize Browser Window
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span    10s
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    auth_restructed_loan
	Choose Action    Authorises a deal
   
	
    Take Screenshot    auth_restructed_loan_eche
	Choose Action    Authorises a deal
   

    [Teardown]    Close Browser
