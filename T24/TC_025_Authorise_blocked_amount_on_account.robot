*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_025_Authorise_blocked_amount_on_account/connexion.csv
${DATAFILE} =    			./TestData/TC_025_Authorise_blocked_amount_on_account/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 025 Authorise blocked amount on account
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${AC.LOCK.EVENT} =    Select data in Global File    ${GLOBALFILE}    AC.LOCK.EVENT
	Sleep    1s
	Switch Window    LOCKED EVENTS
	Choose Action with Input   ${AC.LOCK.EVENT}    Perform an action on the contract
	Sleep   1s
	Take Screenshot    auth_lock_event
    Choose Action  Authorises a deal
    [Teardown]    Close Browser