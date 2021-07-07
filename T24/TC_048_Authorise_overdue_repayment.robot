*** Settings ***
Documentation       TC 048 Authorise overdue repayment
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_048_Authorise_overdue_repayment/connexion.csv
${DATAFILE} =    			./TestData/TC_048_Authorise_overdue_repayment/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 048 Authorise overdue repayment
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ENQ MCR.AUTH.PD.REPAYMENT
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser le payement du retard")]    30s
    Click Element    xpath: //*[contains(text(), "Autoriser le payement du retard")]
	
    Maximize Browser Window
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), 'Changes')]    20s
	Click Element    xpath: //*[contains(text(), 'Changes')]
	
    Take Screenshot    Auth_PD_repayment
	
    Choose Action    Authorises a deal
    Sleep    2s

    [Teardown]    Close Browser
