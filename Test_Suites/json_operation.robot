*** Settings ***
Library         JSONLibrary
Library         OperatingSystem
Library         String
Library         Collections

Suite Setup     Run Keywords    Get Timeinepoch
#https://stackoverflow.com/questions/47283542/edit-a-json-file-in-robot-framework

Force Tags          docker

*** Variables ***
${SUBSCRIBER_A}     phone1

*** Test Cases ***
Testcase
    # JSON Operations    ${SUBSCRIBER_A}
    ${uniqid_input_json_object}=    Create Dictionary    uniqid=${uniqid}
    Write Variable to Suite File     ${uniqid_input_json_object}
    ${value_of_uniqid}=    Find Value of Key from Suite File    uniqid
    Log    ${value_of_uniqid}

*** Keywords ***
Get Timeinepoch
    @{time}=    Get Time    year month day hour min sec
    Set Suite Variable    ${uniqid}    ${time}[0]${time}[1]${time}[2]${time}[3]${time}[4]${time}[5]

JSON Operations
    [Arguments]    ${SUBSCRIBER_A}
    Read JSON from Suite File
    ${json_obj}=    Load JSON From File    ${CURDIR}/../Test_Data/example.json
    ${object_to_add}=    Create Dictionary    driver=1
    ${json_obj}=    Add Object To Json    ${json_obj}    $..${SUBSCRIBER_A}    ${object_to_add}
    ${new_obj}=    Convert JSON To String    ${json_obj}
    Create File    ${CURDIR}/../Test_Data/${SUITE NAME}.json    ${new_obj}    UTF-8
    ${updated_json_obj}=    Load JSON From File    ${CURDIR}/../Test_Data/${SUITE NAME}.json
    Log    ${updated_json_obj}
    Remove File    ${CURDIR}/../Test_Data/${SUITE NAME}.json

Write Variable to Suite File
    [Arguments]    ${input_json_object}
    ${output_json_object}=    Convert JSON To String    ${input_json_object}
    Create File    ${CURDIR}/../Test_Data/${SUITE NAME}.json    ${output_json_object}    UTF-8

Find Value of Key from Suite File
    [Arguments]    ${key_of_json_object}
    ${json_obj}=    Load JSON From File    ${CURDIR}/../Test_Data/${SUITE NAME}.json
    ${value_of_key}=	Get From Dictionary	    ${json_obj}    ${key_of_json_object}
    [Return]    ${value_of_key}
