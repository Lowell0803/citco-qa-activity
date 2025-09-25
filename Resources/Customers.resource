*** Settings ***
Variables    ../Library/locators.py
Library      ../Library/GetUsersInJSON.py
Library      SeleniumLibrary
Library      Collections
Library      String

*** Keywords ***
Go to Customers Page
    [Documentation]    Go to Customers Page, open menu if needed
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CUSTOMERS_LINK}    timeout=10s
    Run Keyword If    not ${status}    Click Element    ${MENU_CUSTOMERS}
    Run Keyword If    not ${status}    Wait Until Element Is Visible    ${CUSTOMERS_LINK}    timeout=10s
    Click Element    ${CUSTOMERS_LINK}

Add User
    Go To Customers Page
    Wait Until Element Is Visible    ${CREATE_LINK}    timeout=10s
    Click Element    ${CREATE_LINK}
    ${users}=    Get Processed Users
    ${first_user}=    Get From List    ${users}    0
    Fill Customer Form    ${first_user}

Add User From Data
    [Arguments]    ${user}
    Wait Until Element Is Visible    ${CREATE_LINK}    timeout=10s
    Click Element    ${CREATE_LINK}
    Fill Customer Form    ${user}

Fill Customer Form
    [Arguments]    ${user}
    Wait Until Location Contains    customers/create
    ${first_name}=    Get From Dictionary    ${user}    first_name
    ${last_name}=    Get From Dictionary    ${user}    last_name
    ${email}=    Get From Dictionary    ${user}    email
    ${birthday}=    Get From Dictionary    ${user}    birthday
    ${address}=    Get From Dictionary    ${user}    address
    ${city}=    Get From Dictionary    ${user}    city
    ${state}=    Get From Dictionary    ${user}    state
    ${zipcode}=    Get From Dictionary    ${user}    zipcode
    ${password}=    Get From Dictionary    ${user}    password
    Set Test Variable    ${FIRST_NAME}    ${first_name}
    Set Test Variable    ${LAST_NAME}    ${last_name}
    Set Test Variable    ${EMAIL}    ${email}
    Set Test Variable    ${BIRTHDAY}    ${birthday}
    Set Test Variable    ${ADDRESS}    ${address}
    Set Test Variable    ${CITY}    ${city}
    Set Test Variable    ${STATE}    ${state}
    Set Test Variable    ${ZIPCODE}    ${zipcode}
    Set Test Variable    ${PASSWORD}    ${password}
    Set Test Variable    ${CONFIRM_PASSWORD}    ${password}
    Wait Until Element Is Visible    ${FIRST_NAME_FIELD}
    Input Text    ${FIRST_NAME_FIELD}    ${FIRST_NAME}
    Input Text    ${LAST_NAME_FIELD}    ${LAST_NAME}
    Input Text    ${EMAIL_FIELD}    ${EMAIL}
    Input Text    ${BIRTHDAY_FIELD}    ${BIRTHDAY}
    Input Text    ${ADDRESS_FIELD}    ${ADDRESS}
    Input Text    ${CITY_FIELD}    ${CITY}
    Input Text    ${STATE_FIELD}    ${STATE}
    Input Text    ${ZIP_FIELD}    ${ZIPCODE}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Input Text    ${CONFIRM_FIELD}    ${CONFIRM_PASSWORD}
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}
    Click Button    ${SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CREATED_MSG}
    Log To Console    Added user: ${FIRST_NAME} ${LAST_NAME} (${EMAIL})

Fill Customer Form From Edit With Clear
    [Arguments]    ${user}
    ${first_name}=    Get From Dictionary    ${user}    first_name
    ${last_name}=    Get From Dictionary    ${user}    last_name
    ${email}=    Get From Dictionary    ${user}    email
    ${birthday}=    Get From Dictionary    ${user}    birthday
    ${address}=    Get From Dictionary    ${user}    address
    ${city}=    Get From Dictionary    ${user}    city
    ${state}=    Get From Dictionary    ${user}    state
    ${zipcode}=    Get From Dictionary    ${user}    zipcode
    ${password}=    Get From Dictionary    ${user}    password
    Set Test Variable    ${FIRST_NAME}    ${first_name}
    Set Test Variable    ${LAST_NAME}    ${last_name}
    Set Test Variable    ${EMAIL}    ${email}
    Set Test Variable    ${BIRTHDAY}    ${birthday}
    Set Test Variable    ${ADDRESS}    ${address}
    Set Test Variable    ${CITY}    ${city}
    Set Test Variable    ${STATE}    ${state}
    Set Test Variable    ${ZIPCODE}    ${zipcode}
    Set Test Variable    ${PASSWORD}    ${password}
    Set Test Variable    ${CONFIRM_PASSWORD}    ${PASSWORD}
    Clear Field Robust    ${FIRST_NAME_FIELD}
    Input Text    ${FIRST_NAME_FIELD}    ${FIRST_NAME}
    Clear Field Robust    ${LAST_NAME_FIELD}
    Input Text    ${LAST_NAME_FIELD}    ${LAST_NAME}
    Clear Field Robust    ${EMAIL_FIELD}
    Input Text    ${EMAIL_FIELD}    ${EMAIL}
    Clear Field Robust    ${BIRTHDAY_FIELD}
    Clear Field Robust    ${ADDRESS_FIELD}
    Input Text    ${ADDRESS_FIELD}    ${ADDRESS}
    Clear Field Robust    ${CITY_FIELD}
    Input Text    ${CITY_FIELD}    ${CITY}
    Clear Field Robust    ${STATE_FIELD}
    Input Text    ${STATE_FIELD}    ${STATE}
    Clear Field Robust    ${ZIP_FIELD}
    Input Text    ${ZIP_FIELD}    ${ZIPCODE}
    Clear Field Robust    ${PASSWORD_FIELD}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Sleep    0.5s
    Clear Field Robust    ${CONFIRM_FIELD}
    Input Text    ${CONFIRM_FIELD}    ${CONFIRM_PASSWORD}
    Input Text    ${BIRTHDAY_FIELD}    ${BIRTHDAY}
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}
    Click Button    ${SUBMIT_BUTTON}
    ${updated_ok}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${UPDATED_MSG}    timeout=10s
    Run Keyword If    not ${updated_ok}    Wait Until Page Contains Element    ${CREATED_MSG}    timeout=10s
    Log To Console    Added/Updated user: ${FIRST_NAME} ${LAST_NAME} (${EMAIL})

Fill Customer Form From Edit
    [Arguments]    ${user}
    ${first_name}=    Get From Dictionary    ${user}    first_name
    ${last_name}=    Get From Dictionary    ${user}    last_name
    ${email}=    Get From Dictionary    ${user}    email
    ${birthday}=    Get From Dictionary    ${user}    birthday
    ${address}=    Get From Dictionary    ${user}    address
    ${city}=    Get From Dictionary    ${user}    city
    ${state}=    Get From Dictionary    ${user}    state
    ${zipcode}=    Get From Dictionary    ${user}    zipcode
    ${password}=    Get From Dictionary    ${user}    password
    Set Test Variable    ${FIRST_NAME}    ${first_name}
    Set Test Variable    ${LAST_NAME}    ${last_name}
    Set Test Variable    ${EMAIL}    ${email}
    Set Test Variable    ${BIRTHDAY}    ${birthday}
    Set Test Variable    ${ADDRESS}    ${address}
    Set Test Variable    ${CITY}    ${city}
    Set Test Variable    ${STATE}    ${state}
    Set Test Variable    ${ZIPCODE}    ${zipcode}
    Set Test Variable    ${PASSWORD}    ${password}
    Set Test Variable    ${CONFIRM_PASSWORD}    ${PASSWORD}
    Input Text    ${FIRST_NAME_FIELD}    ${FIRST_NAME}
    Input Text    ${LAST_NAME_FIELD}    ${LAST_NAME}
    Input Text    ${EMAIL_FIELD}    ${EMAIL}
    Input Text    ${BIRTHDAY_FIELD}    ${BIRTHDAY}
    Input Text    ${ADDRESS_FIELD}    ${ADDRESS}
    Input Text    ${CITY_FIELD}    ${CITY}
    Input Text    ${STATE_FIELD}    ${STATE}
    Input Text    ${ZIP_FIELD}    ${ZIPCODE}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Sleep    0.5s
    Input Text    ${CONFIRM_FIELD}    ${CONFIRM_PASSWORD}
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}
    Click Button    ${SUBMIT_BUTTON}
    ${updated_ok}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${UPDATED_MSG}    timeout=10s
    Run Keyword If    not ${updated_ok}    Wait Until Page Contains Element    ${CREATED_MSG}    timeout=10s
    Log To Console    Added/Updated user: ${FIRST_NAME} ${LAST_NAME} (${EMAIL})

Go To First Row
    [Arguments]    ${timeout}=10
    ${full_name}=    Set Variable    ${FIRST_NAME} ${LAST_NAME}
    FOR    ${i}    IN RANGE    ${timeout}
        Sleep    1s
        ${row_text}=    Get Text    ${FIRST_TABLE_ROW}
        ${is_present}=    Run Keyword And Return Status    Should Contain    ${row_text}    ${full_name}
        Run Keyword If    ${is_present}    Click Element    ${FIRST_TABLE_ROW}
        Run Keyword If    ${is_present}    Return From Keyword
    END
    Fail    Row with '${full_name}' did not appear in the first row within ${timeout} seconds

Verify Customer Form Values
    [Documentation]    Verify input fields match test variables created by Fill Customer Form.
    Wait Until Element Is Visible    ${FIRST_NAME_FIELD}    timeout=5s
    ${actual_first}=    Get Value    ${FIRST_NAME_FIELD}
    ${actual_first}=    Strip String    ${actual_first}
    ${expected_first}=    Strip String    ${FIRST_NAME}
    Should Be Equal As Strings    ${actual_first}    ${expected_first}    First name mismatch: expected '${expected_first}' but got '${actual_first}'
    Wait Until Element Is Visible    ${LAST_NAME_FIELD}    timeout=5s
    ${actual_last}=    Get Value    ${LAST_NAME_FIELD}
    ${actual_last}=    Strip String    ${actual_last}
    ${expected_last}=    Strip String    ${LAST_NAME}
    Should Be Equal As Strings    ${actual_last}    ${expected_last}    Last name mismatch: expected '${expected_last}' but got '${actual_last}'
    Wait Until Element Is Visible    ${EMAIL_FIELD}    timeout=5s
    ${actual_email}=    Get Value    ${EMAIL_FIELD}
    ${actual_email}=    Strip String    ${actual_email}
    ${expected_email}=    Strip String    ${EMAIL}
    Should Be Equal As Strings    ${actual_email}    ${expected_email}    Email mismatch: expected '${expected_email}' but got '${actual_email}'
    Wait Until Element Is Visible    ${BIRTHDAY_FIELD}    timeout=5s
    ${actual_bday}=    Get Value    ${BIRTHDAY_FIELD}
    ${actual_bday}=    Strip String    ${actual_bday}
    ${expected_bday}=    Strip String    ${BIRTHDAY}
    ${expected_iso}=    Evaluate    ("${expected_bday}"[4:8] + "-" + "${expected_bday}"[0:2] + "-" + "${expected_bday}"[2:4]) if (len("${expected_bday}") == 8 and "${expected_bday}".isdigit()) else "${expected_bday}"
    Should Be Equal As Strings    ${actual_bday}    ${expected_iso}    Birthday mismatch: expected '${expected_iso}' but got '${actual_bday}'
    Wait Until Element Is Visible    ${ADDRESS_FIELD}    timeout=5s
    ${actual_address}=    Get Value    ${ADDRESS_FIELD}
    ${actual_address}=    Strip String    ${actual_address}
    ${expected_address}=    Strip String    ${ADDRESS}
    Should Be Equal As Strings    ${actual_address}    ${expected_address}    Address mismatch: expected '${expected_address}' but got '${actual_address}'
    Wait Until Element Is Visible    ${CITY_FIELD}    timeout=5s
    ${actual_city}=    Get Value    ${CITY_FIELD}
    ${actual_city}=    Strip String    ${actual_city}
    ${expected_city}=    Strip String    ${CITY}
    Should Be Equal As Strings    ${actual_city}    ${expected_city}    City mismatch: expected '${expected_city}' but got '${actual_city}'
    Wait Until Element Is Visible    ${STATE_FIELD}    timeout=5s
    ${actual_state}=    Get Value    ${STATE_FIELD}
    ${actual_state}=    Strip String    ${actual_state}
    ${expected_state}=    Strip String    ${STATE}
    Should Be Equal As Strings    ${actual_state}    ${expected_state}    State mismatch: expected '${expected_state}' but got '${actual_state}'
    Wait Until Element Is Visible    ${ZIP_FIELD}    timeout=5s
    ${actual_zip}=    Get Value    ${ZIP_FIELD}
    ${actual_zip}=    Strip String    ${actual_zip}
    ${expected_zip}=    Strip String    ${ZIPCODE}
    Should Be Equal As Strings    ${actual_zip}    ${expected_zip}    Zipcode mismatch: expected '${expected_zip}' but got '${actual_zip}'
    Wait Until Element Is Visible    ${PASSWORD_FIELD}    timeout=5s
    ${actual_pwd}=    Get Value    ${PASSWORD_FIELD}
    ${actual_pwd}=    Strip String    ${actual_pwd}
    ${expected_pwd}=    Strip String    ${PASSWORD}
    Should Be Equal As Strings    ${actual_pwd}    ${expected_pwd}    Password mismatch
    Wait Until Element Is Visible    ${CONFIRM_FIELD}    timeout=5s
    ${actual_confirm}=    Get Value    ${CONFIRM_FIELD}
    ${actual_confirm}=    Strip String    ${actual_confirm}
    ${expected_confirm}=    Strip String    ${CONFIRM_PASSWORD}
    Should Be Equal As Strings    ${actual_confirm}    ${expected_confirm}    Confirm password mismatch
    Log To Console    Verification passed: form inputs match test variables.

Clear Field Robust
    [Arguments]    ${field_name}
    Press Keys    ${field_name}    CTRL+a    BACKSPACE

Row Contains Full Name
    [Arguments]    ${row_index}    ${full_name}
    ${row_text}=    Get Text    xpath=(//table)[1]//tbody//tr[${row_index}]
    Should Contain    ${row_text}    ${full_name}