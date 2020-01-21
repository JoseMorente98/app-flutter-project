import 'dart:async';

import 'package:app_flutter_form/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //INSERT VALUES
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //LISTEN STRING
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => 
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  void dispose() { 
    _emailController?.close();
    _passwordController?.close();
  }

  //GET VALUES
  String get email => _emailController.value;
  String get password => _passwordController.value;
}