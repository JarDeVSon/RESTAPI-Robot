*** Settings ***
Documentation   Documentacao da API: https://serverest.dev/#/
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://serverest.dev/#/
${ENDPOINT}     usuarios
${_id}          0uxuPY0cbmQhpEz1

*** Keywords ***
Create Session API
    Create Session    base_url    ${BASE_URL}      disable_warnings=True    verify=False    auth=None   timeout=None    proxies=None    headers={}  cookies={}
    #auth=None #timeout=None #proxies=None #headers={Create Dictionary} #coockes{Create Dictionary}

GET On Session Request
    ${RESPONSE}=    GET On Session    base_url    ${ENDPOINT}   expected_status=200
#    Log to console    ${RESPONSE.status_code}
#    Log to console    ${RESPONSE.content}
#    Log to console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

GET On Session Request with Query Parameters "${QUERY_PARAMETERS}"
    ${RESPONSE}=    GET On Session    base_url    ${ENDPOINT}   expected_status=200     params=${QUERY_PARAMETERS}

#    Log to console    ${RESPONSE.status_code}
#    Log to console    ${RESPONSE.content}
#    Log to console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

POST On Session Request
    ${DATA_BODY}=   Create Dictionary       nome=doideira    email=doideira@qa.com.br    password=teste      administrador=true
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     POST On Session     base_url      ${ENDPOINT}     json=${DATA_BODY}    headers=${HEADERS}  expected_status=201
    #auth=None #timeout=None #proxies=None #

#    Log To Console    ${RESPONSE.status_code}
#    Log To Console    ${RESPONSE.content}
#    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

PUT On Session Request
    ${BODY}=        Create Dictionary       nome=as    email=hehe@qa.com.br       password=teste      administrador=true
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     PUT On Session     base_url      ${ENDPOINT}/${_id}     json=${BODY}    headers=${HEADERS}     expected_status=200

#    Log To Console    ${RESPONSE.status_code}
#    Log To Console    ${RESPONSE.content}
#    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

DELETE On Session Request
    ${RESPONSE}=        DELETE On Session   base_url      ${ENDPOINT}/${_id}    expected_status=200
#    Log To Console    ${RESPONSE.content}
    Set Test Variable    ${RESPONSE}

Validate Status Code
     [Arguments]        ${STATUS_CODE_EXPECTED}
     Should Be Equal As Numbers    ${RESPONSE.status_code}    ${STATUS_CODE_EXPECTED}

Validate Content
     [Arguments]        ${CONTENT_EXPECTED}
     ${BODY}=       Convert To String    ${RESPONSE.content}
     Should Contain    ${BODY}    ${CONTENT_EXPECTED}