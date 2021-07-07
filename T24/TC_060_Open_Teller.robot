*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_060_Open_Teller/connexion.csv
${DATAFILE} =    			./TestData/TC_060_Open_Teller/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 060 Open Teller
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	
	${TELLER.OPEN} =    Select data in Global File    ${GLOBALFILE}    TELLER.OPEN
	Choose Action with Input    ${TELLER.OPEN}    Edit a contract
	Maximize Browser Window
    Read File and Fill input    ${DATAFILE}
    Choose Action  Commit the deal
	Take Screenshot    TELLER_OPEN_${TELLER.OPEN}
	
    [Teardown]    Close Browser