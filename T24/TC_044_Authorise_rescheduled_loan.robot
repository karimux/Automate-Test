*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_044_Authorise_rescheduled_loan/connexion.csv
${DATAFILE} =    			./TestData/TC_044_Authorise_rescheduled_loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 044 Authorise rescheduled loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ENQ MCR.AUTH.LD.REECHELON
    Tap on command line  ?58
    Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	${LD.ID} =    Select data in Global File    ${GLOBALFILE}    LD.RESC.ID
	Reschedule Select right LD to Auth    ${LD.ID}
	
	#Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser l'enregistrement")]
    #Click Element    xpath: //*[contains(text(), "Autoriser l'enregistrement")]
	
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Choose Action    Authorises a deal
	Choose Action    Authorises a deal

    [Teardown]    Close Browser
