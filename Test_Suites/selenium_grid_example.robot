*** Settings ***
Documentation         This is just a tutorial
...
Metadata              VERSION    0.1
Library               SeleniumLibrary
Suite Setup           Start Browser
Suite Teardown        Close Browser

*** Variables ***
${TEST_URL}           https://www.google.co.in
${BROWSER}            Chrome
${HUB_URL}            http://192.168.53.5:4444/wd/hub

*** Keywords ***
Start Browser
    [Documentation]   Start Chrome browser on Selenium Grid
    Open Browser      ${TEST_URL}   ${BROWSER}   None    ${HUB_URL}

*** Test Cases ***
Check something
    [Documentation]   Check the page title
    Title Should Be   Google