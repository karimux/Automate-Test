*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_036_the_custumor_is_eligible_for_alip/connexion.csv
${DATAFILE} =    			./TestData/TC_036_the_custumor_is_eligible_for_alip/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 036 the custumor is eligible for alip
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?324
    Goto Menu    ${credentials}[4]
    
	Choose Action  New Deal
	
	Maximize Browser Window
	${CUS.ID} =    Select data in Global File    ${GLOBALFILE}    OPT.CUS.ID
	Input T24 textfield    fieldName:CUSTOMER.ID    ${CUS.ID}
	Press Keys    fieldName:CUSTOMER.ID    TAB
	
	
	
    Read File and Fill input    ${DATAFILE}
    
	Take Screenshot    eligible_alip
    Choose Action    Commit the deal
	${ALIP.ID} =   Get transactionId created
    Append to file    ${GLOBALFILE}    ALIP.ID;${ALIP.ID}\n

    [Teardown]    Close Browser
