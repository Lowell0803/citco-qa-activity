*** Settings ***
Variables    ../Library/locators.py
Library      SeleniumLibrary
Library      Dialogs
Library      ../Library/GetUsersInJSON.py
Resource     ../Resources/App.resource
Resource     ../Resources/Customers.resource
Library      Collections
Library      String
Suite Setup     Open Browser    ${BASE_URL}    ${BROWSER}
Suite Teardown  Close All Browsers

*** Variables ***
${FILENAME}    /path/to/your/file.txt
${TEXT_TO_FIND}    Robot Framework
${BROWSER}    chrome
${BASE_URL}    https://marmelab.com/react-admin-demo/#/login
${USERNAME}    demo
${PASSWORD}    securepassword.123

*** Test Cases ***
Test Case 000001
    [Documentation]    Example test case that logs in to the demo site and process first 5 users
    Login To Browser
    ${users}=    Get Processed Users
    ${count}=    Get Length    ${users}
    ${max}=    Evaluate    min(5, ${count})
    FOR    ${i}    IN RANGE    ${max}
        ${user}=    Get From List    ${users}    ${i}
        Go To Customers Page
        Add User From Data    ${user}
        Go to Customers Page
        Go To First Row
        Verify Customer Form Values
    END

Test Case 000002
    [Documentation]    Replace rows 6-10 with users 6-10 (simple, robust clear + wait for close)
    Go To Customers Page
    ${users}=    Get Processed Users
    ${count}=    Get Length    ${users}
    ${end}=    Evaluate    min(10, ${count})
    ${start}=    Set Variable    5
    Run Keyword If    ${end} <= ${start}    Fail    Not enough users to process (need at least 6 users)
    FOR    ${i}    IN RANGE    ${start}    ${end}
        ${user}=    Get From List    ${users}    ${i}
        Go To Customers Page
        ${row_index}=    Evaluate    ${i} + 1
        Sleep    0.5s
        Click Element    xpath=(//table)[1]//tbody//tr[${row_index}]
        Wait Until Element Is Visible    ${FIRST_NAME_FIELD}    timeout=8s
        Fill Customer Form From Edit With Clear    ${user}
        Wait Until Element Is Not Visible    ${FIRST_NAME_FIELD}    timeout=12s
        ${full_name}=    Set Variable    ${user['first_name']} ${user['last_name']}
        Wait Until Keyword Succeeds    6 times    1s    Row Contains Full Name    ${row_index}    ${full_name}
        Sleep    0.5s
    END

Test Case 000003
    Go To Customers Page
    Wait Until Element Is Visible    ${TABLE_ROWS}    timeout=10s
    ${rows}=    Get Element Count    ${TABLE_ROWS}
    ${end}=    Set Variable    ${rows}
    FOR    ${i}    IN RANGE    1    ${end}+1
        ${name}=    Get Text    ${ROW_NAME.format(index=${i})}
        ${last_seen}=    Get Text    ${ROW_LAST_SEEN.format(index=${i})}
        ${orders}=    Get Text    ${ROW_ORDERS.format(index=${i})}
        ${total_spent}=    Get Text    ${ROW_TOTAL_SPENT.format(index=${i})}
        ${latest_purchase}=    Get Text    ${ROW_LATEST_PURCHASE.format(index=${i})}
        ${td_news}=    Set Variable    ${ROW_NEWS.format(index=${i})}
        ${newsletter}=    Get Element Attribute    ${ROW_NEWS_ICON.format(index=${i})}    aria-label
        ${seg_locator}=    Set Variable    ${ROW_SEGMENTS.format(index=${i})}
        ${has_span}=    Run Keyword And Return Status    Element Should Be Visible    ${seg_locator}    timeout=0s
        IF    ${has_span}
            @{seg_elems}=    Get WebElements    ${seg_locator}
            ${seg_list}=    Create List
            FOR    ${el}    IN    @{seg_elems}
                ${txt}=    Get Text    ${el}
                Append To List    ${seg_list}    ${txt}
            END
            ${segments}=    Evaluate    ", ".join(${seg_list})
        ELSE
            ${segments}=    Set Variable    No Segment
        END
        Log To Console    ===== User ${i} =====
        ${parts}=    Split String    ${name}    \n
        ${after}=    Get From List    ${parts}    -1
        ${final}=    Strip String    ${after}
        Log To Console    ${final}
        Log To Console    Last seen: ${last_seen}
        Log To Console    Orders: ${orders}
        Log To Console    Total spent: ${total_spent}
        Log To Console    Latest purchase: ${latest_purchase}
        Log To Console    News.: ${newsletter}
        Log To Console    Segments: ${segments}
    END

Test Case 000004
    [Documentation]    Print all users with spending and check if total >= 3500
    Go to Customers Page
    Wait Until Element Is Visible    ${TABLE_ROWS}    timeout=10s
    ${rows} =    Get Element Count    ${TABLE_ROWS}
    ${end} =    Set Variable    ${rows}
    ${total_spending} =    Set Variable    0
    FOR    ${i}    IN RANGE    1    ${end}+1
        ${name} =    Get Text    ${ROW_NAME.format(index=${i})}
        ${parts}=    Split String    ${name}    \n
        ${after}=    Get From List    ${parts}    -1
        ${final}=    Strip String    ${after}
        ${spent_raw} =    Get Text    ${ROW_TOTAL_SPENT.format(index=${i})}
        ${spent_clean} =    Replace String    ${spent_raw}    $    ${EMPTY}
        ${spent_clean} =    Replace String    ${spent_clean}    ,    ${EMPTY}
        ${spent_clean} =    Strip String    ${spent_clean}
        ${spent_clean} =    Set Variable If    '${spent_clean}' == ''    0    ${spent_clean}
        ${spent} =    Convert To Number    ${spent_clean}
        ${total_spending} =    Evaluate    ${total_spending} + ${spent}
        IF    ${spent} > 0
            ${spent_fmt}=    Evaluate    "$" + format(float(${spent}), ',.2f')
            Log To Console    ${name}: ${spent_fmt}
        END
    END
    ${total_fmt} =    Evaluate    "$" + format(float(${total_spending}), ",.2f")
    ${threshold_fmt} =    Evaluate    "$" + format(float(3500.0), ',.2f')
    Log To Console    ======
    Log To Console    Total Customer Spending: ${total_fmt}
    Log To Console    ======
    Run Keyword If    ${total_spending} < 3500
    ...    Fail    FAIL: Total Spending (${total_fmt}) is below minimum threshold (${threshold_fmt})
    ...    ELSE
    ...    Log To Console    PASS: Total Spending (${total_fmt}) is above minimum threshold (${threshold_fmt})
    Pause Execution