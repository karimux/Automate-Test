*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_061_Close_Teller/connexion.csv
${DATAFILE} =    			./TestData/TC_061_Close_Teller/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 061 Close Teller
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	
	${TELLER.CLOSE} =    Select data in Global File    ${GLOBALFILE}    TELLER.CLOSE
	Choose Action with Input    ${TELLER.CLOSE}    Edit a contract
	Maximize Browser Window
    Read File and Fill input    ${DATAFILE}
    Choose Action  Commit the deal
	Take Screenshot    TELLER_CLOSE_${TELLER.CLOSE}
	
    [Teardown]    Close Browser