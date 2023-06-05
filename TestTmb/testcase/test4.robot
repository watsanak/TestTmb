*** Settings ***
Library           AppiumLibrary
Suite Setup       Open Application

*** Variables ***
${ANDROID_APP}                ${CURDIR}/demoapp/ApiDemos-debug.apk
${ANDROID_PLATFORM_NAME}      Android
${APP_PACKAGE}    com.avjindersinghsekhon.minimaltodo
${APP_ACTIVITY}   .MainActivity

*** Test Cases ***
Verify Task Creation
    [Documentation]    Verify that a task can be created successfully
    Create Task       Buy Groceries
    Task Should Be Visible    Buy Groceries

Verify Task Completion
    [Documentation]    Verify that a task can be marked as completed
    Create Task       Do Laundry
    Mark Task As Completed   Do Laundry
    Task Should Be Completed   Do Laundry

Verify Task Deletion
    [Documentation]    Verify that a task can be deleted
    Create Task       Pay Bills
    Delete Task       Pay Bills
    Task Should Not Be Visible   Pay Bills

*** Keywords ***
Open Application
    Open Application    platformName=Android    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    deviceName=your_device_name

Create Task
    [Arguments]    ${taskTitle}
    Click Element    xpath=//button[@id='fab']
    Input Text    xpath=//input[@id='title_edit_text']    ${taskTitle}
    Click Element    xpath=//button[@id='save_button']

Task Should Be Visible
    [Arguments]    ${taskTitle}
    Page Should Contain Element    xpath=//android.widget.TextView[@text='${taskTitle}']

Mark Task As Completed
    [Arguments]    ${taskTitle}
    Click Element    xpath=//android.widget.TextView[@text='${taskTitle}']
    Click Element    xpath=//android.widget.CheckBox[@text='Completed']

Task Should Be Completed
    [Arguments]    ${taskTitle}
    Element Text Should Be    xpath=//android.widget.TextView[@text='${taskTitle}']/preceding-sibling::android.widget.CheckBox    true

Delete Task
    [Arguments]    ${taskTitle}
    Long Press Element    xpath=//android.widget.TextView[@text='${taskTitle}']
    Click Element    xpath=//android.widget.TextView[@text='Delete']

Task Should Not Be Visible
    [Arguments]    ${taskTitle}
    Page Should Not Contain Element    xpath=//android.widget.TextView[@text='${taskTitle}']
