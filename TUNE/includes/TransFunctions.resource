*** Settings ***
Documentation     TUNE Framework : Test Automation documentation for TUNE of Baobab Company
Library           SeleniumLibrary
Library           BuiltIn
Library           String
Library           OperatingSystem
Library			  Screenshot



*** Variables ***
${LOGIN URL}      empty
${FILIALE}        empty
${SIGNONNAME}     empty
${PASSWORD}       empty
${MENU}           empty
${BROWSER}        Chrome
${MAINPAGE}       empty
${GLOBALFILE}     ./TestData/data.csv


*** Keywords ***
Open Tune Browser To Login Page
    [Arguments]    ${LOGIN URL}    ${BROWSER}
	[Documentation]   Open browser and set Tune url
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    ${MAINPAGE} =    Get Title
    #Execute javascript  document.body.style.zoom="80%"
    #Sleep  2s
    #Switch Window    ${MAINPAGE}

    
#    Check access to page by Title    Optimal

#Serach a customer after cliqk on activities
Search a customer
    [Arguments]    ${customerCode}
	[Documentation]   Search a customer by giving the customer code
    Sleep    2s
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Wait Until Element Is Visible  xpath: //*[@id="utApp"]/div/div/header/div/div/div/div/div/div[2]/div/div/form/span/input  60s
	Input Text    xpath: //*[@id="utApp"]/div/div/header/div/div/div/div/div/div[2]/div/div/form/span/input      ${customerCode}
    Press Keys    xpath: //*[@id="utApp"]/div/div/header/div/div/div/div/div/div[2]/div/div/form/span/input    RETURN
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    180s
    Click on customer row founded  ${customerCode}

Click on customer row founded
    [Arguments]    ${customerCode}
	[Documentation]   In customer search result page, click on the row if the customer founded. The customer code is given as an argument
    #Wait Until Element Is Visible     xpath: //table[contains(text(), "${customerCode}")]     30s
    #Click Element    xpath: //table[contains(text(), "${customerCode}")]
    Wait Until Element Is Visible     xpath: //*[@id="customer"]/div/div[2]/div/div/div/div[2]/div/div[1]/div/div/table/tbody/tr/td[4]     60s
	${allElements} =    Get WebElements    xpath: //*[@id="customer"]/div/div[2]/div/div/div/div[2]/div/div[1]/div/div/table/tbody/tr/td[4]
    ${i}     Set Variable    0
	${path}   Set Variable    ${EMPTY}
	FOR    ${element}    IN    @{allElements}
        ${text}=    Get Text    ${element}
        ${i} =    Evaluate    ${i}+1
		Log to console    Element ${i} = ${text}
        IF    '${text}' == '${customerCode}'
            #${path}    Set Variable    //*[@id="customer"]/div/div[2]/div/div/div/div[2]/div/div[1]/div/div/table/tbody/tr[${i}]/td[4]
            Click Element    xpath: //*[@id="customer"]/div/div[2]/div/div/div/div[2]/div/div[1]/div/div/table/tbody/tr[${i}]/td[4]
			#Log to console    ${path}
            #Click Element   xpath: ${path}
        END
        Exit For Loop IF    '${text}' == '${customerCode}'
    END
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Take Screenshot    Customer_File_${customerCode}



Open LA creation Form
    [Arguments]  ${amount}  ${term}  ${comment}
	[Documentation]   In the customer file, Open the loan application form
	Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
	Wait Until Element Is Visible    xpath: //*[@id="customer"]/div/div[1]/div[3]/span[2]/div/div/div/span/span[1]
	Click Element    xpath: //*[@id="customer"]/div/div[1]/div[3]/span[2]/div/div/div/span/span[1]
	Sleep    2s
	Click Element    xpath: //*[@id="customer"]/div/div[1]/div[3]/span[2]/div/div/div/ul/li/a/span
	Fill Form  ${amount}  ${term}  ${comment}


Fill Form
    [Arguments]  ${amount}  ${term}  ${comment}
	[Documentation]   After openning form,  fill it with amount, duration and comment
	Wait Until Element Is Visible    requestedAmount    60s
	Input Text   requestedAmount    ${amount}
	Input Text   requestedTerm    ${term}
	Press Keys     requestedTerm    TAB
	Press Keys     requestedTerm    TAB
	Press Keys     requestedTerm    TAB
	Press Keys     requestedTerm    TAB
	
	Input Text   comment    ${comment}

    Press Keys     requestedTerm    TAB
	Press Keys     requestedTerm    TAB

    Press Keys  xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button/span  RETURN
	
    # Click on signature Button
	#Click Element    xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button/span
    # Click on submit button 
    Wait Until Element Is Visible  xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button/span  60s
    #Click Element  xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button/span
    Press Keys     xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button    RETURN

    # save LA ID and click on END button
    Wait Until Element Is Visible  xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[1]/div/div/div/div[3]/span[2]  60s
	${LA.ID} =    Get Text   xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[1]/div/div/div/div[3]/span[2]
    Append to file    ${GLOBALFILE}    LA.ID;${LA.ID}\n
    Wait Until Element Is Visible  xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button/span  60s
    Press Keys     xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button    RETURN
    #Click Element  xpath: //*[@id="customer"]/div/div[1]/div/div/div/div[2]/div[2]/div[3]/div/button
    Sleep  2s


Goto Menu
    [Arguments]    ${menu}
	[Documentation]   Click on menu, label of the menu is given as argument
    Wait Until Element Is Visible    xpath: //*[contains(text(), "${menu}")]  120s
    Click Element    xpath: //*[contains(text(), "${menu}")]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Goto LAs to assign
	[Documentation]   Click on tab or submenu "To Assign" in order to open loan application in status to assign
    Wait until Element Is Visible  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[1]/span[1]/span  120s
    Click Element  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[1]/span[1]/span
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Goto LAs to evaluate
	[Documentation]   Click on tab or submenu "To evaluate" in order to open loan application in status assigned
    Wait until Element Is Visible  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[1]/span[1]/span  120s
    Click Element  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[1]/span[1]/span
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Goto LAs in comite
	[Documentation]   Click on tab or submenu "In comite" in order to open loan application in comite
    Wait until Element Is Visible  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[3]/span[1]/span  120s
    Click Element  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[3]/span[1]/span
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Goto Results tab
	[Documentation]   Click on tab or submenu "In comite" in order to open loan application in comite
    Wait until Element Is Visible  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[4]/span[1]/span  120s
    Click Element  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/div[3]/div[4]/span[1]/span
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Open LA to disburse
    [Arguments]  ${LA.ID}
	[Documentation]   Open loan application file to disburse, ID is needed to select LA
    Wait Until Element Is Visible  xpath: //*[contains(text(), "${LA.ID}")]  60s
    Click Element  xpath: //*[contains(text(), "${LA.ID}")]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Disburse LA  oui

Disburse LA
    [Arguments]  ${message}
	[Documentation]   Disburse loan application, the confirmation message is needed. By default it's set to "oui"
    Wait Until Element Is Visible  xpath: //*[contains(text(), "Débloquer")]  60s
    Click Element  xpath: //*[contains(text(), "Débloquer")]
    Sleep  1s
    Input Text  disburse.disburseComment  ${message}
    Click Element  xpath: //*[contains(text(), "Débloquer")]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    #click to return button
    Click Element  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div/div[2]/a
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Goto Results tab

Select Creator or the first GP
    [Arguments]    ${path}    ${creator}
    [Documentation]
    Click Element  xpath: ${path}
    Sleep  1s
    Press Keys  xpath: ${path}  ${creator}
    Log to console    ${creator}\n
    ${status}=    Run Keyword And Return Status    Element Should Contain    class:Select-menu-outer    ${creator}
    Log to console    ${status}\n
    IF    '${status}'=='True'
        Sleep  1s
        Press Keys  xpath: ${path}   RETURN
    ELSE
        Log to console   cas False
        #Clear Element Text    xpath: /html/body/div/div/div/div/div/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[1]/td[7]/div/div/div/span[1]/div[2]/input
        Clear Element Text    xpath: ${path}/span/div/input
        Sleep  1s
        Press Keys  xpath: ${path}  ARROW_DOWN
        Sleep  1s
        Press Keys  xpath: ${path}   RETURN
        Sleep  1s
    END
    

Assign LA to GP
    [Arguments]  ${LA.ID}
	[Documentation]   Assign loan aplication to a DAO, loan application ID is needed
    ${creator}     ${input}    Get Creator for assignment     ${LA.ID}
    ${path} =  Select LA to assign  ${LA.ID}
    Select Creator or the first GP    ${input}    ${creator}
    # début commenter, tester avant d'enlever
    #Click Element  xpath: ${path}
    #Sleep  1s
    #Press Keys  xpath: ${path}  ARROW_DOWN
    #Sleep  1s
    #Press Keys  xpath: ${path}   RETURN
    #Sleep  1s
    # Fin

    
    Click Element  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr/td[7]/div/button
    Wait Until Element Is Visible    xpath: //*[@id="utApp"]/div/div[2]/div/div/div/div/div[1]     180s
    Sleep    1s
    Execute Javascript  document.querySelector('#utApp > div > div:nth-child(2) > div').click();
    

Evaluate LA
    [Arguments]  ${ID}
	[Documentation]   Evaluate loan application by given LA ID
    ${path} =  Select LA to evaluate  ${ID}
    Click Element  xpath: ${path}
    #//*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[1]/td[1]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Click on Decisions Tab
    Fill Evaluate Form



Click on Decisions Tab
	[Documentation]   In the loan application file, Click on decision Tab in order to make  decision
    Wait Until Element Is Visible  xpath: //*[@id="main-nav"]/ul/li[6]/a/span    60s
    Click Element  xpath: //*[@id="main-nav"]/ul/li[6]/a/span
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Click on Cautions Tab
	[Documentation]   In the loan application file, Click on Cautions Tab
    Wait Until Element Is Visible  xpath: //*[@id="main-nav"]/ul/li[4]/a/span
    Click Element  xpath: //*[@id="main-nav"]/ul/li[4]/a/span
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s

Fill Evaluate Form
	[Documentation]   Fill the loan application evaluating form and click on get conditions in order to send LA in comite
    Input Text  loanPurpose.purposeDetails   Détails de l'objet du crédit
    Input Text  comment   J'approuve
    Click Element  xpath: //*[@id="content"]/div[2]/div[1]/div[2]/div[1]/div[6]/div[2]/div/div/input
    Sleep  1s
    Click Element  xpath: /html/body/div[2]/div/div/div/div/div[1]/div/a[3]
    Sleep  1s
    Click Element  xpath: /html/body/div[2]/div/div/div/div/div[2]/table/tbody/tr[3]/td[2]
    
    #Click Element  xpath: //*[@id="content"]/div[1]/div/div
    Click Element  xpath: //*[contains(text(), "Obtenir les conditions de credits")]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Click on Cautions Tab
    Click Element  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div/div[1]/div[1]/a[2]
    Click Element  xpath: //*[contains(text(), "Valider")]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    ${texte} =  Get Text  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div/div[1]/div[2]/p/span
    Log to console  ${texte}
    Click Element  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div/div[2]/a
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Goto LAs to evaluate
    
Approve LA
    [Arguments]  ${ID}  ${amount}  ${duration}  ${comment}
	[Documentation]   Approve Loan application by given ID. amount, duration and comment is also given as parameters
    ${path} =  Select LA to evaluate  ${ID}
    Click Element  xpath: ${path}
    #//*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[1]/td[1]
    #Click Element  xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[1]/td[1]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Click Element  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div/div[1]/div[1]/a[3]/span

    Input Text  approve.approveComment  ${comment}
    Input Text  approve.amount  ${amount}
    Input Text  approve.duration  ${duration}
    Click Element  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div[1]/div/div/div[2]/div/div[1]/div/div/div[2]/div/div[3]/div[2]/div/input
    Sleep  1s
    Click Element  xpath: /html/body/div[2]/div/div/div/div/div[1]/div/a[3]
    Sleep  1s
    Click Element  xpath: /html/body/div[2]/div/div/div/div/div[2]/table/tbody/tr[3]/td[2]
    Click Element  xpath: //*[contains(text(), "Valider")]
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Click Element  xpath: //*[@id="loanForm"]/div/header/div/div/div[2]/div/div[2]/a
    Wait Until Element Is Not Visible     xpath: //*[@id="utApp"]/div/div[2]    120s
    Goto LAs in comite


# To connect to Tune by reading the connexion.txt file
Connection To Tune
    [Arguments]    ${login}    ${password}
	[Documentation]   Fill login and password field to connect 
    #Execute javascript  document.body.style.zoom="80%"
    Sleep  1s
    Input Tune connection textfield    username    ${login}
    Press Keys    username    RETURN
    Input Tune connection textfield    password    ${password}
    Press Keys    password    RETURN
    Sleep  2s
    



Input Tune connection textfield
    [Arguments]    ${fieldname}    ${fieldvalue}
	[Documentation]   Input textfield connection form
	Wait Until Element Is Visible    ${fieldname}   60s
    Input Text     ${fieldname}    ${fieldvalue}

# Read The connexion.txt file and get credentials
Read Tune Connection Data
    [Arguments]    ${file}
	[Documentation]   Read file and get credentials, the general.csv located in directory TestData is used. The rows from 1 to 2 are selected
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}    0    3
	${params}    Set Variable    ${EMPTY}
    FOR    ${line}    IN    @{fileData}
        #Log to console    ${line}
        @{contentLine} =    Split String    ${line}    ;
		IF     '${params}' == '${EMPTY}'
			${params}    Set Variable    ${contentLine}[1]
		ELSE
			${params}     Set Variable    ${params},${contentLine}[1]
		END
    END
	${params}    Split String    ${params}    ,
	[return]    ${params}

Read general file and prepare loans to assign
    [Arguments]  ${file}
	[Documentation]   Read file and prepare loan application ID to use in the test Cases. the file la_data.csv located in directory TestData/TC_00X_Name is used. All rows with LA.ID will be selected and their values collected as IDs LA for the test cases
    ${contentLine}  Set Variable  ${EMPTY}
    ${LA.IDs}  Set Variable  ${EMPTY}
    ${contents} =    Get File    ${file}
    ${index} =  Set Variable  ${0}
    @{fileData} =    Split To Lines    ${contents}  3
    FOR    ${line}    IN    @{fileData}
        ${index} =   Evaluate    ${index}+1
        @{contentLine} =    Split String    ${line}    ;
        IF    '${contentLine}[0]' == 'LA.ID'
            IF  '${LA.IDs}' == '${EMPTY}'
                ${LA.IDs}  Set Variable   ${contentLine}[1]
            ELSE
                ${LA.IDs}  Set Variable  ${LA.IDs},${contentLine}[1]
            END
        END
    END
    ${LA.IDs} =   Split String  ${LA.IDs}   ,
    [return]  ${LA.IDs}

Get Creator for assignment
    [Arguments]   ${ID}
	[Documentation]   Get Creator for assignment
    ${path}  Set Variable  ${EMPTY}
    ${creator}  Set Variable  ${EMPTY}
    ${allElements} =    Get WebElements    xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr/td[1]
	${i}     Set Variable    1
	FOR    ${element}    IN    @{allElements}
        ${text}=    Get Text    ${element}
        IF    '${text}' == '${ID}'
            #${path}    Set Variable   //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[${i}]/td[7]/div/div/div
            ${creator}=   Get Text    xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[${i}]/td[6]
            ${path}     Set Variable    //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[${i}]/td[7]/div/div/div
        END
        Exit For Loop IF    '${text}' == '${ID}'
		${i} =    Evaluate    ${i}+1
    END
	[return]    ${creator}    ${path}

Select LA to assign
    [Arguments]   ${ID}
	[Documentation]   Select the exact loan application ID to assign in the table of LAs to assign
    ${path}  Set Variable  ${EMPTY}
    ${allElements} =    Get WebElements    xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr/td[1]
	${i}     Set Variable    1
	FOR    ${element}    IN    @{allElements}
        ${text}=    Get Text    ${element}
        IF    '${text}' == '${ID}'
            ${path}    Set Variable   //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[${i}]/td[7]/div/div/div
        END
        Exit For Loop IF    '${text}' == '${ID}'
		${i} =    Evaluate    ${i}+1
    END
	[return]  ${path}

Select LA to evaluate
    [Arguments]   ${ID}
	[Documentation]   Select the exact loan application ID to evaluate in the table of LAs in evaluation
    ${path}  Set Variable  ${EMPTY}
    ${allElements} =    Get WebElements    xpath: //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr/td[1]
	${i}     Set Variable    1
	FOR    ${element}    IN    @{allElements}
        ${text}=    Get Text    ${element}
        IF    '${text}' == '${ID}'
            ${path}    Set Variable   //*[@id="loan"]/div/div[2]/div/div[2]/div/div[2]/div/div/table/tbody/tr[${i}]/td[1]
        END
		${i} =    Evaluate    ${i}+1
    END
	[return]  ${path}

# Get Loan application data from TestData file
Get LA Data
    [Arguments]  ${file}
	[Documentation]   Get Loan application data from TestData file. TestData located in TestData/TC_0XX_TestCase_Name/la_data.csv. This data are used to fill the form for Creating LA or Disburse LA
    ${contentLine}  Set Variable  ${EMPTY}
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}  1    2
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
    END
    [return]  ${contentLine}

Wait Until Loader Is Visible
    [Documentation]   Wait until tune admin loader is Visible
    Wait Until Element Is Not Visible    xpath: //*[contains(text(), "Loading, please wait")]    180s

Goto Admin Menu
    [Arguments]    ${menu}
    [Documentation]    Navigate to admin Menu
    Wait Until Element Is Visible    xpath: //a[contains(text(), "${menu}")]     30s 
    Click Element    xpath: //a[contains(text(), "${menu}")]
    Wait Until Loader Is Visible


Click Create Button
    [Arguments]     ${label}
    [Documentation]   Click on create button by label given in parameter
    Wait Until Element Is Visible    xpath: //*/button[contains(text(), "${label}")]       60s
    Click Button   xpath: //*/button[contains(text(), "${label}")]
    Wait Until Loader Is Visible

Fill Role Creation Form
    [Arguments]    ${file}
    [Documentation]    Fill Role Creation Form, data read from external file
    ${contentLine}  Set Variable  ${EMPTY}
    ${ROLE.NAME}  Set Variable  ${EMPTY}
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}    0
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
        Log to console    ${contentLine}
        IF    '${contentLine}[0]' == 'Name'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[1]/div/div[2]/div[1]/div/div[2]/input    30s
            Input Text    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[1]/div/div[2]/div[1]/div/div[2]/input    ${contentLine}[1]
            ${ROLE.NAME}  Set Variable  ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'Description'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[1]/div/div[2]/div[2]/div/div[2]/textarea    30s
            Input Text    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[1]/div/div[2]/div[2]/div/div[2]/textarea    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'Default Screen'
            Wait Until Element Is Visible    xpath: //*[contains(text(), "Choisissez un écran d'en-tête")]     10s
            Click Element    xpath: //*[contains(text(), "Choisissez un écran d'en-tête")]
			Sleep    1s
            Wait Until Element Is Visible    xpath: //*[contains(text(), "${contentLine}[1]")]     10s
            Click Element    xpath: //*[contains(text(), "${contentLine}[1]")]
        END
        IF    '${contentLine}[0]' == 'Access Policy'
            Wait Until Element Is Visible    xpath: //*[contains(text(), "Sélectionnez une politique d'accès")]     10s
            # Si c'est en anglis --> Click Element    xpath: //*[contains(text(), 'Select Access Policy')]
            Click Element    xpath: //*[contains(text(), "Sélectionnez une politique d'accès")]
            Sleep    1s
            #Wait Until Element Is Visible    xpath: /html/body/div[10]/div/div/div    10s
            Click Element    //*[contains(text(), "${contentLine}[1]")]
        END
        IF    '${contentLine}[0]' == 'Organisation'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[2]/div/div[1]/div[2]/span
            Click Element    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[2]/div/div[1]/div[2]/span
            Wait Until Element Is Visible    xpath: //*[contains(text(), "Senegal")]    120s
            Click Element    xpath: //*[@id="controls"]/div/div[2]/div[2]/div[2]/div[1]/span
            
            #Select Checkbox    xpath: //*[contains(text(), "${contentLine}[1]")]    
            Click Element    xpath: //*[contains(text(), "${contentLine}[1]")]

            Wait Until Element Is Visible    xpath: //*[@id="controls"]/div/div[2]/div[3]/button[1]     60s
            Click Button    xpath: //*[@id="controls"]/div/div[2]/div[3]/button[1]
            Wait Until Loader Is Visible
        END
		Sleep    1s
    END
    Sleep    5s
    Wait Until Element Is Enabled    xpath: //*/div/div/div/div/div[1]/div/div/div/div[2]/button     120s
    Click Element    xpath: //*/div/div/div/div/div[1]/div/div/div/div[2]/button
    Wait Until Loader Is Visible
    Wait Until Element Is Visible    xpath: //*/button/div/span[contains(text(),'Ok')]     120s
    Click Element    xpath: //*/button/div/span[contains(text(),'Ok')]

    Wait Until Element Is Visible    xpath: //*/div/div/div/div/div/div/div/div/div[3]/button[contains(text(),'Close')]     60s
    Click Element    xpath: //*/div/div/div/div/div/div/div/div/div[3]/button[contains(text(),'Close')]
    Save Created Object Name In General Data File    ROLE.NAME    ${ROLE.NAME}

Save Created Object Name In General Data File
    [Arguments]     ${label}    ${role}
    [Documentation]  Save Created Object Name and value In the General Data File
    Append to file    ${GLOBALFILE}    ${label};${role}\n


Fill User Creation Form from data file
    [Arguments]    ${file}
    [Documentation]   Fill User Creation Form from data file
    ${contentLine}  Set Variable  ${EMPTY}
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}    1    7
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
        IF    '${contentLine}[0]' == 'firstName'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[1]/div/div[2]/input    30s
            Input Text    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[1]/div/div[2]/input    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'lastName'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[2]/div/div[2]/input    30s
            Input Text    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[2]/div/div[2]/input    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'gender'
            Select Radio Button    ${contentLine}[0]    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'language'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[4]/div/div/div[2]/div[1]   30s
            Click Element    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[4]/div/div/div[2]/div[1]
            Wait Until Element Is Visible    xpath: //*[contains(text(), "${contentLine}[1]")]     10s
            Click Element    xpath: //*[contains(text(), "${contentLine}[1]")]
        END
        IF    '${contentLine}[0]' == 'phone'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[5]/div/div[2]/input    30s
            Input text   xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div[2]/div[5]/div/div[2]/input    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'business Unit'
            Click Element    xpath: /html/body/div[1]/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/span
            Wait Until Element Is Visible    xpath: //*[contains(text(), "${contentLine}[1]")]    120s
            Click Element    xpath: //*[@id="controls"]/div/div[2]/div[2]/div[2]/div[1]/span
            
            #Select Checkbox    xpath: //*[contains(text(), "${contentLine}[1]")]    
            Click Element    xpath: //*[contains(text(), "AGENT DE RECOUVREMENT 14")]
            Wait Until Element Is Visible    xpath: //*[@id="controls"]/div/div[2]/div[3]/button[1]     60s
            Click Button    xpath: //*[@id="controls"]/div/div[2]/div[3]/button[1]
            Wait Until Loader Is Visible
        END
        
    END
    Goto User Tab and fill form  Contact info
    @{fileData} =    Split To Lines    ${contents}    7   9
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;        
        IF    '${contentLine}[0]' == 'telephone'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[2]/div/table/tbody/tr/td[4]/div/input    30s
            Input text   xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[2]/div/table/tbody/tr/td[4]/div/input    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'email'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[3]/div/table/tbody/tr/td[3]/div/input    30s
            Input text   xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div[3]/div/table/tbody/tr/td[3]/div/input    ${contentLine}[1]
        END
    END
    
    Fill Credentials    ${contents}
    Fill External Credentials
    


Fill Credentials
    [Arguments]    ${contents}
    Goto User Tab and fill form  Credentials
    @{fileData} =    Split To Lines    ${contents}    9   11
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
        Log to console    ${contentLine}
        IF    '${contentLine}[0]' == 'username'
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[1]/div[2]/div/div/div[1]/div/div/div[2]/input    30s
            Input text   xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[1]/div[2]/div/div/div[1]/div/div/div[2]/input    ${contentLine}[1]
        END
        
        IF    '${contentLine}[0]' == 'password'
            Wait Until Element Is Visible    xpath: //*[contains(text(), 'Select Access Policy')]     10s
            #Click Element    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[1]/div[2]/div/div/div[2]/div[2]/div/div/div[2]/div[1]/div[3]/div[1]/div[2]
            Click Element    xpath: //*[contains(text(), 'Select Access Policy')]
            Sleep    1s
            #Wait Until Element Is Visible    xpath: /html/body/div[10]/div/div/div    10s
            Click Element    //*[contains(text(), 'STD_input')]
            Wait Until Loader Is Visible
            Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/table/tbody/tr/td[5]/div/input    30s
            Input text   xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/table/tbody/tr/td[5]/div/input    ${contentLine}[1]
        END

    END

    
Fill External Credentials
    Goto User Tab and fill form  Contact info
    Goto User Tab and fill form    External credentials

    Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div    30s
    Click Element    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div

    Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/table/tbody/tr/td[1]/div/div[1]/div/div[3]/div[1]/div[2]    30s
    Click Element    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/table/tbody/tr/td[1]/div/div[1]/div/div[3]/div[1]/div[2]
    Wait Until Element Is Visible    xpath: //*[contains(text(),'t24/senegal')]     10s
    Click Element   xpath: //*[contains(text(),'t24/senegal')]
    Wait Until Loader Is Visible
    
    Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/table/tbody/tr/td[2]/div/div[1]/div/div[3]/div[1]/div[2]    30s
    Click Element    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/table/tbody/tr/td[2]/div/div[1]/div/div[3]/div[1]/div[2]
    Wait Until Element Is Visible    xpath: //*[contains(text(),'SOFTWAREGROUP')]     10s
    Click Element   xpath: //*[contains(text(),'SOFTWAREGROUP')]

    Wait Until Element Is Visible    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/table/tbody/tr/td[3]/div/input    30s
    Input Text    xpath: //*/div/div/div/div/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/table/tbody/tr/td[3]/div/input    SOFTWAREGROUP

    Click Element    xpath: //*/div/div/div/div/div[1]/div/div/div/div[2]/button

    Wait Until Element Is Visible    xpath: //*/button/div/span[contains(text(),'Ok')]     120s
    Click Element    xpath: //*/button/div/span[contains(text(),'Ok')]

    Wait Until Element Is Visible    xpath: //*/div/div/div/div/div/div/div/div/div[3]/button[contains(text(),'Close')]     60s
    Click Element    xpath: //*/div/div/div/div/div/div/div/div/div[3]/button[contains(text(),'Close')]

Goto User Tab and fill form
    [Arguments]    ${tabLabel}
    Click Element    xpath: //*/div/div/div/div/div/div/div/div/div/ul/li/div/div[contains(text(), "${tabLabel}")]
    Wait Until Loader Is Visible



Open Selected Role in the list
    [Arguments]   ${ID}
	[Documentation]   Open Selected Role in the list
    ${path}  Set Variable  ${EMPTY}
    Wait Until Element Is Visible    xpath: /html/body/div[1]/div/div/div/div[4]/div/div[2]/div/div[2]/div/div/div/div[3]/table/tbody/tr/td[2]/a    60s
    ${allElements} =    Get WebElements    xpath: /html/body/div[1]/div/div/div/div[4]/div/div[2]/div/div[2]/div/div/div/div[3]/table/tbody/tr/td[2]/a
	${i}     Set Variable    1
	FOR    ${element}    IN    @{allElements}
        ${text}=    Get Text    ${element}
        IF    '${text}' == '${ID}'
            ${path}    Set Variable   /html/body/div[1]/div/div/div/div[4]/div/div[2]/div/div[2]/div/div/div/div[3]/table/tbody/tr[${i}]/td[3]
        END
		${i} =    Evaluate    ${i}+1
    END
	Click Element    xpath: ${path}
	#Log to console    ${path}
    Wait Until Loader Is Visible


Make a Decision in Selected Role
    [Arguments]    ${action}
    [Documentation]    Make a Decision in Selected Role (Approve, Reject or Cancel)
    Sleep    2s
	Click on Button by label  View Details
	Sleep    5s
    Click on Button by label  ${action}


Click on Button by label
    [Arguments]    ${label}
	[Documentation]    Click on Button by given label 
    Wait Until Element Is Visible    xpath: //*/button[contains(text(), "${label}")]    120s
    Click Element    xpath: //*/button[contains(text(), "${label}")]

Search Role By Name
    [Arguments]     ${roleName}
	[Documentation]    Search Roles By Name
    Wait Until Element is Visible and Input Textfield    xpath: //*[@id="roleContent"]/div/div/div/div[1]/div/div/div/div[2]/div/div[3]/div/div/div/div[1]/input    ${roleName}
    Press Keys    xpath: //*[@id="roleContent"]/div/div/div/div[1]/div/div/div/div[2]/div/div[3]/div/div/div/div[1]/input    RETURN
    Wait Until Loader Is Visible

Wait Until Element is Visible and Input Textfield
    [Arguments]    ${element}    ${value}
    [Documentation]   Wait Until Element is Visible and Input Textfield
    Wait Until Element Is Visible   ${element}    120s
    Input Text    ${element}    ${value}
    Sleep    1s

Read general file and prepare data to use
    [Arguments]  ${file}    ${label}
	[Documentation]   Read general file and prepare data to use in the test Cases. the file general_admin.csv located in directory TestData is used. All rows with given label will be selected and their values collected as IDs LA for the test cases
    ${contentLine}  Set Variable  ${EMPTY}
    ${LA.IDs}  Set Variable  ${EMPTY}
    ${contents} =    Get File    ${file}
    ${index} =  Set Variable  ${0}
    @{fileData} =    Split To Lines    ${contents}  3
    FOR    ${line}    IN    @{fileData}
        ${index} =   Evaluate    ${index}+1
        @{contentLine} =    Split String    ${line}    ;
        IF    '${contentLine}[0]' == '${label}'
            IF  '${LA.IDs}' == '${EMPTY}'
                ${LA.IDs}  Set Variable   ${contentLine}[1]
            ELSE
                ${LA.IDs}  Set Variable  ${LA.IDs},${contentLine}[1]
            END
        END
    END
    ${LA.IDs} =   Split String  ${LA.IDs}   ,
    [return]  ${LA.IDs}
	
Reject Role And Input Reason and submit
	Wait Until Element Is Visible    xpath: //*[@id="controls"]/div/div[2]/div[3]/button[1]    20s
	Click Element    xpath: //*[@id="controls"]/div/div[2]/div[3]/button[1]
	Sleep    2s
	Wait Until Element Is Visible    xpath: //*[@id="controls"]/div/div[2]/div[2]/div/div/div[2]/textarea    120s
	Input Text    xpath: //*[@id="controls"]/div/div[2]/div[2]/div/div/div[2]/textarea     Motif de rejet
	Sleep    2s
	Click on Button by label    Submit
	Wait Until Loader Is Visible
