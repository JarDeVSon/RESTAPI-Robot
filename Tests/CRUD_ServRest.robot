*** Settings ***
Documentation   Documentacao da API: https://serverest.dev/#/
Resource        Resource.robot


*** Test Cases ***


TC: Add a new user (POST)
    [Documentation]     Adiciona um novo usuario
    [Tags]      POST    
    Create Session API
    POST On Session Request
    Validate Status Code    201
    Validate Dict Item    message  Cadastro realizado com sucesso
    Validate Content    Cadastro realizado com sucesso

TC: Returns all the users (GET)
    [Documentation]     Retorna todos os usuarios
    [Tags]      GET
    Create Session API
    GET On Session Request
    Validate Status Code    200

TC: Return user with Query Parameters: Name and Email (GET - Params)
    [Documentation]     Retorna usuario com os parâmetros consultados
    [Tags]      GET
    Create Session API
    GET On Session Request with Query Parameters "nome=Fulano da Silva"
    GET On Session Request with Query Parameters "email=fulano@qa.com"
    Validate Status Code    200
    Validate Content    Fulano da Silva
    Validate Content    fulano@qa.com


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


