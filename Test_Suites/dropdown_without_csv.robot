*** Settings ***
Library             Collections
Library             SeleniumLibrary

Suite Setup         Browser Setup
Suite Teardown      Close All Browsers
Test Template       Select By Value And Label To Verify Selection

*** Variables ***
${URL}                  http://test.mukeshtiwari.com/cascading_dropdown/
${BROWSER}              Chrome
${pcategoryLocator}     id:pcategory
${categoryLocator}      id:category

*** Test Cases ***      pcategoryValue      categoryLabel
Animal Lion             Animal              Lion
Animal Tiger            Animal              Tiger
Animal Elephant         Animal              Elephant
Animal Hippo            Animal              Hippo
Bike Bajaj              Bike                Bajaj
Bike Hero               Bike                Hero
Bike TVS                Bike                TVS
Bike Bullet             Bike                Bullet
Bike Hayabusa           Bike                Hayabusa
Cars Mercedes           Cars                Mercedes
Cars BMW                Cars                BMW
Cars Maruti             Cars                Maruti
Cars Volkswagen         Cars                Volkswagen

*** Keywords ***
Browser Setup
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Select By Value And Label To Verify Selection
    [Arguments]    ${pcategoryValue}    ${categoryLabel}
    Select From List By Value    ${pcategoryLocator}    ${pcategoryValue}
    Select From List By Label    ${categoryLocator}    ${categoryLabel}
    List Selection Should Be    ${categoryLocator}    ${categoryLabel}
