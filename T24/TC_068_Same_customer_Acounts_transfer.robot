*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_068_Same_customer_Acounts_transfer/connexion.csv
${DATAFILE} =    			./TestData/TC_068_Same_customer_Acounts_transfer/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 068 Same customer Acounts transfer
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	#Tap on command line    FT,MCR.OWN.ACCT.TRFS
	#Select frame    xpath: /html/frameset/frame[2]
	#Wait Until Element Is Visible    xpath: //*[contains(text(), "Operations de caisse")]    60s
	#Click Element    xpath: //*[contains(text(), "Operations de caisse")]
	#Sleep    1s
	#Switch Window    ${MAINPAGE}
	#Select frame    xpath: /html/frameset/frame[1]
	#Switch Window    ${MAINPAGE}
	#Select frame    xpath: /html/frameset/frame[2]
	#Wait Until Element Is Visible    xpath: //*[text() = "Transfert entre comptes"]    60s
	#Click Element    xpath: //*[text() = "Transfert entre comptes"]
	#Sleep    1s
	#Switch Window    ${MAINPAGE}
	#Select frame    xpath: /html/frameset/frame[1]
	#Switch Window    ${MAINPAGE}
	#Select frame    xpath: /html/frameset/frame[2]
	#Wait Until Element Is Visible    xpath: //*[contains(text(), "Transfert entre comptes de meme client")]    60s
	#Click Element    xpath: //*[contains(text(), "Transfert entre comptes de meme client")]
	
    Choose Action  New Deal
    Read File and Fill input    ${DATAFILE}
	Take Screenshot    FT_SAME_CUSTOMER_ACCOUNTS
    Choose Action  Commit the deal
    ${FT.NO} =   Get transactionId created
    Append to file    ${GLOBALFILE}    FT.SAME.CUSTOMER.ACCT;${FT.NO}\n
    [Teardown]    Close Browser