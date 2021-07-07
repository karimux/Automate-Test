*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_066_Cash_Deposit/connexion.csv
${DATAFILE} =    			./TestData/TC_066_Cash_Deposit/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 066 Cash Deposit
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
	#Click Element     xpath: xpath: //*[contains(text(), "Clients")]
	Click Link    Clients
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Comptes")]     30s
	#Click Element     xpath: xpath: //*[contains(text(), "Comptes")]
	Click Link    Comptes
	Wait Until T24 Processing Is Visible
	
	Wait Until Element Is Visible    drillbox:1_1
    Select From List By Label  drillbox:1_1    Depot d'especes
    Choose Action  Select Drilldown
	Switch Window    ${page}
	Select frame    xpath: /html/frameset/frameset[2]/frame
	Select frame    xpath: /html/frameset/frameset[1]/frame
	
	Read File and Fill input    ${DATAFILE}	
	
    Choose Action  Commit the deal
	
    ${TT.DEP.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    TT.DEP.ID;${TT.DEP.ID}\n
    [Teardown]    Close Browser