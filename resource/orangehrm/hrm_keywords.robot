*** Settings ***
Resource    hrm_locators.robot
Resource    ../../variables/orangehrm.robot
Resource    ../../variables/common.robot
Library     SeleniumLibrary
Library     Collections
Library     BuiltIn
Library     OperatingSystem


*** Keywords ***
Setup Suite Environment
    Remove Directory    ${SCREENSHOT_DIR}    recursive=True
    Create Directory    ${SCREENSHOT_DIR}
    Open OrangeHRM Website
Open OrangeHRM Website
    Log    Opening OrangeHRM website at ${ORANGEHRM_URL}
    Open Browser    ${ORANGEHRM_URL}    ${BROWSER}
    Maximize Browser Window
    ${titles}=    Get Window Titles
    Should Not Be Empty    ${titles}
    Wait Until Element Is Visible    ${WEBPAGE_LOAD_VERIFICATION}
    Element Should Be Visible        ${WEBPAGE_LOAD_VERIFICATION}
    Log    Browser opened and maximized
    Capture Page Screenshot    ${SCREENSHOT_DIR}/open_browser.png

Login To OrangeHRM
    [Arguments]    ${username}=${ADMIN_USER}    ${password}=${ADMIN_PASS}
    Log    Logging in with user: ${username}
    Wait Until Element Is Visible    ${LOGIN_USERNAME}
    Input Text    ${LOGIN_USERNAME}    ${username}
    Input Text    ${LOGIN_PASSWORD}    ${password}
    Click Button    ${LOGIN_BUTTON}
    
    Wait Until Page Contains    Dashboard
    # Assert the Dashboard header or welcome message is visible
    Element Should Be Visible    ${DASHBOARD_HEADER}
    Element Text Should Be       ${DASHBOARD_HEADER}    Dashboard
    Log    Login successful, Dashboard loaded
    Capture Page Screenshot    ${SCREENSHOT_DIR}/login_success.png

Navigate to Add Employee
    Log    Navigating to Add Employee page
    Click Element    ${PIM_MENU}
    Wait Until Element Is Visible    ${ADD_EMPLOYEE_MENU}
    Click Element    ${ADD_EMPLOYEE_MENU}
    Wait Until Page Contains    Add Employee
    #Assertion
    Run Keyword And Continue On Failure
    ...    Element Should Be Visible    ${ADD_EMPLOYEE_MENU}
    Run Keyword And Continue On Failure
    ...    Element Text Should Be    ${ADD_EMPLOYEE_MENU}    Add Employee 
    Log    Add Employee page opened
    Capture Page Screenshot    ${SCREENSHOT_DIR}/navigate_to_add_employee.png

Add New Employee
    [Arguments]    ${first_name}    ${middle_name}    ${last_name}    ${employee_id}
    Log    Adding new employee: ${first_name} ${middle_name} ${last_name}, ID: ${employee_id}
    Input Text    ${FIRST_NAME_INPUT}    ${first_name}
    Input Text    ${MIDDLE_NAME_INPUT}    ${middle_name}
    Input Text    ${LAST_NAME_INPUT}     ${last_name}
    Input Text    ${EMPLOYEE_ID_INPUT}   ${employee_id}
    Wait Until Element Is Visible    ${SAVE_BUTTON}
    Click Button    ${SAVE_BUTTON}
    #assertion
    Wait Until Page Contains    Personal Details
    Wait Until Element Is Visible    ${PERSONAL_DETAILS_PAGE}
    Run Keyword And Continue On Failure
    ...    Element Should Be Visible    ${PERSONAL_DETAILS_PAGE}
    Run Keyword And Continue On Failure
    ...    Element Text Should Be    ${PERSONAL_DETAILS_PAGE}    Contact Details
    Log    Employee added successfully
    Capture Page Screenshot    ${SCREENSHOT_DIR}/employee_added.png

Navigate to Employee list
    Log    Navigating to Employee List page
    Click Element    ${EMPLOYEE_LIST}
    Wait Until Page Contains    Employee Information
    Wait Until Element Is Visible    ${EMPLOYEE_LIST_DATA}
    Run Keyword And Continue On Failure
    ...    Element Should Be Visible    ${EMPLOYEE_LIST_DATA}
    Run Keyword And Continue On Failure
    ...    Element Text Should Be    ${EMPLOYEE_LIST_DATA}    Employee Information
    Log    Employee List page opened
    Capture Page Screenshot    ${SCREENSHOT_DIR}/navigate_to_list.png

Search Employee
    [Arguments]    ${employee_name}
    Log    Searching for employee: ${employee_name}
    Wait Until Element Is Visible    ${RESET_BUTTON}
    Click Button    ${RESET_BUTTON}
    Wait Until Element Is Visible    ${SEARCH_NAME_INPUT}
    Input Text    ${SEARCH_NAME_INPUT}    ${employee_name}
    Wait Until Element Is Visible    ${SEARCH_BUTTON}
    Click Button    ${SEARCH_BUTTON}

    ${employee_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${EMPLOYEE_LIST_ROW}    timeout=5s
    Run Keyword If    '${employee_found}' == 'True'    Log    Employee found in list
    Run Keyword If    '${employee_found}' == 'False'   Log    Employee not found in list
    Capture Page Screenshot    ${SCREENSHOT_DIR}/search_${employee_name}.png

Verify Employee In List
    [Arguments]    ${expected_name}
    ${actual_name}=    Get Text    ${EMPLOYEE_LIST_NAME}
    Log    Verifying employee presence: Expected = ${expected_name}, Found = ${actual_name}
    Run Keyword And Continue On Failure    Should Contain    ${actual_name}    ${expected_name}
    Log    Employee verification completed
    Capture Page Screenshot    ${SCREENSHOT_DIR}/verify_${expected_name}.png

Edit Employee Middle Name
    [Arguments]    ${new_middle_name}
    Log    Editing employee middle name to: ${new_middle_name}
    Click Button    ${EDIT_BUTTON}
    Wait Until Element Is Visible    ${MIDDLE_NAME_INPUT}
    Clear Element Text    ${MIDDLE_NAME_INPUT}
    Input Text    ${MIDDLE_NAME_INPUT}    _edited
    Click Button    ${EDIT_SAVE_BUTTON}
    Wait Until Element Is Visible    ${PERSONAL_DETAILS_PAGE}
    Run Keyword And Continue On Failure
    ...    Element Should Be Visible    ${PERSONAL_DETAILS_PAGE}
    Run Keyword And Continue On Failure
    ...    Element Text Should Be    ${PERSONAL_DETAILS_PAGE}    Contact Details
    Wait Until Page Contains    Employee Full Name
    Log    Employee middle name edited successfully
    Capture Page Screenshot    ${SCREENSHOT_DIR}/edited_middle_name.png

Delete Employee
    [Arguments]    ${employee_name}
    Log    Deleting employee: ${employee_name}
    Wait Until Element Is Visible    ${DELETE_BUTTON}
    Click Button    ${DELETE_BUTTON}
    Wait Until Element Is Visible    ${CONFIRM_DELETE}
    Click Button    ${CONFIRM_DELETE}

     Run Keyword And Continue On Failure
    ...    Wait Until Page Contains    Records Found    timeout=5s
    Run Keyword And Continue On Failure
    ...    Page Should Contain    Records Found
    Log    Employee deletion
    Capture Page Screenshot    ${SCREENSHOT_DIR}/deleted_${employee_name}.png

Verify Delete Employee
    [Arguments]    ${expected_name}
    Log    Verifying deletion of employee: ${expected_name}
    Run Keyword And Continue On Failure    Element Should Not Be Visible    ${EMPLOYEE_LIST_NAME}
    Log    Employee deletion verified
    Capture Page Screenshot    ${SCREENSHOT_DIR}/verify_deletion_${expected_name}.png

Capture Screenshot On Failure
    [Arguments]    ${error_message}
    Log    ${error_message}    WARN
    Capture Page Screenshot    ${SCREENSHOT_DIR}/failure_${TEST NAME}.png
    Fail    ${error_message}
