*** Settings ***
Library         Collections
Library         SeleniumLibrary
Library         DataDriver    file=${CURDIR}/mydata.xlsx
Test Template   Select By Value And Label To Verify Selection
Suite Setup     Browser Setup
Suite Teardown  Close All Browsers

*** Variables ***
${URL}              http://test.mukeshtiwari.com/cascading_dropdown/
${BROWSER}          Chrome
${pcategoryLocator}     id:pcategory
${categoryLocator}      id:category

*** Test Cases ***
${tc_name}    ${pcategoryValue}    ${categoryLabel}

*** Keywords ***
Browser Setup
    Open Browser    ${URL}   ${BROWSER}
    Maximize Browser Window

Select By Value And Label To Verify Selection
    [Arguments]    ${pcategoryValue}    ${categoryLabel}
    Select From List By Value    ${pcategoryLocator}        ${pcategoryValue}    
    Select From List By Label    ${categoryLocator}    ${categoryLabel}
    List Selection Should Be     ${categoryLocator}    ${categoryLabel}
