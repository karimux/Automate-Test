*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_063_Recouvrement_deposit/connexion.csv
${DATAFILE} =    			./TestData/TC_063_Recouvrement_deposit/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 063 Recouvrement deposit
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	
	#${TELLER.AUTHORISE} =    Select data in Global File    ${GLOBALFILE}    TELLER.AUTHORISE
	Choose Action    New Deal
	Maximize Browser Window
    Read File and Fill input    ${DATAFILE}
	Sleep    12s
    Take Screenshot    Recouvrement_deposit
	Choose Action  Commit the deal
	
    [Teardown]    Close Browser