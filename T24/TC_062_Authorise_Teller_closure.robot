*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_062_Authorise_Teller_closure/connexion.csv
${DATAFILE} =    			./TestData/TC_062_Authorise_Teller_closure/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 062 Authorise Teller closure
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	
	${TELLER.AUTHORISE} =    Select data in Global File    ${GLOBALFILE}    TELLER.AUTHORISE
	Choose Action with Input    ${TELLER.AUTHORISE}    Perform an action on the contract
	Maximize Browser Window
    Choose Action  Authorises a deal
	Take Screenshot    TELLER_CLOSED_${TELLER.AUTHORISE}
	
    [Teardown]    Close Browser