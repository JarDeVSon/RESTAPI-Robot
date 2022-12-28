*** Settings ***
Documentation   Documentacao da API: https://serverest.dev/#/
Library     RequestsLibrary
Library     Collections


*** Variables ***
${BASE_URL}     https://serverest.dev/#/
${ENDPOINT}     usuarios
${_id}          osssjgZSWd4RDs7I

*** Test Cases ***
TC: Returns all the users (GET)
    [Documentation]     Retorna todos os usuarios
    [Tags]      GET
    Create Session API
    GET On Session Request
    Validate Status Code    200

TC: Add a new user (POST)
    [Documentation]     Adiciona um novo usuario
    [Tags]      POST
    Create Session API
    POST On Session Request
    Validate Status Code    201
    Validate Content    Cadastro realizado com sucesso

TC: Edit user (PUT)
    [Documentation]     Altera os dados do usuario
    [Tags]      PUT
    Create Session API
    PUT On Session Request
    Validate Status Code    200
    Validate Content    Registro alterado com sucesso

TC: Delete user(DELETE)
    [Documentation]     Deleta o usuario
    [Tags]      DELETE
    Create Session API
    DELETE On Session Request
    Validate Status Code    200


*** Keywords ***
Create Session API
    Create Session    base_url    ${BASE_URL}      disable_warnings=True    verify=false

GET On Session Request
    ${RESPONSE}=    GET On Session    base_url    ${ENDPOINT}
    Log to console    ${RESPONSE.status_code}
    Log to console    ${RESPONSE.content}
    Log to console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

POST On Session Request
    ${BODY}=        Create Dictionary       nome=Pipeline 3   email=pipeline3@qa.com.br    password=teste      administrador=true
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     POST On Session     base_url      ${ENDPOINT}     json=${BODY}    headers=${HEADERS}

    Log To Console    ${RESPONSE.status_code}
    Log To Console    ${RESPONSE.content}
    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

PUT On Session Request
    ${BODY}=        Create Dictionary       nome=AAlterado    email=agoravai@qa.com.br       password=teste      administrador=true
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     PUT On Session     base_url      ${ENDPOINT}/${_id}     json=${BODY}    headers=${HEADERS}

    Log To Console    ${RESPONSE.status_code}
    Log To Console    ${RESPONSE.content}
    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

DELETE On Session Request
    ${RESPONSE}=        DELETE On Session   base_url      ${ENDPOINT}/${_id}
    Log To Console    ${RESPONSE.content}
    Set Test Variable    ${RESPONSE}

Validate Status Code
     [Arguments]        ${STATUS_CODE_EXPECTED}
     Should Be Equal As Strings    ${RESPONSE.status_code}    ${STATUS_CODE_EXPECTED}

Validate Content
     [Arguments]        ${CONTENT_EXPECTED}
     ${BODY}=       Convert To String    ${RESPONSE.content}
     Should Contain    ${BODY}    ${CONTENT_EXPECTED}