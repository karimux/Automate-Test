*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_085_Authorised_account_closure/connexion.csv
${DATAFILE} =    			./TestData/TC_085_Authorised_account_closure/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 085 Authorised account closure
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${AC.NO} =    Select data in Global File    ${GLOBALFILE}    AC.TO.CLOSE
	Sleep   1s
	Switch Window    ACCT.CLOSURE
	Choose Action with Input   ${AC.NO}    Perform an action on the contract
	Sleep   1s
	Take Screenshot    auth_retrait_cloture_de_compte
    Choose Action  Authorises a deal
    [Teardown]    Close Browser