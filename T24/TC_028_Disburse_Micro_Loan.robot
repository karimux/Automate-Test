*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_028_Disburse_Micro_Loan/connexion.csv
${DATAFILE} =    			./TestData/TC_028_Disburse_Micro_Loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 028 Disburse Micro Loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	Choose Action    New Deal
	${LAB.IB} =    Select data in Global File    ${GLOBALFILE}    LAB.ID
	Wait Until Element Is Visible    fieldName:LOAN.APPL.ID
	Input T24 textfield  fieldName:LOAN.APPL.ID  ${LAB.IB}
	Press Keys    fieldName:LOAN.APPL.ID    TAB
	
	Wait Until T24 Processing Is Visible

    Read File and Fill input    ${DATAFILE}
    
	#Copier le numéro de crédit
    ${LD.ID} =    Get transactionId to create
	${LD.ID} =    Remove String    ${LD.ID}    /
    Append to file    ${GLOBALFILE}    LD.ID;${LD.ID}\n
	
    Choose Action  Place a contract on Hold
    Sleep    2s

    [Teardown]    Close Browser
