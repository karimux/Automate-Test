*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_045_Restructure_healthy_Micro_loan/connexion.csv
${DATAFILE} =    			./TestData/TC_045_Restructure_healthy_Micro_loan/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 045 Restructure healthy Micro loan
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?58
    Goto Menu    ${credentials}[4]
    
	${LD.ID} =    Select data in Global File    ${GLOBALFILE}    LD.TO.REST
    
    Choose Action with Input    ${LD.ID}    Edit a contract
	Read File and Fill input    ${DATAFILE}
	Sleep    2s
	Take Screenshot    restructed_loan
    Choose Action    Validate a deal
	Choose Action    Commit the deal
	#Read File and Fill input    ${DATAFILE2}
	Choose Action    Validate a deal
	Choose Action    Commit the deal
    [Teardown]    Close Browser
