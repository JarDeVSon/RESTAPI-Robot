*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     os


*** Variables ***
${BASE_URL}     https://serverest.dev/#/
${ENDPOINT}     usuarios
${_id}          Pmn5Hu6zsY4DggoX


*** Test Cases ***
Testcase1: Returns all the users (GET)
    Create Session    base_url    ${BASE_URL}
    ${response}=      GET On Session    base_url    ${ENDPOINT}

    ${json_object}=     Load Json From File     Jsons/usuario.json
    ${name_value}=      Get Value From Json    ${json_object}    $.nome

    #Validations
    ${status_code}=    Convert To String        ${response.status_code}
    Should Be Equal    ${status_code}    200
    Should Contain    ${name_value}    Fulano da Silva


Testcase2: Add a new user (POST)

    Create Session    base_url    ${BASE_URL}

    ${headers}=     Create Dictionary       Content-Type=application/json
    ${body}=        Load Json From File     jsons/usuario.json
    ${response}=     POST On Session     base_url      ${ENDPOINT}      json=${body}    headers=${headers}

#    Log To Console    ${response.status_code}
#    Log To Console    ${response.content}
#    Log To Console    ${response.headers}

    ### Validations
    ${status_code}=     Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201

    ${res_body}=        Convert To String      ${response.content}
    Should Contain    ${res_body}    Cadastro realizado com sucesso