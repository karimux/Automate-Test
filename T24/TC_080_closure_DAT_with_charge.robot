*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_080_closure_DAT_with_charge/connexion.csv
${DATAFILE} =    			./TestData/TC_080_closure_DAT_with_charge/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 080 closure DAT with charge
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${COL.OWNER} =    Select data in Global File    ${GLOBALFILE}    DAT.TO.CLOSECGH
	Choose Action with Input    ${COL.OWNER}    Edit a contract

    Read File and Fill input    ${DATAFILE}

	Wait Until Element Is Visible    xpath: //*[@id="disabled_MIS.ACCT.OFFICER"]    60s
	${DAO.FOR.CLOSEDAT} =     Get Text    xpath: //*[@id="disabled_MIS.ACCT.OFFICER"]

    Append to file    ${GLOBALFILE}    DAO.FOR.CLOSEDAT;${DAO.FOR.CLOSEDAT}\n 
    Choose Action  Commit the deal
    [Teardown]    Close Browser