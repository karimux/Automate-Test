*** Settings ***
Documentation       TC 030 Continue disbursment.
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_030_Continue_disbursment/connexion.csv
${DATAFILE} =    			./TestData/TC_030_Continue_disbursment/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 030 Continue disbursment
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?58
    #Goto Menu on Default Page    ${credentials}[4]
    Goto Menu    ${credentials}[4]
    
	Enquiry for Loan application    ${GLOBALFILE}    Numéro du crédit    LD.ID
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Continuer le deblocage")]
    Click Element    xpath: //*[contains(text(), "Continuer le deblocage")]
	
	Maximize Browser Window
    Read File and Fill input    ${DATAFILE}
    
	
	Take Screenshot    continue_disbursement
    Choose Action    Validate a deal
	Choose Action    Commit the deal
	Choose Action    Validate a deal
    Choose Action    Commit the deal
    [Teardown]    Close Browser


