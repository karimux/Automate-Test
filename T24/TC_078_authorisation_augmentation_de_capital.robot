*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_078_authorisation_augmentation_de_capital/connexion.csv
${DATAFILE} =    			./TestData/TC_078_authorisation_augmentation_de_capital/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 078 authorisation augmentation de capital
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	#Tap on command line    ENQ MCR.AUTH.LD.TUPDATE
	
	Wait Until Element Is Visible    value:1:1:1     30s
	Press Keys    value:1:1:1    RETURN
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Authorise Record")]
    Click Element    xpath: //*[contains(text(), "Authorise Record")]
	
    Maximize Browser Window
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span    10s
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    auth_DAT_INCR
	Choose Action    Authorises a deal
    [Teardown]    Close Browser