*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    ../../libraries/custom_helpers.py
Resource    ../../variables/common.robot



*** Keywords ***
Get List Of Users
    [Arguments]    ${expected_status}=200
    ${headers}=    Create Dictionary    Content-Type=application/json    x-api-key=reqres-free-v1
    ${response}=    GET    ${BASE_URL}/users    headers=${headers}    
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    RETURN    ${response}

Validate User List Response Schema
    [Arguments]    ${response}
    ${schema}=    Load Json From File    ${SCHEMA_FILE}
    ${json}=      Call Method    ${response}    json
    Evaluate    __import__('jsonschema').validate(${json}, ${schema}) #Validate Json By Schema
Create New User
    [Arguments]    ${name}    ${job}
    ${headers}=    Create Dictionary    Content-Type=application/json    x-api-key=reqres-free-v1
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    Create Session    reqres    ${BASE_URL}    headers=${headers}
    ${response}=    POST On Session    reqres    /users    json=${payload}
    Should Be Equal As Numbers    ${response.status_code}    201
    RETURN    ${response}

Validate Create User Body
    [Arguments]    ${response}    ${expected_name}    ${expected_job}
    ${body}=    Call Method    ${response}    json
    Should Be Equal As Strings    ${body['name']}    ${expected_name}
    Should Be Equal As Strings    ${body['job']}     ${expected_job}
    Dictionary Should Contain Key    ${body}    id
    Dictionary Should Contain Key    ${body}    createdAt
    Should Not Be Empty    ${body['id']}
    Should Not Be Empty    ${body['createdAt']}