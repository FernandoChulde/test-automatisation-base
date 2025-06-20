@REQ_jchuldeb  @reportejchuldeb
Feature: Test de API súper simple

  Background:
    * configure ssl = true
    * def urlApi = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    * def urlApiId = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/'

  Scenario: Verificar que un endpoint público responde 200
    Given url 'https://httpbin.org/get'
    When method get
    Then status 200

  @id:1 @obtenerPersonajesExitoso
  Scenario: Respuesta exitosa Obtener todos los personajes
    Given url urlApi
    When method GET
    Then status 200
    And match response == '#notnull'
    * print response

  @id:2 @obtenerPersonajesIDExitoso
  Scenario: Respuesta exitosa Obtener personaje por ID
    * def id = 554
    Given url urlApiId + id
    When method GET
    Then status 200
    And match response == '#notnull'
    * print response

  @id:3 @obtenerPersonajesIDNoExitoso
  Scenario: Respuesta cuando personaje por ID no existe
    * def id = 999
    Given url urlApiId + id
    When method GET
    Then status 404
    And match response == '#notnull'
    * print response

  @id:4 @crearPersonajeExitoso
  Scenario: Crear un personaje exitosamente
    Given url urlApi
    And header Content-Type = 'application/json'
    And def pathBody = read('classpath:personajes/crear-personaje-body.json')
    And request pathBody
    When method POST
    Then status 201
    And match response == '#notnull'
    * print response

  @id:5 @crearPersonajeDuplicado
  Scenario: Crear un personaje nombre duplicado
    Given url urlApi
    And header Content-Type = 'application/json'
    And def pathBody = read('classpath:personajes/crear-personaje-duplicado-body.json')
    And request pathBody
    When method POST
    Then status 400
    And match response == '#notnull'
    * print response

  @id:6 @crearPersonajeSinCamposRequeridos
  Scenario: Crear un personaje faltando campos requeridos
    Given url urlApi
    And header Content-Type = 'application/json'
    And def pathBody = read('classpath:personajes/crear-personaje-sin-campos-body.json')
    And request pathBody
    When method POST
    Then status 400
    And match response == '#notnull'
    * print response

  @id:7 @actualizarPersonajeExitoso
  Scenario: Actualizar personaje exitoso
    * def id = 554
    Given url urlApiId + id
    And header Content-Type = 'application/json'
    And def pathBody = read('classpath:personajes/editar-personaje-body.json')
    And request pathBody
    When method PUT
    Then status 200
    And match response == '#notnull'
    * print response

  @id:8 @actualizarPersonajeNoExitoso
  Scenario: Actualizar personaje que no existe
    * def id = 999
    Given url urlApiId + id
    And header Content-Type = 'application/json'
    And def pathBody = read('classpath:personajes/editar-personaje-body.json')
    And request pathBody
    When method PUT
    Then status 404
    And match response == '#notnull'
    * print response

  @id:9 @eliminarPersonajeExitoso
  Scenario: Eliminar personaje exitoso
    * def id = 664
    Given url urlApiId + id
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 204
    And match response == ''
    * print response

  @id:10 @eliminarPersonajeNoExitoso
  Scenario: Eliminar personaje que no existe
    * def id = 999
    Given url urlApiId + id
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 404
    And match response == '#notnull'
    * print response

