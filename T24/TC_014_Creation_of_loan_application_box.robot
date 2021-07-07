*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_014_Creation_of_loan_application_box/connexion.csv
${DATAFILE} =    			./TestData/TC_014_Creation_of_loan_application_box/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 014 Creation of loan application box
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	Choose Action    New Deal
    ${CUSTOMER.NO} =    Select data in Global File    ${GLOBALFILE}    CUSTOMER.NO
	Wait Until Element Is Visible    fieldName:CUSTOMER.ID
    Input T24 textfield  fieldName:CUSTOMER.ID  ${CUSTOMER.NO}
    Press Keys    fieldName:CUSTOMER.ID    TAB
    Wait Until Element Is Visible    xpath: //*[@id="mainTab"]/tbody/tr[7]/td[3]/a    60s
    Click Element    xpath: //*[@id="mainTab"]/tbody/tr[7]/td[3]/a
    #Press Keys    fieldName:LOAN.PROCESS    NEW.LOAN
    #Select frame    fieldName:LOAN.PROCESS:iframe
    Wait Until Element Is Visible    fieldName:LOAN.PROCESS:div    60s
	Wait Until Element Is Visible    xpath: //*[contains(text(), "NEW.LOAN")]    60s
    Click Element    xpath: //*[contains(text(), "NEW.LOAN")]
    #Press Keys    fieldName:LOAN.PROCESS    TAB
    
    
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal
    Sleep    2s
	Choose Action  Commit the deal
    Sleep    2s	
	#Copier le numéro de la demande de crédit
    ${LAB.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    LAB.ID;${LAB.ID}\n

    [Teardown]    Close Browser