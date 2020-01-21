import 'package:app_flutter_form/src/bloc/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(child: Column(
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Text('Password: ${bloc.password}'),
        ],
      ),),
    );
  }
}