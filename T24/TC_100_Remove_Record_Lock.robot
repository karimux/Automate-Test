*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_100_Remove_Record_Lock/connexion.csv
${DATAFILE} =    			./TestData/TC_100_Remove_Record_Lock/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 100 Remove Record Lock
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ?58
    Tap on command line  RECORD.LOCK, L L
    #Goto Menu    ${credentials}[4]
    Sleep   2s
	Switch Window    %RECORD.LOCK,
	
	Enquiry for Loan application    ${DATAFILE}    INPUTTER    USER
	
	
	
	
	Wait Until Element Is Visible    xpath: //*[@id="r1"]/td[2]/a/b    30s
    Click Element    xpath: //*[@id="r1"]/td[2]/a/b
	
	Sleep   1s
	Switch Window    Active Record Locks
	
	
	Choose Action    Perform an action on the contract
	
	Choose Action    Verifies a deal
	
    
    
    Sleep    2s

    [Teardown]    Close Browser
