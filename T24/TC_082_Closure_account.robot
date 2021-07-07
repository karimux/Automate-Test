*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_082_Closure_account/connexion.csv
${DATAFILE} =    			./TestData/TC_082_Closure_account/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 082 Closure account
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    ${GEN.ACCOUNT.NO} =    Select data in Global File    ${GLOBALFILE}    AC.TO.CLOSE
    Choose Action with Input    ${GEN.ACCOUNT.NO}    Edit a contract
    
    Read File and Fill input    ${DATAFILE}
    
	${soldeCompte} =    Get Text    disabled_OPEN.ACTUAL.BAL
	Log to console  ${soldeCompte}
	Take Screenshot    cloture_de_compte
	Choose Action  Commit the deal
    [Teardown]    Close Browser