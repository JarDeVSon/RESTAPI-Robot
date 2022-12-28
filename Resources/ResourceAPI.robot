*** Settings ***
Documentation   Documentacao da API: https://serverest.dev/#/
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     os


*** Variables ***
${BASE_URL}     https://serverest.dev/#/
${ENDPOINT}     usuarios
${_id}          0uxuPY0cbmQhpEz1

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
    ${BODY}=        Create Dictionary       nome=Gasolina PHILLRR   email=gasolina@qa.com.br        password=teste      administrador=true
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     POST On Session     base_url      ${ENDPOINT}     json=${BODY}    headers=${HEADERS}

    Log To Console    ${RESPONSE.status_code}
    Log To Console    ${RESPONSE.content}
    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

PUT On Session Request
    ${BODY}=        Create Dictionary       nome=AAlterado    email=fulano@qa.com        password=teste      administrador=true
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