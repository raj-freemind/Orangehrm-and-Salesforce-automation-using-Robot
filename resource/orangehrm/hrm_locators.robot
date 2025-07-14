*** Variables ***
${WEBPAGE_LOAD_VERIFICATION}    xpath=//p[contains(normalize-space(.), 'Username : Admin')]
${LOGIN_USERNAME}    xpath=//input[@name='username']
${LOGIN_PASSWORD}    xpath=//input[@name='password']
${LOGIN_BUTTON}    xpath=//button[@type='submit']
${DASHBOARD_HEADER}    xpath=//span[@class='oxd-topbar-header-breadcrumb']/h6


${PIM_MENU}    xpath=//span[text()='PIM']
${ADD_EMPLOYEE_MENU}    xpath=//a[text()='Add Employee']
                        #xpath = //button[text()=' Add ']

${FIRST_NAME_INPUT}    xpath=//input[@name='firstName']
${MIDDLE_NAME_INPUT}    xpath=//input[@name='middleName']
${LAST_NAME_INPUT}    xpath=//input[@name='lastName']
${EMPLOYEE_ID_INPUT}    xpath = //label[text()='Employee Id']/../following-sibling::div/input
${SAVE_BUTTON}    xpath=//button[text()=' Save ']
${PERSONAL_DETAILS_PAGE}    xpath=//a[normalize-space(text())='Contact Details']
${EMPLOYEE_LIST_DATA}    xpath=//h5[contains(normalize-space(.), 'Employee Information')]

# search the added employee and validate from the employee list table
${EMPLOYEE_LIST}    xpath=//a[text()='Employee List']
${SEARCH_NAME_INPUT}    xpath=//label[text()='Employee Name']/following::input[1]
                        #//label[text()='Employee Name']/../following-sibling::div/div/div/input
${SEARCH_BUTTON}    xpath=//button[contains(normalize-space(.), 'Search')]
${RESET_BUTTON}    xpath =//button[contains(normalize-space(.), 'Reset')]

${EMPLOYEE_LIST_ROW}     xpath=//div[@class='oxd-table-card']
${EMPLOYEE_LIST_NAME}    xpath=//div[@class='oxd-table-card'][1]/div/div[3]

${EDIT_BUTTON}    xpath=//div[@class='oxd-table-card'][1]//button[1]
${EDIT_SAVE_BUTTON}    xpath =//p[normalize-space()='* Required']/following-sibling::button


${DELETE_BUTTON}    xpath=//div[@class='oxd-table-card'][1]//button[2]
${CONFIRM_DELETE}    xpath=//button[contains(@class,'oxd-button--label-danger')]
                       # //button[contains(., 'Yes, Delete')]