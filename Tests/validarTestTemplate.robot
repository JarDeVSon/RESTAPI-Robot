*** Settings ***
Documentation   Documentacao da API: https://serverest.dev/#/

Resource    BDDpt-br.robot
Resource    ResourceTestTemplate.robot



*** Test Cases ***


Scenario - 01 - (POST) Validar usuario inserido no ServRest
    Dado que Create Session API
    Quando executo uma requisicao POST na API "batata", "a34sas214123a4sas@qa.com", "teste", "true"
    eu valido Status Code   201
    eu valido Conteudo  "Cadastro realizado com sucesso"

Scenario - 02 - (GET) Validar busca por usuarios no ServRest
    Dado que Create Session API
    Quando realizo uma requisicao GET na API
    eu valido Status Code   200

Scenario - 03 - (PUT) Validar usuario alterado no ServRest
    Dado que Create Session API
    Quando executo uma requisicao PUT na API "go", "heasashe@qa.com", "teste", "true"
    eu valido Status Code  200
    eu valido Conteudo  "Registro alterado com sucesso"
Scenario - 04 - (DELETE) Validar (DELETE) usuario deletado no ServRest
    Dado que Create Session API
    Quando realizo uma requisicao DELETE na API
    eu valido Status Code  200
#   eu valido Conteudo     "Registro excluido com sucesso"


Scenario Outline 01 - (POST) Validar response das informações do usuario inserido no ServRest
    [Template]      Template Scenario Outline 01 - (POST) Validar (POST) usuario inserido no ServRest
    #NOME   #email            #senha  admin(true or false)   #statuscode    # msg sucesso
    bora    lets31gas4123314o@qa.com.br     faker       true            201             Cadastro realizado com sucesso

Scenario Outline 02 - (GET) Validar response das informações do usuarios buscados no ServRest
    [Template]      Template Scenario Outline 02 - (GET) Validar response das informações dos usuarios buscados no ServRest
    #statusCode
    200
Scenario Outline 03 - (PUT) Validar (PUT) usuario alterado no ServRest
    [Template]      Template Scenario Outline 03 - (PUT) Validar (PUT) usuario alterado no ServRest
    #NOME   #email              #senha      #admin(true or false) #statuscode # msg sucesso
    alteera    alteasre@qa.com.br     faker       true            200        Registro alterado com sucesso

Scenario Outline 04 - (DELETE) Validar (DELETE) usuario deletado no ServRest
    [Template]      Template Scenario Outline 04 - (DELETE) Validar (DELETE) usuario deletado no ServRest
    #statusCode
    200     #Registro excluido com sucesso

