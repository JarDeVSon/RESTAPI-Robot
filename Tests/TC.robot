*** Settings ***
Documentation   Robot Framework para Iniciantes
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections

*** Variables ***
&{BASE_URL}     dev=https://serverest.dev/#/    hom=https://serverest.dev/#/
${ENDPOINT}     usuarios
${ENVIRONMENT}  dev
# ${ID}           ${_id}

# robot -d reports -v ENVIRONMENT:dev <caminho do arquivo de teste>
# robot -d reports -v ENVIRONMENT:hom <caminho do arquivo de teste>
# CLI -
*** Test Cases ***

CT-0001: Get All Users
    [Documentation]     Listar usuarios cadastrados
    [Tags]    CT-0001
    #ARRANGE
    Create Session    BASE_URL_ServRest    ${BASE_URL.${ENVIRONMENT}}   verify=False    disable_warnings=True
    #ACT
    ${RESPONSE}=    GET On Session      BASE_URL_ServRest     ${ENDPOINT}
    Log To Console    ${RESPONSE.status_code}
    Log To Console    ${RESPONSE.content}
    Log To Console    ${RESPONSE.json()}

    #ASSERT
    #Assert status code
    ${STATUS_CODE_EXPECTED}=    Convert To String    ${RESPONSE.status_code}
    Should Be Equal    ${STATUS_CODE_EXPECTED}    200

    #Assert content
    # ${CONTENT_EXPECTED}=    Convert To String    ${RESPONSE.content}
    # Should Contain    ${CONTENT_EXPECTED}    Fulano da Silva

CT-0002: POST user
    [Documentation]     Cadastrar usuario
    [Tags]    CT-0002
    #ARRANGE
    Create Session    BASE_URL_ServRest    ${BASE_URL.${ENVIRONMENT}}  verify=False    disable_warnings=True
    #ACT
    ${BODY}=    Create Dictionary   nome=Fulano da Silva    email=1213ArSAasS113123444@qa.com.br    password=teste      administrador=true
    ${HEADERS}=     Create Dictionary   Content-Type=application/json
    ${RESPONSE}=    POST On Session   BASE_URL_ServRest     ${ENDPOINT}     json=${BODY}    headers=${HEADERS}
    Log To Console    ${BODY}
    Log To Console    ${RESPONSE.status_code}
    Log To Console    ${RESPONSE.content}
    Log To Console    ${RESPONSE.json()}
    ${_id}=  Convert To String    ${RESPONSE.json()['_id']}
    Log To Console    Possui o id: ${_id}
    Set Suite Variable     ${_id}
    Set Suite Variable    ${RESPONSE}
    #ASSERT
    #Assert status code
    ${STATUS_CODE_EXPECTED}=    Convert To String    ${RESPONSE.status_code}
    Should Be Equal    ${STATUS_CODE_EXPECTED}    201
    #Assert content
    ${CONTENT_EXPECTED}=    Convert To String    ${RESPONSE.content}
    Should Contain    ${CONTENT_EXPECTED}    Cadastro realizado com sucesso

CT-0003: PUT User
    [Documentation]     Editar usuario
    [Tags]    CT-0003
    #ARRANGE
    Create Session    BASE_URL_ServRest    ${BASE_URL.${ENVIRONMENT}}  verify=False    disable_warnings=True
    #ACT
    ${BODY}=    Create Dictionary   nome=Fulano da Silva    email=44no@qa.com.br    password=teste1      administrador=true
    ${HEADERS}=     Create Dictionary   Content-Type=application/json
    ${RESPONSE}=    PUT On Session   BASE_URL_ServRest     ${ENDPOINT}/${ID}     json=${BODY}    headers=${HEADERS}
    Log To Console     ${BODY}
    Log To Console    ${RESPONSE.status_code}
    Log To Console    ${RESPONSE.content}
    Log To Console    ${RESPONSE.json()}
    #ASSERT
    #Assert status code
    ${STATUS_CODE_EXPECTED}=    Convert To String    ${RESPONSE.status_code}
    Should Be Equal    ${STATUS_CODE_EXPECTED}    200
    #Assert content
    ${CONTENT_EXPECTED}=    Convert To String    ${RESPONSE.content}
    Should Contain    ${CONTENT_EXPECTED}    Registro alterado com sucesso
    #Assert Dict - key value
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    Registro alterado com sucesso


CT-0004: DELETE User
    [Documentation]     Deletar usuario
    [Tags]    CT-0004
    #ARRANGE
    Create Session    BASE_URL_ServRest    ${BASE_URL.${ENVIRONMENT}}  verify=False    disable_warnings=True
    #ACT
    ${RESPONSE}=    DELETE On Session   BASE_URL_ServRest   ${ENDPOINT}/${ID}
    #ASSERT
    #Assert status code
    
    ${STATUS_CODE_EXPECTED}=    Convert To String    ${RESPONSE.status_code}
    Should Be Equal    ${STATUS_CODE_EXPECTED}    200
    #Assert content
    ${CONTENT_EXPECTED}=    Convert To String    ${RESPONSE.content}
    Should Contain    ${CONTENT_EXPECTED}    Registro exclu\xc3\xaddo com sucesso
