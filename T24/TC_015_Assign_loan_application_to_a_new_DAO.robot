*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_015_Assign_loan_application_to_a_new_DAO/connexion.csv
${DATAFILE} =    			./TestData/TC_015_Assign_loan_application_to_a_new_DAO/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 015 Assign loan application to a new DAO
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
	
	Enquiry for Loan application    ${GLOBALFILE}    Num. demande    LAB.ID
	Wait Until Element Is Visible    drillbox:1_1
    Select From List By Label  drillbox:1_1  Reassigner le client
    Choose Action  Select Drilldown
	
    Read File and Fill input    ${DATAFILE}
    ${CUSTOMER.NO} =    Select data in Global File    ${file}    CUSTOMER.NO
    Input T24 textfield  fieldName:CUSTOMER.ID:1  ${CUSTOMER.NO}
    Choose Action  Validate a deal
	Choose Action  Commit the deal
    [Teardown]    Close Browser
