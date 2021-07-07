*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_084_authorisation_of_the_withdrawal_account_closure/connexion.csv
${DATAFILE} =    			./TestData/TC_084_authorisation_of_the_withdrawal_account_closure/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 084 authorisation of the withdrawal account closure
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${TT.NO} =    Select data in Global File    ${GLOBALFILE}    TT.AC.CLOSED
	Sleep    1s
	Switch Window    TELLER
	Choose Action with Input   ${TT.NO}    Perform an action on the contract
	Sleep   1s
	Take Screenshot    auth_retrait_cloture_de_compte
    Choose Action  Authorises a deal
    [Teardown]    Close Browser