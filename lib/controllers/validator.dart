class Validator {
  static validarForm(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static validarTituloTarefa(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length > 17) {
      return 'Máximo de 17 caractéres';
    }
    return null;
  }

  static validarTituloHabito(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length > 20) {
      return 'Máximo de 20 caractéres';
    }
    return null;
  }
}
