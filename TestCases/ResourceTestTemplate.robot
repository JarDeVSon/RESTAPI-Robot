*** Settings ***
Library         RequestsLibrary
Library         JsonValidator
*** Variables ***

${BASE_URL}     https://serverest.dev/#/
${ENDPOINT}     usuarios
${_ID}

*** Keywords ***

## Escrita do cenário em Gherkin

Scenario - 01 - (POST) Validar usuario inserido no ServRest
    que Create Session API
    executo uma requisicao POST na API "${NOME}", "${EMAIL}", "${PASSWORD}", "${ADMIN}"
    valido Status Code "${STATUS_CODE_EXPECTED}"
    valido Conteudo "${CONTENT_EXPECTED}"

Scenario - 02 - (GET) Validar busca por usuarios no ServRest
    que Create Session API
    realizo uma requisicao GET na API
    valido Status Code "${STATUS_CODE_EXPECTED}"


Scenario - 03 - (PUT) Validar usuario alterado no ServRest
    que Create Session API
    executo uma requisicao PUT na API "${NOME}", "${EMAIL}", "${PASSWORD}", "${ADMIN}"
    valido Status Code "${STATUS_CODE_EXPECTED}"
    valido Conteudo "${CONTENT_EXPECTED}"

Scenario - 04 - (DELETE) Validar (DELETE) usuario deletado no ServRest
    que Create Session API
    realizo uma requisicao DELETE na API
    valido Status Code "${STATUS_CODE_EXPECTED}"
    valido Conteudo "${CONTENT_EXPECTED}"


Template Scenario Outline 01 - (POST) Validar (POST) usuario inserido no ServRest
    [ARGUMENTS]  ${NOME}     ${EMAIL}    ${PASSWORD}     ${ADMIN}   ${STATUS_CODE_EXPECTED}  ${CONTENT_EXPECTED}
    que Create Session API
    executo uma requisicao POST na API "${NOME}", "${EMAIL}", "${PASSWORD}", "${ADMIN}"
    valido Status Code Template     ${STATUS_CODE_EXPECTED}
    valido Conteudo     ${CONTENT_EXPECTED}

Template Scenario Outline 02 - (GET) Validar response das informações dos usuarios buscados no ServRest
    [ARGUMENTS]     ${STATUS_CODE_EXPECTED}
    que Create Session API
    realizo uma requisicao GET na API
    valido Status Code Template     ${STATUS_CODE_EXPECTED}



Template Scenario Outline 03 - (PUT) Validar (PUT) usuario alterado no ServRest
    [ARGUMENTS]  ${NOME}     ${EMAIL}    ${PASSWORD}     ${ADMIN}   ${STATUS_CODE_EXPECTED}  ${CONTENT_EXPECTED}
    que Create Session API
    executo uma requisicao PUT na API "${NOME}", "${EMAIL}", "${PASSWORD}", "${ADMIN}"
    valido Status Code Template     ${STATUS_CODE_EXPECTED}
    valido Conteudo     ${CONTENT_EXPECTED}

Template Scenario Outline 04 - (DELETE) Validar (DELETE) usuario deletado no ServRest
    [ARGUMENTS]     ${STATUS_CODE_EXPECTED}  #${CONTENT_EXPECTED}
    que Create Session API
    realizo uma requisicao DELETE na API
    valido Status Code    ${STATUS_CODE_EXPECTED}
#    valido Conteudo      ${CONTENT_EXPECTED}

############# Implementacao #################

que Create Session API
    Create Session    base_url    ${BASE_URL}      disable_warnings=True    verify=False    auth=None   timeout=None    proxies=None    headers={}  cookies={}


realizo uma requisicao GET na API
    ${RESPONSE}=    GET On Session    base_url    ${ENDPOINT}   expected_status=200
#    Log to console    ${RESPONSE.status_code}
    Log to console    ${RESPONSE.content}
#    Log to console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

executo uma requisicao POST na API "${NOME}", "${EMAIL}", "${PASSWORD}", "${ADMIN}"
    ${DATA_BODY}=   Create Dictionary       nome=${NOME}    email=${EMAIL}    password=${PASSWORD}      administrador=${ADMIN}
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     POST On Session     base_url      ${ENDPOINT}     json=${DATA_BODY}    headers=${HEADERS}  expected_status=201
    #auth=None #timeout=None #proxies=None #
#    Log To Console    ${RESPONSE.status_code}
#    Log To Console    ${RESPONSE.content}
#    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

executo uma requisicao PUT na API "${NOME}", "${EMAIL}", "${PASSWORD}", "${ADMIN}"
    ${DATA_BODY}=   Create Dictionary       nome=${NOME}    email=${EMAIL}    password=${PASSWORD}      administrador=${ADMIN}
    ${HEADERS}=     Create Dictionary       Content-Type=application/json
    ${RESPONSE}=     PUT On Session     base_url      ${ENDPOINT}/${_ID}     json=${DATA_BODY}    headers=${HEADERS}  expected_status=200
    #auth=None #timeout=None #proxies=None #
#    Log To Console    ${RESPONSE.status_code}
#    Log To Console    ${RESPONSE.content}
#    Log To Console    ${RESPONSE.headers}
    Set Test Variable    ${RESPONSE}

realizo uma requisicao DELETE na API
    ${RESPONSE}=        DELETE On Session   base_url      ${ENDPOINT}/${_id}    expected_status=200
#    Log To Console    ${RESPONSE.content}
    Set Test Variable    ${RESPONSE}

valido Status Code
     [Arguments]        ${STATUS_CODE_EXPECTED}
     Should Be Equal As Numbers    ${RESPONSE.status_code}    ${STATUS_CODE_EXPECTED}

valido Status Code Template
     [Arguments]        ${STATUS_CODE_EXPECTED}
     Should Be Equal As Numbers    ${RESPONSE.status_code}    ${STATUS_CODE_EXPECTED}

valido Conteudo
     [Arguments]        ${CONTENT_EXPECTED}
     ${BODY}=       Convert To String    ${RESPONSE.content}
     Should Contain    ${BODY}    ${CONTENT_EXPECTED}

