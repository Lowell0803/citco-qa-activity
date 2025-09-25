*** Settings ***
Variables    ../Library/locators.py
Library    SeleniumLibrary

*** Keywords ***
Login To Browser
    Maximize Browser Window
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Dashboard    timeout=10s