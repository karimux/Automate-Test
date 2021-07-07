*** Settings ***
Documentation       TC 041 List of clients opt out not eligibles
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_041_List_of_clients_opt_out_not_eligibles/connexion.csv
${DATAFILE} =    			./TestData/TC_041_List_of_clients_opt_out_not_eligibles/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 041 List of clients opt out not eligibles
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ENQ MCR.CUSTOMER.OPT.OUT.TAKA
    #Tap on command line  ?58
    #Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	Maximize Browser Window
	Sleep    2s
	
	Take Screenshot    Taka_non_eligible
    
    #Choose Action    Commit the deal
    Sleep    2s

    [Teardown]    Close Browser
