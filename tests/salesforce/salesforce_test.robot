*** Settings ***
Library           SeleniumLibrary

Library    ../../libraries/CustomHelpers.py
Resource    ../../resource/salesforce/salesforce_keywords.robot
Resource          ../../variables/salesforce.robot


Suite Setup       Login To Salesforce
Suite Teardown    Close Browser
Test Teardown     Run Keyword If Test Failed    Capture Page Screenshot    results/screenshots/salesforce/failure_${TEST NAME}.png

*** Test Cases ***
Salesforce Account Flow - Add, Edit, Validate
    [Documentation]    Full Salesforce UI flow: login, create, validate, edit and re-validate account
    ${ACCOUNT_NAME}=    Get Random Full Name
    ${UPDATED_NAME}=    Get Random Full Name

    Navigate To Tab Menu    Accounts
    Create New Account      ${ACCOUNT_NAME}

    Navigate To Tab Menu    Accounts
    Search and Verify Account    ${ACCOUNT_NAME}

    Edit Account Name       ${ACCOUNT_NAME}    ${UPDATED_NAME}
    Search and Verify Account    ${UPDATED_NAME}
