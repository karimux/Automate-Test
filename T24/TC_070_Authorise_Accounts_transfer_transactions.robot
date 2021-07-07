*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_070_Authorise_Accounts_transfer_transactions/connexion.csv
${DATAFILE} =    			./TestData/TC_070_Authorise_Accounts_transfer_transactions/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 070 Authorise Accounts transfer transactions
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	#Tap on command line    ENQ MCR.AUTH.FT.CUST
	Enquiry for Loan application    ${GLOBALFILE}    Compte a debiter    AUTH.DEBIT.ACCT.NO
	
	#Wait Until Element Is Visible    value:1:1:1
	#Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Autoriser le FT")]
    Click Element    xpath: //*[contains(text(), "Autoriser le FT")]
	
    Maximize Browser Window
	Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span    10s
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    auth_FT
	Choose Action    Authorises a deal
    [Teardown]    Close Browser