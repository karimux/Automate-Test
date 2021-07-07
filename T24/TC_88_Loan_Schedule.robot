*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_88_Loan_Schedule/connexion.csv
${DATAFILE} =    			./TestData/TC_88_Loan_Schedule/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 88 Loan Schedule
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ?58
    Goto Menu on Default Page    ${credentials}[4]
	
	Enquiry for Loan application    ${GLOBALFILE}    CONTRACT.ID   LD.SCHED.SEE
    Maximize Browser Window
	Sleep   1s
	Take Screenshot    loan_schedule
	Sleep   1s
    [Teardown]    Close Browser