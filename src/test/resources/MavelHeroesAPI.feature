@sequential
Feature: Marvel Characters API

  Background:
    * configure ssl = true
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def username = 'destevez-' + now()

  Scenario: Obtener todos los personajes
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    Given url urlFinal
    When method get
    Then status 200

  Scenario: Obtener personaje por ID (exitoso)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    * def jsonBody =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Genius billionaire",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 201
    * def urlFinalConsulta = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters/1'
    Given url urlFinalConsulta
    When method get
    Then status 200

  Scenario: Obtener personaje por ID (no existe)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters/0'
    Given url urlFinal
    When method get
    Then status 404

  Scenario: Crear personaje (exitoso)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    * def jsonBody =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Genius billionaire",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 201

  Scenario: Crear personaje (nombre duplicado)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    * def jsonBody =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Genius billionaire",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 201
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 400

  Scenario: Crear personaje (faltan campos requeridos)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    * def jsonBody =
      """
      {
        "name": "",
        "alterego": "",
        "description": "",
        "powers": []
      }
      """
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 400

  Scenario: Actualizar personaje (exitoso)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    * def jsonBody =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Genius billionaire",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 201
    * def urlFinalActualizacion = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters/1'
    * def jsonBodyActualizacion =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Updated description",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinalActualizacion
    And request jsonBodyActualizacion
    When method put
    Then status 200

  Scenario: Actualizar personaje (no existe)
    * def urlFinalActualizacion = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters/999'
    * def jsonBodyActualizacion =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Updated description",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinalActualizacion
    And request jsonBodyActualizacion
    When method put
    Then status 404

  Scenario: Eliminar personaje (exitoso)
    * def urlFinal = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters'
    * def jsonBody =
      """
      {
        "name": "Iron Man",
        "alterego": "Tony Stark",
        "description": "Genius billionaire",
        "powers": ["Armor", "Flight"]
      }
      """
    Given url urlFinal
    And request jsonBody
    When method post
    Then status 201
    * def urlFinalActualizacion = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters/1'
    Given url urlFinalActualizacion
    When method delete
    Then status 204

  Scenario: Eliminar personaje (exitoso)
    * def urlFinalActualizacion = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'+username+'/api/characters/999'
    Given url urlFinalActualizacion
    When method delete
    Then status 404
