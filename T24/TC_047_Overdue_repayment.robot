*** Settings ***
Documentation       TC 047 Overdue repayment
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_047_Overdue_repayment/connexion.csv
${DATAFILE} =    			./TestData/TC_047_Overdue_repayment/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 047 Overdue repayment
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    ${date} =    Get Today Date
	Switch Window   ${MAINPAGE}
    Tap on command line  ENQ MCR.INPUT.PD.REPAYMENT
    #Tap on command line  ?3
    #Goto Menu    ${credentials}[4]
    Enquiry for Loan application    ${GLOBALFILE}    Numero client    CUST.ID
		
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Regler le retard")]   30s
    Click Element    xpath: //*[contains(text(), "Regler le retard")]
	
	
    Input T24 textfield    fieldName:REPAYMENT.DATE    ${date}
	Press Keys    fieldName:REPAYMENT.DATE    TAB

	Read File and Fill input    ${DATAFILE}
    
    Choose Action    Commit the deal
    Sleep    2s

    [Teardown]    Close Browser
