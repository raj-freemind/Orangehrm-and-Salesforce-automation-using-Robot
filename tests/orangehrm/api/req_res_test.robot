*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           ../../../libraries/CustomHelpers.py
Resource          ../../../variables/common.robot
Resource          ../../../resource/api/req_res_keywords.robot

*** Test Cases ***
Get Users And Validate Schema
    ${response}=    Get List Of Users
    Validate User List Response Schema    ${response}

Create User And Validate Response Body
    ${name}=    Get Random First Name
    ${job}=     Get Random Job
    ${response}=    Create New User    ${name}    ${job}
    Validate Create User Body    ${response}    ${name}    ${job}
