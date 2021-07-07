*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource


*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_034_delete_on_FT_PNF/connexion.csv
${DATAFILE} =    			./TestData/TC_034_delete_on_FT_PNF/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 034 delete on FT PNF
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    
    #Tap on command line  ?58
    Tap on command line  ENQ FUNDS.TRANSFER.SOLAR.LAMPS.AUTH2
    #Goto Menu    ${credentials}[4]
    
	
	
	Enquiry for Loan application    ${DATAFILE}    Compte debite    AC.NO
	
	
	Wait Until Element Is Visible    xpath: //*[contains(text(), "Annuler vente lampes Solaires")]
    Click Element    xpath: //*[contains(text(), "Annuler vente lampes Solaires")]
	
    Wait Until Element Is Visible    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
    Click Element    xpath: //*[@id="headtab"]/tbody/tr/td[2]/a/span
	
    Take Screenshot    auth_FT_PNF_delete
	Choose Action    Deletes a Deal
    Wait Until T24 Processing Is Visible

    [Teardown]    Close Browser
