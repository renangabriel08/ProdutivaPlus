import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Biometria {
  static final LocalAuthentication auth = LocalAuthentication();

  static verificarCompatibilidade(context) async {
    if (await auth.isDeviceSupported()) {
      verificarBiometrias(context);
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  static verificarBiometrias(context) async {
    final List<BiometricType> biometrias = await auth.getAvailableBiometrics();

    if (biometrias.isNotEmpty) {
      entrar(context);
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  static entrar(context) async {
    try {
      final bool entrou = await auth.authenticate(
        localizedReason: 'Utilize biometria para entrar',
      );

      if (entrou) {
        Navigator.pushNamed(context, '/home');
      }
    } on PlatformException {
      //Erro
    }
  }
}
