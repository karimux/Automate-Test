*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_059_Create_Customer_Level3/connexion.csv
${DATAFILE} =    			./TestData/TC_059_Create_Customer_Level3/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 059 Create Customer Level3
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  CUSTOMER,MCR.PICL3
    Choose Action    New Deal
	#Read file and input data
	Sleep    5s
	Switch Window    CLIENT
	Maximize Browser Window
	
	Read File and Fill input    ${DATAFILE}
	Choose Action    Validate a deal
	Wait Until T24 Processing Is Visible
	Take Screenshot   customer_level_3
	${CUSTOMER.NO} =   Get transactionId to create
	Choose Action    Commit the deal
	Choose Action    Validate a deal
	
	Take Screenshot   customer_level_3
	
	Choose Action    Commit the deal
    
    Append to file    ${GLOBALFILE}    CUSTOMERL3.NO;${CUSTOMER.NO}\n
    [Teardown]    Close Browser
