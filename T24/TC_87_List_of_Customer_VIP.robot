*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_87_List_of_Customer_VIP/connexion.csv
${DATAFILE} =    			./TestData/TC_87_List_of_Customer_VIP/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 87 List of Customer VIP
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    Wait Until Element Is Visible    value:1:1:1     30s
	Press Keys    value:1:1:1    RETURN
	Wait Until T24 Processing Is Visible
	Maximize Browser Window
	Sleep    1s
	Take Screenshot    auth_recover_deposit
    [Teardown]    Close Browser