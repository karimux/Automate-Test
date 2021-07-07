*** Settings ***
#to Generate the doc : libdoc TransFunctions.resource T24_Documetation.html
Documentation     T24 Framework : Test Automation documentation for T24
Library           SeleniumLibrary
Library           BuiltIn
Library           String
Library           OperatingSystem
Library			  Screenshot
Library           DateTime


*** Variables ***
${LOGIN URL}      empty
${FILIALE}        empty
${SIGNONNAME}     empty
${PASSWORD}       empty
${MENU}           empty
${BROWSER}        Chrome
${MAINPAGE}       empty
${textfieldValue}    textfieldValue


*** Keywords ***
Open T24 Browser To Login Page
    [Arguments]    ${LOGIN URL}    ${BROWSER}
	[Documentation]   Open the browser and set T24 url
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
#    Check access to page by Title    Optimal

# Input Record ID and validate search
Input search by @ID
    [Arguments]    ${textfield}    ${idRecord}
	[Documentation]   Input *transactionId* in the textfield and *submit*
    Maximize Browser Window
    Input T24 textfield    ${textfield}    ${idRecord}
    Press Keys    ${textfield}    RETURN


# Read connexion.txt file and initialize variables
Initialize Variables 2
    [Arguments]    ${file}
	[Documentation]   Read *connexion.csv* file located in *TestData/TC_0XX_TestName/connexion.csv*  and initialize global variables with *python 3 IF ELSE END*
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
        IF    '${contentLine}[0]' == 'url'
            ${LOGIN URL}    Set Variable    ${contentLine}[1]
            Log to console    url -> ${LOGIN URL}
        END
        IF    '${contentLine}[0]' == 'filiale'
            ${FILIALE}    Set Variable    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'signOnName'
            ${SIGNONNAME}    Set Variable    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'password'
            ${PASSWORD}    Set Variable    ${contentLine}[1]
        END
        IF    '${contentLine}[0]' == 'menu'
            ${MENU}    Set Variable    ${contentLine}[1]
            Log to console    menu -> ${MENU}
        END
    END    
    ${credentials}    Set Variable    ${FILIALE},${LOGIN URL},${SIGNONNAME},${PASSWORD},${MENU}
    @{data}    Split String    ${credentials}    ,
    Set Global Variable    ${data}
    [return]  ${data}


# Read connexion.txt file and initialize variables
Initialize Variables
    [Arguments]    ${file}
	[Documentation]   Read *connexion.csv* file located in *TestData/TC_0XX_TestName/connexion.csv*  and initialize global variables
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}
    FOR    ${line}    IN    @{fileData}
        @{contentLine} =    Split String    ${line}    ;
        Run Keyword If    '${contentLine}[0]' == 'url'    Set Url Variable    ${contentLine}[1]
		Run Keyword If    '${contentLine}[0]' == 'filiale'    Set Filiale Variable    ${contentLine}[1]
        Run Keyword If    '${contentLine}[0]' == 'signOnName'    Set signOnName Variable    ${contentLine}[1]
        Run Keyword If    '${contentLine}[0]' == 'password'    Set password Variable    ${contentLine}[1]
        Run Keyword If    '${contentLine}[0]' == 'menu'    Set menu Variable    ${contentLine}[1]
    END    
    ${credentials}    Set Variable    ${FILIALE},${LOGIN URL},${SIGNONNAME},${PASSWORD},${MENU}
    @{data}    Split String    ${credentials}    ,
    Set Global Variable    ${data}
    [return]  ${data}
 
Set Url Variable
	[Arguments]    ${url}
	[Documentation]   Set *T24 url* as Global Variable
	${LOGIN URL}    Set Variable    ${url}
	Set Global Variable    ${LOGIN URL}

Set Filiale Variable
	[Arguments]    ${filiale}
	[Documentation]   Set *subsidiary* as Global Variable
	${FILIALE}    Set Variable    ${filiale}
	Set Global Variable    ${FILIALE}

Set signOnName Variable
	[Arguments]    ${signOnName}
	[Documentation]   Set *sign on name* as Global Variable
	${SIGNONNAME}    Set Variable    ${signOnName}
	Set Global Variable    ${SIGNONNAME}

Set password Variable
	[Arguments]    ${password}
	[Documentation]   Set *password* as Global Variable
	${PASSWORD}    Set Variable    ${password}
	Set Global Variable    ${PASSWORD}

Set menu Variable
	[Arguments]    ${menu}
	[Documentation]   Set *menu* as Global Variable
	${MENU}    Set Variable    ${menu}
	Set Global Variable    ${MENU}

# To connect to T24 by reading the connexion.txt file
Connection To T24
    [Arguments]    ${filiale}    ${file}
	[Documentation]   Connection to T24 by reading *credentials* from *connexion.csv* file
    Read Connection Data    ${file}
    Click Button    sign-in
    #Check access to page by Title    T24 - Baobab Senegal Live
    ${MAINPAGE} =    Get Title
    Set Global Variable    ${MAINPAGE}
    Log to console    Connecté à T24 - Baobab ${filiale} Live    


Check access to page by Title
    [Arguments]    ${expectedTitle}
	[Documentation]   Check access to page by Title
    Title Should Be    ${expectedTitle}

Input T24 textfield
    [Arguments]    ${fieldname}    ${fieldvalue}
	[Documentation]   Input textfield value by giving *name, xpath, css style or id*
	Wait Until Element Is Visible    ${fieldname}   30s
	#Clear Element Text    ${fieldname}
	#Press Keys    ${fieldname}    TAB
    Input Text     ${fieldname}    ${fieldvalue}

# Openning Menu on default connection page
Goto Menu on Default Page
    [Arguments]    ${menu}
	[Documentation]   Navigate to menu in the T24 main page, *menu* is read from TestData/TC_0XX_TestName/connexion.csv on row 5
    @{menuTab} =    Split String    ${menu}    *
    Select frame    xpath: /html/frameset/frame[2]
    ${page} =    Get Title
    FOR    ${i}    IN    @{menuTab}
        Switch Window    ${page}
		Select frame    xpath: /html/frameset/frame[1]
		Switch Window    ${page}
		Select frame    xpath: /html/frameset/frame[2]
		Wait Until Element Is Enabled    xpath: //*[text() = "${i}"]     30s
        Click Element    xpath: //*[text() = "${i}"]
        #Switch Window    ${page}
        #Select frame    xpath: /html/frameset/frame[2]
        #Sleep    1s
		
    END
    Switch Window    locator=NEW

# Openning Menu after putting menu on cmd line
Goto Menu
    [Arguments]    ${menu}
	[Documentation]   Navigate to menu after putting it in the command line textfield located in the main page, *menu* is read from TestData/TC_0XX_TestName/connexion.csv on row 5
    @{menuTab} =    Split String    ${menu}    *
    #Select frame    xpath: /html/frameset/frame[2]
    ${page} =    Get Title
    FOR    ${i}    IN    @{menuTab}
        Wait Until Element Is Enabled    xpath: //*[contains(text(), "${i}")]      30s
        Click Element    xpath: //*[contains(text(), "${i}")]
        #Switch Window    ${page}
        #Select frame    xpath: /html/frameset/frame[2]
        Sleep    1s
    END
    Switch Window    locator=NEW


# This permit to tape ad validate command since input command line
Tap on command line
    [Arguments]    ${command}
	[Documentation]   Tap text *on command line* located in the main page and validate
    Select frame    xpath: /html/frameset/frame[1]
    Input T24 textfield  commandValue  ${command}
    Press Keys    commandValue    RETURN
    Sleep    2s
    Switch Window    locator=NEW


# Read The connexion.txt file and get credentials
Read Connection Data
    [Arguments]    ${file}
	[Documentation]   Read T24 connection data from the file *TestData/TC_0XX_TestName/connexion.csv* on line 2 to 4
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}    2    4
    FOR    ${line}    IN    @{fileData}
        Log to console    ${line}
        @{contentLine} =    Split String    ${line}    ;
        Input T24 textfield    ${contentLine}[0]  ${contentLine}[1]
    END

# This permit to Open the window from the menu
# It read the file containing credentials and also menu to open
Select Menu
    [Arguments]    ${file}
	[Documentation]  Select menu from *TestData/TC_0XX_TestName/connexion.csv* on line *5*
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}    3   4
    FOR    ${line}    IN    @{fileData}
        ${menu} =    Get Substring    ${line}    5
        ${labelMenu} =    Get Substring    ${line}    0    4
        @{contentLine} =    Split String    ${menu}    ;
        IF    '${labelMenu}' == 'menu'
            Goto Menu    ${menu}
        ELSE
            Log to console  Can not access to the main
        END

    END


# To disconnect correctly in T24
Disconnect to T24
	[Documentation]  Disconnect to T24
    Switch Window    ${MAINPAGE}
    Select frame    xpath: /html/frameset/frame[1]
    Wait Until Element Is Visible    xpath: /html/body/div[3]/div[1]/table/tbody/tr/td[3]
    Click Element    xpath: /html/body/div[3]/div[1]/table/tbody/tr/td[3]
    Sleep    2s

# Method Choose Action make a click on button
# Available actions are : 
#   - New Deal, 
#   - View a contract, 
#   - Edit a contract, 
#   - Perform an action on the contract, 
#   - Return to application screen, 
#   - Verifies a deal, 
#   - Reverses a deal from the live file, 
#   - Authorises a deal, 
#   - Deletes a Deal, 
#   - Place a contract on Hold,
#   - Validate a deal,
#   - Commit the deal,
#   - Place a contract on Hold,
 
Choose Action with Input
    [Arguments]    ${input}    ${action}
	[Documentation]  Make a click on an action button after putting transactionId, possible actions or button's title available are : *New Deal, View a contract, Edit a contract, Perform an action on the contract, Return to application screen, Verifies a deal, Reverses a deal from the live file, Authorises a deal, Deletes a Deal, Place a contract on Hold, Validate a deal, Commit the deal, Place a contract on Hold*
    Maximize Browser Window
    ${page} =    Get Title
    Wait Until Element Is Visible    xpath: /html/body/div[3]/div[2]/form[1]/div[2]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/input[1]     30s
    Input T24 textfield    xpath: /html/body/div[3]/div[2]/form[1]/div[2]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/input[1]    ${input}
    #Switch Window    locator=NEW
    Log to console    access to page ${page}
    Click Image    xpath://img[@alt="${action}"]
	#IF    '${check}' == 'True'
	#	Handle Alert   ACCEPT
	#END
	

Choose Action
    [Arguments]    ${action}
	[Documentation]  Directlty make a click on an action button, possible actions or button's title available are : *New Deal, View a contract, Edit a contract, Perform an action on the contract, Return to application screen, Verifies a deal, Reverses a deal from the live file, Authorises a deal, Deletes a Deal, Place a contract on Hold, Validate a deal, Commit the deal, Place a contract on Hold*
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://img[@alt="${action}"]    30s
    #Switch Window    locator=NEW
    ${page} =    Get Title
    Log to console    access to page ${page}
    Click Image    xpath://img[@alt="${action}"]
	Sleep   2s
	${check} =    Run Keyword And Return Status    Alert Should Be Present
	#IF    "${check}"=="True"
	#	Handle Alert   ACCEPT
	#END
	Wait Until T24 Processing Is Visible
	Accept Override
	Wait Until T24 Processing Is Visible
    #Wait Until T24 Processing Is Visible

# This method is used to retrieve the datasets from a file and to fill in the form.
Read File and Fill input
    [Arguments]    ${file}
	[Documentation]  This method is used to retrieve the datasets from a file and to fill in the form.
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}
    ${lastTab}    Set Variable    default
    FOR    ${line}    IN    @{fileData}
		Wait Until T24 Processing Is Visible
        Log to console    ${line}
        @{contentLine} =    Split String    ${line}    ;
        IF    '${contentLine}[0]' == '${lastTab}'
            IF     '${contentLine}[1]' == 'textfield'
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Clear Element Text     ${contentLine}[2]
				Input T24 textfield    ${contentLine}[2]  ${contentLine}[3]
                Press Keys    ${contentLine}[2]    TAB
            END
            IF     '${contentLine}[1]' == 'dropdownlist'
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Select From List By Label    ${contentLine}[2]    ${contentLine}[3]
            END
            IF     "${contentLine}[1]" == "radiobutton"
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Log to console    \n\n\nradiobutton -> ${contentLine}[2]\n\n
                Select Radio Button    ${contentLine}[2]    ${contentLine}[3]
            END
			IF     "${contentLine}[1]" == "checkbox"
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Select Checkbox    ${contentLine}[2]
            END
        ELSE
            ${lastTab}    Set Variable    ${contentLine}[0]
            Click Element    xpath: //*[contains(text(), '${contentLine}[0]')]
            IF     '${contentLine}[1]' == 'textfield'
                Wait Until Element Is Visible    ${contentLine}[2]    30s
				Clear Element Text     ${contentLine}[2]
                Input T24 textfield    ${contentLine}[2]  ${contentLine}[3]
                Press Keys    ${contentLine}[2]    TAB
            END
			IF     "${contentLine}[1]" == "radiobutton"
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Log to console    \n\n\nradiobutton -> ${contentLine}[2]\n\n
                Select Radio Button    ${contentLine}[2]    ${contentLine}[3]
            END
			IF     '${contentLine}[1]' == 'dropdownlist'
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Select From List By Label    ${contentLine}[2]    ${contentLine}[3]
            END
			IF     "${contentLine}[1]" == "checkbox"
                Wait Until Element Is Visible    ${contentLine}[2]     30s
                Select Checkbox    ${contentLine}[2]
            END
        END
		Sleep    1s
    END

Get transactionId to create
	[Documentation]  Get *transactionId* to create before filling form (on New Deal or Opening existing Record)
    Wait Until Element Is Visible    xpath: //*[@id="toolBar"]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/span    30s
    ${transactionId} =     Get Text    xpath: //*[@id="toolBar"]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/span
    Log to console    ${transactionId}
	[Return]  ${transactionId}

Get transactionId created
	[Documentation]  Get *transactionId* created after commiting transaction
    Wait Until Element Is Visible    xpath: //*[@id="messages"]/tbody/tr[2]/td[2]/table[2]/tbody/tr/td    30s
    ${messageAfter} =     Get Text    xpath: //*[@id="messages"]/tbody/tr[2]/td[2]/table[2]/tbody/tr/td
    Log to console    ${messageAfter}
    @{mots} =    Split String    ${messageAfter}
#    Log to console    @{mots}[2]
    [Return]  ${mots}[2]

Select data in Global File
    [Arguments]    ${file}    ${label}
	[Documentation]  Select *Data* to use in test case from the *data.csv* global file
    ${dataValue}  Set Variable    ${EMPTY}
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}
    FOR    ${line}    IN    @{fileData}
        Log to console    ${line}
        @{contentLine} =    Split String    ${line}    ;
        IF    "${contentLine}[0]" == "${label}"
            ${dataValue}    Set Variable    ${contentLine}[1]    
        END
    END
    [return]  ${dataValue}


Enquiry for Loan application
    [Arguments]    ${file}    ${label}    ${LabelID}
	[Documentation]   Use to fill the enquiry textfield search, need file, label from the data file, and label identifier (labelID) to search in the data.csv file
    Clear Filter
	${RECORD.ID} =    Select data in Global File    ${file}    ${LabelID}
	${pathToInput}    Enquiry Select textfield to input    ${label}
	Input T24 textfield    xpath: ${pathToInput}    ${RECORD.ID}
    Press Keys    xpath: ${pathToInput}    RETURN
	Wait Until T24 Processing Is Visible

Enquiry Select textfield to input
	[Arguments]    ${label}
	[Documentation]   In the enquiry interface fill the right search input field by the given label or textfield name
	${allElements} =    Get WebElements    xpath: //*[@id="selectiondisplay"]/tbody/tr/td/span
	${i}     Set Variable    1
	FOR    ${element}    IN    @{allElements}
        ${text}=    Get Text    ${element}
		Log to console    Element ${i} = ${text}
        #@{contentLine} =    Split String    ${line}    ;
        IF    "${text}" == "${label}"
            ${path}    Set Variable    //*[@id="selectiondisplay"]/tbody/tr[${i}]/td[3]/input
        END
		${i} =    Evaluate    ${i}+1
    END
	Log to console    ${path}
	[return]  ${path}
	
	

Overdue Get Amount To pay
	[Arguments]    ${element}
	[Documentation]   For overdue Repayment Get the amount to pay
	Wait Until Element Is Visible    ${element}  30s
	${amountToPay} =    Get Text    ${element}
	[return]   ${amountToPay}
	
Get Today Date
	[Documentation]   Get T24 today date
	Switch Window    ${MAINPAGE}
	Tap on command line    DATES L
	Switch Window    DATES - Default List
	Wait Until Element Is Visible    xpath: //*[@id="r1"]/td[3]   30s
	${today} =     Get Text    xpath: //*[@id="r1"]/td[3]
	Log to Console    TODAY -> ${today}
	Close Window
	[return]    ${today}
	
Accept Override
	[Documentation]   Accept Override while hyperlink is visible
	Sleep   2s
	${override}    Set Variable    ${EMPTY}
	#${i}    Set Variable    0
	FOR    ${i}    IN RANGE    5
		#${override}=    Run Keyword And Return Status    Page Should Contain Element    xpath: //*[contains(text(), 'Accept Overrides')]
		${override}=    Run Keyword And Return Status    Page Should Contain Link    xpath: //*[contains(text(), 'Accept Overrides')]
		Log to console    ${i}->${override}\n
		IF    '${override}'=='True'
			Click Element    xpath: //*[contains(text(), 'Accept Overrides')]
			${check} =    Run Keyword And Return Status    Alert Should Be Present
		#ELSE
		#	${check} =    Run Keyword And Return Status    Page Should Contain Element    xpath://img[@alt="Commit the deal"]
		#	IF    '${check}'=='True'
		#		Choose Action    Commit the deal
		#	END
		END
		#${out} =    Run Keyword And Return Status    Should Not Be True    '${override}'=='True'
	   Exit For Loop If    '${override}'!= 'True'
    END

Adjust PD penalities
	[Documentation]    Set value for PD penalities, implementation not finished yet
	${test}    Set Variable    ${EMPTY}
	${elements}    Set Variable    ['PE','PS']
	${test}=    Run Keyword And Return Status    Page Should Contain Element    //span[contains(text(), 'PS')]
	IF    '${test}'=='True'
		Input T24 textfield    
		${test}    Set Variable    ${EMPTY}
	END
	
Get Current First Payment Date
	[Documentation]    Get First Payment Date of a loan
	Wait Until Element Is Visible    fieldName:FIRST.PAYM.DATE    30s
	${date} =   Get Element Attribute    fieldName:FIRST.PAYM.DATE    value
	[return]  ${date}

Add n days to Date
	[Arguments]    ${date}    ${nbDays}
	[Documentation]   Add number of monter to given date (in format %d %b %Y Exemple : 22 MAY 2022). Result is in format %Y%m%d 20220522.
	${date} =    Convert Date    ${date}    date_format=%d %b %Y
	${date} =    Add Time To Date    ${date}   ${nbDays} days      result_format=%Y%m%d
	[return]    ${date}

Prepare Next Installment Date
	[Arguments]    ${maturityDate}
	${today} =    Get Current Date    result_format=%Y%m%d
	${today} =    Get Substring    ${today}    0    6
	${today} =    Evaluate    ${today}+1
	${day} =    Get Substring    ${maturityDate}    6    8
	${today}    Set Variable    ${today}${day}
	[return]    ${today}
	
Wait Until T24 Processing Is Visible
	[Documentation]
	Wait Until Element Is Not Visible    xpath: //*[@id="processingPage"]/img       600s
	Sleep    2s
	
	
Reschedule Select right LD to Auth
	[Arguments]     ${LD.ID}
	${allElements} =    Get WebElements    xpath: /html/body/div[3]/div/form/div/table/tbody/tr[2]/td[2]/div[2]/div/table/tbody/tr/td[1]
	${i}     Set Variable    1
	FOR    ${element}    IN    @{allElements}
		Log to console    ${element}
        ${text}=    Get Text    ${element}
        IF    "${text}" == "${LD.ID}"
            Click Element    xpath: /html/body/div[3]/div/form/div/table/tbody/tr[2]/td[2]/div[2]/div/table/tbody/tr[${i}]/td[11]/a
			#${path}    Set Variable    //*[@id="selectiondisplay"]/tbody/tr[${i}]/td[3]/input
        END
		Exit For Loop IF    '${text}' == '${LD.ID}'
		${i} =    Evaluate    ${i}+1
    END
	

Clear Filter
	Wait Until Element Is Visible    xpath: //*[contains(text(), "clear selection")]     60s
	Click Element    xpath: //*[contains(text(), "clear selection")]
	Sleep    1s
	
	