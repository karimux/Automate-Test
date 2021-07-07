*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_016_Assign_loan_application_without_changing/connexion.csv
${DATAFILE} =    			./TestData/TC_016_Assign_loan_application_without_changing/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 016 Assign loan application without changing
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	Enquiry for Loan application    ${GLOBALFILE}    Numero de la demande    LAB.ID

	Wait Until Element Is Visible    xpath: //*[contains(text(), "Changer le statut en Evaluation")]    30s
    Click Element    xpath: //*[contains(text(), "Changer le statut en Evaluation")]
	
    #Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal
	Choose Action  Commit the deal
    [Teardown]    Close Browser
