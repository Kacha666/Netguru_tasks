*** Settings ***
Library  SeleniumLibrary

*** Variables ***

${LOGIN URL}    https://trello.com/login
${Browser}  Chrome
@{list} =   Invalid password    There isn't an account for this email   Home


*** Test Cases ***

Correct logging in
    Open main page
    Maximize Browser Window
    Insert valid email
    Insert valid password
    Log In button
    Login should succeed
    [Teardown]  Close browser

Not existing account
    Open main page
    Maximize Browser Window
    Insert invalid email
    Insert invalid password
    Log In button
    Login should fail - email
    [Teardown]  Close browser

Invalid password for existing account
    Open main page
    Maximize Browser Window
    Insert valid email
    Insert invalid password
    Log In button
    Login should fail - password
    [Teardown]  Close browser

*** Keywords ***

Open main page
    Open browser    ${LOGIN URL}   ${BROWSER}
    Title should be    Log in to Trello

Insert valid email
    Input text  xpath://*[@id="user"]   katarzynagulardowska+trello@gmail.com

Insert valid password
#passwords should not be used as plain text but for this example let's assume it's fine :) there are multiple ways to manage users and password
    Input text  xpath://*[@id="password"]   12345678

Log In button
    Click element   xpath://*[@id="login"]

Insert invalid email
    Input text  xpath://*[@id="user"]   fake_account13@onet.pl

Insert invalid password
    Input text  xpath://*[@id="password"]   123

Login should fail - email
    Page Should Contain   There isn't an account for this email
    Title should be    Log in to Trello

Login should fail - password
    Page Should Contain    Invalid password
    Title should be    Log in to Trello

Login should succeed
    Wait Until Element Contains    id:banners    Please confirm your email address: katarzynagulardowska+trello@gmail.com.
