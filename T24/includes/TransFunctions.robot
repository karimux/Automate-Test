*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library           BuiltIn
Library           String
Library           OperatingSystem


*** Variables ***
${LOGIN URL}      empty
${FILIALE}        empty
${SIGNONNAME}     empty
${PASSWORD}       empty
${MENU}           empty
${BROWSER}        Chrome
${MAINPAGE}       empty
${numClient}    2548547

*** Test Cases ***
Valid Login
    #Open T24 Browser To Login Page

#    Check access to page by Title    Dashboard - T24
#    Open T24 Browser To Login Page
    #Read URL and Open Browser
    ${credentials} =    Initialize Variables    connexion.txt
    Log to console    données du fichier connexion.txt ${credentials}[0]->${credentials}[1]->${credentials}[2]->${credentials}[3]->${credentials}[4]
    Open T24 Browser To Login Page    ${credentials}[1]    ${BROWSER}
    Connection To T24    ${credentials}[0]    connexion.txt
    
    Tap on command line  ?3
    Goto Menu    ${credentials}[4]
    Input search by @ID    value:1:1:1    ${numClient}
    #Input T24 textfield    value:1:1:1    ${numClient}
    #Press Keys    value:1:1:1    RETURN
    
    #Click on the link to update data 
    Click Element    xpath: //*[@id="r1"]/td[13]/a
    
    
    Read File and Fill input    data2.csv
    
    #Choose Action  New Deal
    #Get transactionId to create

    Choose Action  Validate a deal
    Sleep    5s
    Choose Action  Commit the deal
    
    Get transactionId created

    Sleep    15s
    #Choose Action with Input  2    View a contract
    #Disconnect to T24
    
    [Teardown]    Close Browser

*** Keywords ***
Open T24 Browser To Login Page
    [Arguments]    ${LOGIN URL}    ${BROWSER}
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
#    Check access to page by Title    Optimal


# Inut Record ID and validate search
Input search by @ID
    [Arguments]    ${textfield}    ${idRecord}
    Maximize Browser Window
    Input T24 textfield    ${textfield}    ${idRecord}
    Press Keys    ${textfield}    RETURN

# Read connexion.txt file and initialize variables
Initialize Variables
    [Arguments]    ${file}
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


# To connect to T24 by reading the connexion.txt file
Connection To T24
    [Arguments]    ${filiale}    ${file}
    Read Connection Data    ${file}
    Click Button    sign-in
    Check access to page by Title    T24 - Baobab Senegal Live
    ${MAINPAGE} =    Get Title
    Set Global Variable    ${MAINPAGE}
    Log to console    Connecté à T24 - Baobab ${filiale} Live    


Check access to page by Title
    [Arguments]    ${expectedTitle}
    Title Should Be    ${expectedTitle}

Input T24 textfield
    [Arguments]    ${fieldname}    ${fieldvalue}
    Input Text     ${fieldname}    ${fieldvalue}

# Openning Menu on default connection page
Goto Menu on Default Page
    [Arguments]    ${menu}
    @{menuTab} =    Split String    ${menu}    *
    Select frame    xpath: /html/frameset/frame[2]
    ${page} =    Get Title
    FOR    ${i}    IN    @{menuTab}
        Wait Until Element Is Enabled    xpath: //*[contains(text(), "${i}")]
        Click Element    xpath: //*[contains(text(), "${i}")]
        Switch Window    ${page}
        Select frame    xpath: /html/frameset/frame[2]
        Sleep    1s
    END
    Switch Window    locator=NEW

# Openning Menu after putting menu on cmd line
Goto Menu
    [Arguments]    ${menu}
    @{menuTab} =    Split String    ${menu}    *
    #Select frame    xpath: /html/frameset/frame[2]
    ${page} =    Get Title
    FOR    ${i}    IN    @{menuTab}
        Wait Until Element Is Enabled    xpath: //*[contains(text(), "${i}")]
        Click Element    xpath: //*[contains(text(), "${i}")]
        #Switch Window    ${page}
        #Select frame    xpath: /html/frameset/frame[2]
        Sleep    1s
    END
    Switch Window    locator=NEW


# This permit to tape ad validate command since input command line
Tap on command line
    [Arguments]    ${command}
    Select frame    xpath: /html/frameset/frame[1]
    Input T24 textfield  commandValue  ${command}
    Press Keys    commandValue    RETURN
    Sleep    2s
    Switch Window    locator=NEW


# Read The connexion.txt file and get credentials
Read Connection Data
    [Arguments]    ${file}
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
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}    3   4
    FOR    ${line}    IN    @{fileData}
        ${menu} =    Get Substring    ${line}    5
        ${labelMenu} =    Get Substring    ${line}    0    4
        @{contentLine} =    Split String    ${menu}    ;
        IF    '${labelMenu}' == 'menu'
            Log to console    Main found
            Goto Menu    ${menu}
        ELSE
            Log to console  Can not access to the main
        END

    END

Test Create Json
    [Arguments]    ${key}    ${value}
    ${req_dict}    Create Dictionary    textfieldName=${key}    textfieldValue=${value}
    Log To Console    \n*** DICTIONARY ***
    Log To Console    ${req_dict}


# To disconnect correctly in T24
Disconnect to T24
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
    Maximize Browser Window
    ${page} =    Get Title
    Log to console    Maintenant je dois saisir linput
    #Select Window    ${page}
    Wait Until Element Is Visible    xpath: /html/body/div[3]/div[2]/form[1]/div[2]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/input[1]
    Input T24 textfield    xpath: /html/body/div[3]/div[2]/form[1]/div[2]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/input[1]    ${input}
    #Switch Window    locator=NEW
    Log to console    access to page ${page}
    Click Image    xpath://img[@alt="${action}"]

Choose Action
    [Arguments]    ${action}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://img[@alt="${action}"]
    #Switch Window    locator=NEW
    ${page} =    Get Title
    Log to console    access to page ${page}
    Click Image    xpath://img[@alt="${action}"]
    Sleep    1s

# This method is used to retrieve the datasets from a file and to fill in the form.
Read File and Fill input
    [Arguments]    ${file}
    ${contents} =    Get File    ${file}
    @{fileData} =    Split To Lines    ${contents}
    ${lastTab}    Set Variable    default
    FOR    ${line}    IN    @{fileData}
        Log to console    ${line}
        @{contentLine} =    Split String    ${line}    ;
        IF    '${contentLine}[0]' == '${lastTab}'
            IF     '${contentLine}[1]' == 'textfield'
                Wait Until Element Is Visible    ${contentLine}[2]
                Input T24 textfield    ${contentLine}[2]  ${contentLine}[3]
                Press Keys    ${contentLine}[2]    TAB
            END
            IF     '${contentLine}[1]' == 'dropdownlist'
                Wait Until Element Is Visible    ${contentLine}[2]
                Select From List By Label    ${contentLine}[2]    ${contentLine}[3]
            END
            IF     '${contentLine}[1]' == 'radiobutton'
                Wait Until Element Is Visible    ${contentLine}[2]
                #Select Checkbox    ${contentLine}[1]    #${contentLine}[2]
                Select Radio Button    ${contentLine}[2]    ${contentLine}[3]
            END
        ELSE
            ${lastTab}    Set Variable    ${contentLine}[0]
            Click Element    xpath: //*[contains(text(), '${contentLine}[0]')]
            IF     '${contentLine}[1]' == 'textfield'
                Wait Until Element Is Visible    ${contentLine}[2]
                Input T24 textfield    ${contentLine}[2]  ${contentLine}[3]
                Press Keys    ${contentLine}[2]    TAB
            END
        END
    END

Get transactionId to create
    Wait Until Element Is Visible    xpath: //*[@id="toolBar"]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/span
    ${transactionId} =     Get Text    xpath: //*[@id="toolBar"]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td[2]/span
    Log to console    ${transactionId}

Get transactionId created
    Wait Until Element Is Visible    xpath: //*[@id="messages"]/tbody/tr[2]/td[2]/table[2]/tbody/tr/td
    ${messageAfter} =     Get Text    xpath: //*[@id="messages"]/tbody/tr[2]/td[2]/table[2]/tbody/tr/td
    Log to console    ${messageAfter}
    @{mots} =    Split String    ${messageAfter}
    Log to console    @{mots}[2]

Enquiry Select textfield to input
	[Arguments]    ${label}
	${test} =    Get Element Attribute    ${label}    xpath
	Log to console    ${test}
    