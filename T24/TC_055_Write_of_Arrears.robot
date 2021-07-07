*** Settings ***
Documentation       TC 055 Write of Arrears
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_055_Write_of_Arrears/connexion.csv
${DATAFILE} =    			./TestData/TC_055_Write_of_Arrears/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 055 Write of Arrears
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	Wait Until Element Is Visible    value:1:1:1
	Press Keys    value:1:1:1    RETURN
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Continuer le deblocage")]
    Click Element    xpath: //*[contains(text(), "Continuer le deblocage")]
	
    Read File and Fill input    ${DATAFILE}
    
    Choose Action    Commit the deal
    Sleep    2s

    [Teardown]    Close Browser
