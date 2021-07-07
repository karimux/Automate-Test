*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_002_Update_Customer_level_1_to_level_2/connexion.csv
${DATAFILE} =    			./TestData/TC_002_Update_Customer_level_1_to_level_2/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 002 Update Customer Level 1 to Level 2
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    
	${CUSTOMER.NO} =    Select data in Global File    ${GLOBALFILE}    CUSTOMER.NO
	
	Enquiry for Loan application    ${GLOBALFILE}    Numero client    CUSTOMER.NO

	Wait Until Element Is Visible    xpath: //*[contains(text(), "Changer vers Niveau 2")]
    Click Element    xpath: //*[contains(text(), "Changer vers Niveau 2")]
	
    
    #Click on the link to update data 
    #Click Element    xpath: //*[@id="r1"]/td[13]/a
    
    
    Read File and Fill input    ${DATAFILE}
    
    Choose Action  Validate a deal
    Sleep    2s
    Choose Action  Commit the deal
    Choose Action  Commit the deal
    [Teardown]    Close Browser