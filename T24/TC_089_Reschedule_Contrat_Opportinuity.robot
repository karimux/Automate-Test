*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_089_Reschedule_Contrat_Opportinuity/connexion.csv
${DATAFILE} =    			./TestData/TC_089_Reschedule_Contrat_Opportinuity/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 089 Reschedule Contrat Opportinuity
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Goto Menu on Default Page    ${credentials}[4]
	
	${LD.ID} =    Select data in Global File    ${GLOBALFILE}    LD.OP.RESC.ID
    
	Choose Action with Input    ${LD.ID}    Edit a contract
    
	#Input T24 textfield    fieldName:FIRST.PAYM.DATE    ${FIRST_PAY_DATE}
    Read File and Fill input    ${DATAFILE}
    
    
	Take Screenshot    rescheduled_loan_opp
	Choose Action    Validate a deal
	Choose Action    Commit the deal
	Choose Action    Validate a deal
	Choose Action    Commit the deal

    [Teardown]    Close Browser
