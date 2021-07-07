*** Settings ***
Documentation       TC 049 Adjust Overdue record
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_049_Adjust_Overdue_record/connexion.csv
${DATAFILE} =    			./TestData/TC_049_Adjust_Overdue_record/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 049 Adjust Overdue record
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ENQ MCR.INPUT.PD.ADJUST
    Tap on command line  ?40
    Goto Menu    ${credentials}[4]
    
	Enquiry for Loan application    ${GLOBALFILE}    Numero client    PD.CUST.ID
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Abandonner les impayes")]
    Click Element    xpath: //*[contains(text(), "Abandonner les impayes")]
	
	Maximize Browser Window
	
	Read File and Fill input    ${DATAFILE}

    Input T24 textfield    fieldName:NEW.OUTS.AMT:1:3    0
	Press Keys    fieldName:NEW.OUTS.AMT:1:3    TAB
	Input T24 textfield    fieldName:NEW.OUTS.AMT:1:4    0
	Press Keys    fieldName:NEW.OUTS.AMT:1:4    TAB
    
    Choose Action    Validate a deal
	
    Choose Action    Commit the deal
    Sleep    2s
	
	Take Screenshot    PD_Adjust
	
	Accept Override
	
	Sleep    10s

    [Teardown]    Close Browser
