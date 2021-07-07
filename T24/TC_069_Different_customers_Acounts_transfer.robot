*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_069_Different_customers_Acounts_transfer/connexion.csv
${DATAFILE} =    			./TestData/TC_069_Different_customers_Acounts_transfer/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 069 Different customers Acounts transfer
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
	#Tap on command line    FUNDS.TRANSFER,MCR.OTHER.ACCT.TRFS
    Choose Action  New Deal
	
    Read File and Fill input    ${DATAFILE}
	Take Screenshot    FT_DIFF_CUSTOMER_ACCOUNTS
    Choose Action  Commit the deal
    ${FT.NO} =   Get transactionId created
    Append to file    ${GLOBALFILE}    FT.DIFF.CUSTOMER.ACCT;${FT.NO}\n
    [Teardown]    Close Browser