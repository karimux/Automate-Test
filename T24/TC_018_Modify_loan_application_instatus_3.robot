*** Settings ***
Documentation       TC 018 Modify loan application in status 3.
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_018_Modify_loan_application_instatus_3/connexion.csv
${DATAFILE} =    			./TestData/TC_018_Modify_loan_application_instatus_3/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 018 Modify loan application instatus 3
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	Enquiry for Loan application    ${GLOBALFILE}    Num. demande    LAB.ID
	Wait Until Element Is Visible    drillbox:1_1      60s
    Select From List By Label  drillbox:1_1    Modifier une demande statut 3
    Choose Action  Select Drilldown
	
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal
	Choose Action  Commit the deal
    [Teardown]    Close Browser
