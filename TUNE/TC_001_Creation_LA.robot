*** Settings ***
Documentation       Create LA
Library             OperatingSystem
Resource           ./includes/TransFunctions.resource

*** Variables ***
              
${CONNEXION} =    			./TestData/TC_001_Creation_LA/connexion.csv
${DATAFILE} =    			./TestData/TC_001_Creation_LA/customers.csv
${LA_DATA_FILE} =    			./TestData/TC_001_Creation_LA/la_data.csv
${GLOBALFILE} =             ./TestData/general.csv

*** Test Cases ***
TC 001 Creation LA
    #[Setup]
    ${general_data} =    Read Tune Connection Data    ${CONNEXION}
	Log to console    ${general_data}
    ${la_data} =   Get LA Data  ${LA_DATA_FILE}
	Open Tune Browser To Login Page    ${general_data}[0]    ${BROWSER}
    Connection To Tune    ${general_data}[1]    ${general_data}[2]
    ${customers} =  Get Customer Code from data file  ${DATAFILE}
    
    FOR    ${customer}    IN    @{customers}
        Search a customer  ${customer}
        Open LA creation Form  ${la_data}[0]  ${la_data}[1]  ${la_data}[2]
    END
    
    [Teardown]    Close Browser

*** Keywords ***
Get Customer Code from data file
    [Arguments]   ${file}
    ${contentLine}  Set Variable  ${EMPTY}
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}  0    1
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
    END
    [return]  ${contentLine}
