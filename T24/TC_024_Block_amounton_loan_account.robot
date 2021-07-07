*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_024_Block_amounton_loan_account/connexion.csv
${DATAFILE} =    			./TestData/TC_024_Block_amounton_loan_account/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 024 Block amount on loan account
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	Choose Action    New Deal
	${AC.LOCK} =    Select data in Global File    ${GLOBALFILE}    AC.LOCK
    Read File and Fill input    ${DATAFILE}
	Choose Action     Commit the deal
    ${AC.LOCK.EVENT} =    Get transactionId created
    Append to file    ${GLOBALFILE}    AC.LOCK.EVENT;${AC.LOCK.EVENT}\n
    [Teardown]    Close Browser
