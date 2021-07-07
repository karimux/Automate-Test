*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_051_Create_PD_Capture/connexion.csv
${DATAFILE} =    			./TestData/TC_051_Create_PD_Capture/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 051 Create PD Capture
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?PD.MENU
    Goto Menu    ${credentials}[4]
    Choose Action    New Deal
	
	Wait Until Element Is Visible    xpath: //*/body/div[3]/div[2]/form[1]/div[4]/table/tbody/tr[3]/td/table[1]/tbody/tr[9]/td[2]/a     30s
	Click Element    xpath: //*/body/div[3]/div[2]/form[1]/div[4]/table/tbody/tr[3]/td/table[1]/tbody/tr[9]/td[2]/a
	
    Read File and Fill input    ${DATAFILE}
    
    Choose Action    Commit the deal
    ${PD.CAP} =   Get transactionId created
    Append to file    ${GLOBALFILE}    PD.CAP;${PD.CAP}\n  
    [Teardown]    Close Browser
