*** Settings ***
Resource    salesforce_locators.robot
Resource    ../../variables/salesforce.robot
Resource    ../../variables/common.robot
Library    SeleniumLibrary
Library    Collections
Library     OperatingSystem

*** Keywords ***
Setup Suite Environment
    Remove Directory    ${SCREENSHOT_DIR}    recursive=True
    Create Directory    ${SCREENSHOT_DIR}
Login To Salesforce
    [Arguments]    ${username}=${SF_USERNAME}    ${password}=${SF_PASSWORD}
    Open Browser    ${SF_URL}    ${BROWSER}
    Maximize Browser Window

    Wait Until Element Is Visible    ${SF_LOGIN_USERNAME}
    Input Text    ${SF_LOGIN_USERNAME}    ${username}
    Input Text    ${SF_LOGIN_PASSWORD}    ${password}

    Click Element    ${SF_LOGIN_BUTTON}
    Wait Until Page Contains    Seller Home    10s 
    Wait Until Element Is Visible    ${DASHBOARD}
    Element Should Be Visible        ${DASHBOARD}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/login_success.png

Navigate To Tab Menu
    [Arguments]    ${label}
    Wait Until Page Contains Element    xpath=//span[contains(text(), '${label}')]    20s
    Execute Javascript
    ...    var el = document.evaluate("//span[contains(text(), '${label}')]/ancestor::a", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if (el) { el.scrollIntoView({behavior: 'smooth'}); el.click(); }
    Wait Until Page Contains Element    xpath=//span[text()='Account Name']
    Element Should Be Visible    ${ACCOUNT_PAGE_LOAD}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/Navigate_To_Account_page.png

Create New Account
    [Arguments]    ${account_name_input}
    Log    Creating new account: ${account_name_input}

    Wait Until Element Is Visible    ${NEW_BUTTON}
    Click Element    ${NEW_BUTTON}

    Wait Until Element Is Visible    ${NEW_ACCOUNT_PAGE}
    Element Should Be Visible    ${NEW_ACCOUNT_PAGE}

    Wait Until Element Is Visible    ${ACCOUNT_NAME}
    Input Text    ${ACCOUNT_NAME}    ${account_name_input}
    Wait Until Element Is Enabled    ${SAVE_BUTTON}
    Click Element    ${SAVE_BUTTON}

    # Build dynamic XPath for verification
    Set Test Variable    ${ACCOUNT_NAME_SAVED}    xpath=//lightning-formatted-text[@slot='primaryField' and normalize-space(text())='${account_name_input}']

    Wait Until Element Is Visible    ${ACCOUNT_NAME_SAVED}
    Element Text Should Be    ${ACCOUNT_NAME_SAVED}    ${account_name_input}

    Log    Account created with name: ${account_name_input}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/account_created.png

Search and Verify Account
    [Arguments]    ${account_full_name}
    Wait Until Element Is Visible    ${SEARCH_INPUT}
    Input Text    ${SEARCH_INPUT}    ${account_full_name}
    Press Keys    ${SEARCH_INPUT}    RETURN
    Wait Until Element Is Visible    ${ACCOUNT_LIST_NAME}
    ${actual_search_name}=    Execute Javascript
    ...    return document.evaluate("//th[@data-label='Account Name']//a", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue?.innerText
    Log    Searching and validating account. Expected: ${account_full_name}, Found: ${actual_search_name}
    Should Be Equal As Strings    ${actual_search_name.strip()}    ${account_full_name}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/${account_full_name}.png

Edit Account Name
    [Arguments]    ${old_account_name}    ${new_account_name}
    Log    Editing account name from: ${old_account_name} to: ${new_account_name}

    Wait Until Element Is Visible    ${EDIT_BUTTON}

    ${edit_button_js}=    Catenate    SEPARATOR=\n
    ...    var el = document.evaluate("//span[contains(text(), 'Edit Account Name')]/ancestor::button", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if (el) {
    ...        el.scrollIntoView({behavior: 'smooth', block: 'center'});
    ...        el.click();
    ...        return true;
    ...    } else {
    ...        return false;
    ...    }
    Execute Javascript    ${edit_button_js}

    ${edit_input_js}=    Catenate    SEPARATOR=\n
    ...    var el = document.evaluate("//input[@name='Name']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if (el) {
    ...        el.scrollIntoView({behavior: 'smooth', block: 'center'});
    ...        el.focus();
    ...        el.value = '${new_account_name}';
    ...        el.dispatchEvent(new Event('input', { bubbles: true }));
    ...        return true;
    ...    } else {
    ...        return false;
    ...    }
    Execute Javascript    ${edit_input_js}

    Press Keys    xpath=//input[@name='Name']    RETURN

    Wait Until Element Is Visible    ${FINAL_SAVE_BUTTON}
    Click Element    ${FINAL_SAVE_BUTTON}

    Wait Until Element Is Not Visible    ${FINAL_SAVE_BUTTON}    timeout=10s

    Log    Account name updated to: ${new_account_name}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/account_updated.png



    