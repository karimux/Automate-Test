*** Settings ***
Documentation       TC 040 Opt Out un client TAKA
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_040_Opt_Out_un_client_TAKA/connexion.csv
${DATAFILE} =    			./TestData/TC_040_Opt_Out_un_client_TAKA/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 040 Opt Out un client TAKA
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ENQ MCR.OPT.OUT.CUSTOMER.TAKA
	#Tap on command line  ?58
    #Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1    30s
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "TAKA Opt out un client")]
    Click Element    xpath: //*[contains(text(), "TAKA Opt out un client")]
	
    Read File and Fill input    ${DATAFILE}
    
    Choose Action    Commit the deal

    [Teardown]    Close Browser
