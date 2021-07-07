*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_067_Cash_Withdrawal/connexion.csv
${DATAFILE} =    			./TestData/TC_067_Cash_Withdrawal/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 067 Cash Withdrawal
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	
	${CUSTOMER.NO} =    Select data in Global File    ${GLOBALFILE}    CUSTOMER.NO
	Maximize Browser Window
	Select frame    xpath: /html/frameset/frameset[1]/frame
	${page} =    Get Title
	Enquiry for Loan application    ${GLOBALFILE}    Numero de client   CUSTOMER.NO
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Clients")]     30s
	Click Link    Clients
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Comptes")]     30s
	Click Link    Comptes
	Wait Until T24 Processing Is Visible
	
	Wait Until Element Is Visible    drillbox:1_1
    Select From List By Label  drillbox:1_1    Retrait d'especes
    Choose Action  Select Drilldown
	
	Choose Action  Select Drilldown
	Switch Window    ${page}
	Select frame    xpath: /html/frameset/frameset[2]/frame
	Select frame    xpath: /html/frameset/frameset[1]/frame
	Read File and Fill input    ${DATAFILE}	
	
    Choose Action  Commit the deal
	
    ${TT.WITH.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    TT.WITH.ID;${TT.WITH.ID}\n  
    [Teardown]    Close Browser