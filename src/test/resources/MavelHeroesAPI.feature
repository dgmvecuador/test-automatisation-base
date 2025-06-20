Feature: Marvel Characters API

  Background:
    * configure ssl = true

  Scenario: Obtener todos los personajes
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/destevez/api/characters'
    When method get
    Then status 200

  Scenario: Obtener personaje por ID (exitoso)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/destevez/api/characters/1'
    When method get
    Then status 200

  Scenario: Obtener personaje por ID (no existe)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/destevez/api/characters/0'
    When method get
    Then status 404