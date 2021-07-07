*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_050_Authorise_adjusted_overdue_record/connexion.csv
${DATAFILE} =    			./TestData/TC_050_Authorise_adjusted_overdue_record/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 050 2 Cancel Authorise adjusted overdue record
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?40
    #Tap on command line  ENQ MCR.AUTH.PD.ADJUST
    Goto Menu    ${credentials}[4]
    
	#Clear Filter
	#Wait Until Element Is Visible    value:1:1:1
	#Press Keys    value:1:1:1    RETURN
	Enquiry for Loan application    ${GLOBALFILE}    Numero client    PD.CUST.ID
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Rejeter l'abandon")]
    Click Element    xpath: //*[contains(text(), "Rejeter l'abandon")]
	
    Maximize Browser Window
	
    Sleep    1s
	Take Screenshot    auth_adjust_PD
	Choose Action    Deletes a Deal
    Sleep    10s
    Choose Action    Deletes a Deal
    Accept Override

    [Teardown]    Close Browser
