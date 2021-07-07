*** Settings ***
Documentation       TC 032 Authorise created loan
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_032_Authorise_created_loan/connexion.csv
${DATAFILE} =    			./TestData/TC_032_Authorise_created_loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 032 Authorise created loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?58
    Goto Menu   ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
    #${DAO} =    Select data in Global File    ${GLOBALFILE}    DAO
	#Enquiry for Loan application    ${GLOBALFILE}    Branch Code    DAO

	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser le debloquage")]    60s
    Click Element    xpath: //*[contains(text(), "Autoriser le debloquage")]
	
    #Read File and Fill input    ${DATAFILE}
    
    Choose Action    Authorises a deal
	
    Choose Action    Authorises a deal

    [Teardown]    Close Browser
