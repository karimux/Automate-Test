*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_035_Opt_Out_a_client_ALIP/connexion.csv
${DATAFILE} =    			./TestData/TC_035_Opt_Out_a_client_ALIP/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 035 Opt Out a client ALIP
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ENQ MCR.OPT.OUT.CUSTOMER
    #Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Opt Out un client")]
    Click Element    xpath: //*[contains(text(), "Opt Out un client")]
	Maximize Browser Window
	
	
    Take Screenshot    opt_out_customer
    Read File and Fill input    ${DATAFILE}
	
    Choose Action    Commit the deal
	${LAB.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    OPT.CUS.ID;${LAB.ID}\n

    [Teardown]    Close Browser
