*** Settings ***
Documentation       TC 023 Cancel loan application.
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_023_Cancel_loan_application/connexion.csv
${DATAFILE} =    			./TestData/TC_023_Cancel_loan_application/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 023 Cancel loan application
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	Enquiry for Loan application    ${GLOBALFILE}    Num. demande    LAB.ID
	Wait Until Element Is Visible    drillbox:1_1
    Select From List By Label  drillbox:1_1    #Cancel action non trouvée
    Choose Action  Select Drilldown


    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal
    Sleep    2s
	Choose Action  Commit the deal
    Sleep    10s
    [Teardown]    Close Browser
