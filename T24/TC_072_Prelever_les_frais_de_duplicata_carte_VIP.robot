*** Settings ***
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
${CONNECTIONFILE} =   		./TestData/TC_072_Prelever_les_frais_de_duplicata_carte_VIP/connexion.csv
${DATAFILE} =    			./TestData/TC_072_Prelever_les_frais_de_duplicata_carte_VIP/data.csv
${GLOBALFILE} =             ./TestData/data.csv

*** Test Cases ***
TC 072 Prelever les frais de duplicata carte VIP
    [Setup]
    ${credentials} =    Initialize Variables    ${CONNECTIONFILE}
    Log to console    données du fichier connexion.csv ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    ${CONNECTIONFILE}
    Goto Menu on Default Page    ${credentials}[4]
    Choose Action  New Deal
    Read File and Fill input    ${DATAFILE}
    Choose Action  Commit the deal
	Take Screenshot    VIP_FEE
    ${VIP.FEE.CHG} =   Get transactionId created
    Append to file    ${GLOBALFILE}    VIP.FEE.CHG;${VIP.FEE.CHG}\n  
    [Teardown]    Close Browser