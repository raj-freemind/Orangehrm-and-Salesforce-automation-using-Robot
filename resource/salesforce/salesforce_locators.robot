*** Variables ***
# Login Page
${SF_LOGIN_USERNAME}    xpath=//input[@id='username']
${SF_LOGIN_PASSWORD}    xpath=//input[@id='password']
${SF_LOGIN_BUTTON}    xpath=//input[@id='Login']
${DASHBOARD}        xpath=//h2[normalize-space(text())='Plan My Accounts']

#Navigate To Account
${ACCOUNTS_MENU}    xpath=//span[contains(text(), 'Accounts')]/ancestor::a
${ACCOUNT_PAGE_LOAD}    xpath=//span[text()='Account Name']

# Account Page
${NEW_BUTTON}        xpath=//div[text()='New']
${NEW_ACCOUNT_PAGE}        xpath=//h2[contains(normalize-space(.), 'New Account')]
${ACCOUNT_NAME}        xpath=//label[text()='Account Name']/following-sibling::div//input
${SAVE_BUTTON}        xpath=//button[@name='SaveEdit' and normalize-space(text())='Save']
# ${ACCOUNT_NAME_SAVED}    xpath=//lightning-formatted-text[normalize-space(text())='devraj gautam']
${FOLLOW}            xpath=//span[contains(text(), 'Follow')]

# Search Account
${SEARCH_INPUT}        xpath=//input[starts-with(@id, 'input') and @name='Account-search-input']
${ACCOUNT_LIST_NAME}        xpath=//th[@data-label='Account Name']//a

# Edit Account
${EDIT_BUTTON}        xpath=//span[contains(text(), 'Edit Account Name')]/ancestor::button
${EDIT_TEXT_INPUT}        xpath=//input[starts-with(@id, 'input') and @name='Name']
${FINAL_SAVE_BUTTON}        xpath=//button[contains(text(), 'Save')]
