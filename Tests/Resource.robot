*** Settings ***
Documentation   Documentacao da API: https://serverest.dev/#/
Library     RequestsLibrary
Library     Collections
Library     String
Library     JSONLibrary
Library     FakerLibrary    locale=pt_BR

*** Variables ***
${BASE_URL}     https://serverest.dev/#/
${ENDPOINT}     usuarios
${_id}          ${id}

*** Keywords ***
Create Session API
    Create Session  base_url  ${BASE_URL}  disable_warnings=True  verify=False  auth=None  timeout=None  proxies=None  headers={}  cookies={}
    #auth=None #timeout=None #proxies=None #headers={Create Dictionary} #coockes{Create Dictionary}

GET On Session Request
    ${RESPONSE}=    GET On Session  base_url  ${ENDPOINT}  expected_status=200
#    Log to console    ${RESPONSE.status_code}
#    Log to console    ${RESPONSE.content}
#    Log to console    ${RESPONSE.headers}
    Set Suite Variable  ${RESPONSE}

GET On Session Request with Query Parameters "${QUERY_PARAMETERS}"
    ${RESPONSE}=  GET On Session  base_url  ${ENDPOINT}  expected_status=200  params=${QUERY_PARAMETERS}

#    Log to console    ${RESPONSE.status_code}
#    Log to console    ${RESPONSE.content}
#    Log to console    ${RESPONSE.headers}
    Set Suite Variable  ${RESPONSE}

POST On Session Request
    ${NOMEFAKE}                 FakerLibrary.Name
    ${EMAILFAKE}                FakerLibrary.Email
    ${PASSWORDFAKE}             FakerLibrary.Password

#    ${DATA_BODY}=   Load Json From File     Jsons/usuario.json
    ${DATA_BODY}=   Create Dictionary  nome=${NOMEFAKE}  email=${EMAILFAKE}  password=${PASSWORDFAKE}      administrador=true
    ${HEADERS}=     Create Dictionary  Content-Type=application/json
    ${RESPONSE}=     POST On Session     base_url      ${ENDPOINT}     json=${DATA_BODY}    headers=${HEADERS}  expected_status=201
    #auth=None #timeout=None #proxies=None #

#    Log To Console    ${RESPONSE.status_code}
#    Log To Console    ${RESPONSE.text}
#    Log To Console    ${RESPONSE.headers}
#    Log To Console    ${RESPONSE.text}

    ${id}=      Convert To String    ${RESPONSE.json()['_id']}
    Set Suite Variable    ${id}
    Set Suite Variable    ${RESPONSE}


PUT On Session Request
    ${NOMEFAKE}                 FakerLibrary.Name
    ${EMAILFAKE}                FakerLibrary.Email
    ${PASSWORDFAKE}             FakerLibrary.Password

#    ${DATA_BODY}=   Load Json From File     Jsons/usuario.json
    ${BODY}=   Create Dictionary   nome=${NOMEFAKE}        email=${EMAILFAKE}  password=${PASSWORDFAKE}     administrador=false
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     PUT On Session     base_url      ${ENDPOINT}/${id}   json=${BODY}    headers=${HEADERS}     expected_status=200

#    Log To Console    ${RESPONSE.status_code}
#    Log To Console    ${RESPONSE.content}
#    Log To Console    ${RESPONSE.text}
#    Log To Console    ${RESPONSE.json()}
#    Log To Console    ${RESPONSE.headers}

    Set Suite Variable    ${RESPONSE}


DELETE On Session Request
    ${RESPONSE}=        DELETE On Session   base_url      ${ENDPOINT}/${id}    expected_status=200
#    Log To Console    ${RESPONSE.content}
    Set Suite Variable    ${RESPONSE}

Validate Dict Item
    [Arguments]     ${KEY}  ${VALUE}
    Log To Console    ${RESPONSE.json()} 
    Dictionary Should Contain Item    ${RESPONSE.json()}    ${KEY}  ${VALUE}
Validate Status Code
     [Arguments]        ${STATUS_CODE_EXPECTED}
     Should Be Equal As Integers    ${RESPONSE.status_code}    ${STATUS_CODE_EXPECTED}

Validate Content
     [Arguments]    ${CONTENT_EXPECTED}
     ${BODY}=       Convert To String    ${RESPONSE.content}
     Should Contain    ${BODY}    ${CONTENT_EXPECTED}