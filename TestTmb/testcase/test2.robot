*** Settings ***
Documentation   Automated tests for login functionality
Library         SeleniumLibrary
Test Teardown    Close Browser
Force Tags       test_tmb
# robot -L TRACE:DEBUG -d results -P 'resources/libs/*' -i testcase/test_tmb  

*** Variables ***
${BROWSER}        Chrome
${URL}            http://the-internet.herokuapp.com/login
${USER1}          tomsmith
${PASS1}          SuperSecretPassword!
${USER2}          tomholland
${PASS2}          Password!
${CHROME_OPTIONS}    browser=chrome    executable_path=${EXECDIR}${/}driver${/}chromedriver_114.exe

*** Keywords ***
Code Login
    [Arguments]   ${url}    ${browser}   ${user}  ${pass}   
    Open Browser    ${url}    ${browser} 
    Input Text      //input[@id="username"]    ${user}
    Input Text      //input[@id="password"]    ${pass}
    Click Button    //button[@class="radius"]
   
Page Should Contain Text
    [Arguments]    ${text}
    Page Should Contain Element   //*[contains(text(),"${text}")]

Code Logout
    Click Element    //a[@class="button secondary radius"]
    Page Should Contain Text    You logged out of the secure
*** Test Cases ***
Login success
    [Documentation]  To verify that users can login successfully 
    ...    when input a correct username and password.
    [Tags]  test
    Code Login    ${URL}   ${BROWSER}   ${USER1}   ${PASS1} 
    Page Should Contain Text    You logged into a secure area!  
    Capture Page Screenshot
    Code Logout
    Capture Page Screenshot

Login failed - Password incorrect   
    [Documentation]  To verify that users can login unsuccessfully when they input 
    ...    a correct username but wrong password.
    [Tags]  login2
    Code Login    ${URL}   ${BROWSER}   ${USER1}   ${PASS2} 
    Page Should Contain Text    Your password is invalid! 
    Capture Page Screenshot
    
Login failed - Username not found
    [Documentation]  To verify that users can login unsuccessfully 
    ...    when they input a username that did not exist.
    [Tags]  login3
    Code Login    ${URL}   ${BROWSER}   ${USER2}   ${PASS1} 
    Page Should Contain Text    Your username is invalid! 
    Capture Page Screenshot

