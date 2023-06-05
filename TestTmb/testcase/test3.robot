*** Settings ***
Library    RequestsLibrary
Force Tags       test_tmb

*** Keywords ***
Should Be Equal As Strings
    [Arguments]    ${actual}    ${expected}
    Should Be Equal    ${actual}    ${expected}

*** Test Cases ***
Get user profile success
    Create Session    reqres    https://reqres.in
    ${resp}    RequestsLibrary.GET On Session    reqres    /api/users/12
    ${resp.status_code}     Convert To String    ${resp.status_code}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${json_data}    Set Variable    ${resp.json()} 
    ${id}   Convert To String     ${json_data['data']['id']}
    Should Be Equal As Strings    ${id}    12 
    Should Be Equal As Strings    ${json_data['data']['email']}        rachel.howell@reqres.in
    Should Be Equal As Strings    ${json_data['data']['first_name']}   Rachel
    Should Be Equal As Strings    ${json_data['data']['last_name']}    Howell
    Should Be Equal As Strings    ${json_data['data']['avatar']}       https://reqres.in/img/faces/12-image.jpg

Get user profile but user not found
    Create Session    reqres    https://reqres.in
    ${resp}=    RequestsLibrary.GET On Session    reqres    /api/users/1234   expected_status=Anything
    Status Should Be    404    ${resp}
    ${json_data}    Set Variable    ${resp.json()}
    Should Be Empty    ${resp.json()}