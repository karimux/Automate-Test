*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_057_PD_Write_Off_Loan/connexion.csv
${DATAFILE} =    			./TestData/TC_057_PD_Write_Off_Loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 057 PD Write Off Loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  PD.PAYMENT.DUE,MCR.LOAN.WOF
    Tap on command line    ?3
    Goto Menu    ${credentials}[4]
    ${LD.TO.WOF} =    Select data in Global File    ${GLOBALFILE}    PD.TO.WOF
	Choose Action with Input    ${LD.TO.WOF}    Edit a contract
	
	
	Take Screenshot   wof
	
	Choose Action    Validate a deal
    Choose Action    Commit the deal
	
	Take Screenshot   wof_commit

    [Teardown]    Close Browser
