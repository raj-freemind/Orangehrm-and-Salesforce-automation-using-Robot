*** Settings ***
Library           SeleniumLibrary
Resource    ../../../resource/orangehrm/hrm_keywords.robot
Library    ../../../libraries/CustomHelpers.py

Suite Setup       Setup Suite Environment
Suite Teardown    Close Browser
Test Teardown     Run Keyword If Test Failed    Capture Screenshot On Failure    Test Failed

*** Test Cases ***

Full HRM Employee Lifecycle Test
    [Documentation]    Full-cycle test: login, add employee, search, edit, delete and validate
    Login To OrangeHRM
    Navigate to Add Employee

    ${FIRST_NAME}=    Get Random First Name
    ${MIDDLE_NAME}=   Get Random Middle Name
    ${LAST_NAME}=     Get Random Last Name
    ${EMPLOYEE_ID}=   Get Random Employee Id

    
    ${FULL_NAME}=       Set Variable    ${FIRST_NAME} ${MIDDLE_NAME}
    
    Add New Employee    ${FIRST_NAME}    ${MIDDLE_NAME}    ${LAST_NAME}    ${EMPLOYEE_ID}
    # search and validate
    Navigate to Employee list
    Search Employee     ${FULL_NAME}
    Verify Employee In List    ${FULL_NAME}

    # edit middle name and re-validate
    ${NEW_MIDDLE_NAME}=    Set Variable    ${MIDDLE_NAME}_edited
    Edit Employee Middle Name    ${NEW_MIDDLE_NAME}

    Navigate to Employee list
    ${NEW_SEARCH_NAME}=    Set Variable    ${FIRST_NAME} ${NEW_MIDDLE_NAME}
    Search Employee     ${NEW_SEARCH_NAME}
    Verify Employee In List    ${NEW_SEARCH_NAME}

    Delete Employee     ${NEW_SEARCH_NAME}
    Search Employee     ${NEW_SEARCH_NAME}
    Verify Delete Employee    ${NEW_SEARCH_NAME}
