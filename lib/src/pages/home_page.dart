//import 'package:app_flutter_form/src/bloc/provider.dart';
import 'package:app_flutter_form/src/models/product_model.dart';
import 'package:app_flutter_form/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {

    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
      /*Center(child: Column(
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Text('Password: ${bloc.password}'),
        ],
      ),),*/
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: (){
        Navigator.pushNamed(context, 'producto');
      },
    );
  }

  _crearListado() {
    return FutureBuilder(
      future: productoProvider.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) => _crearItem(context, snapshot.data[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel productoModel) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
         color: Colors.purple,
      ),
      onDismissed: (direccion) {
        productoProvider.borrarProducto(productoModel.id);
      },
      child: ListTile(
        title: Text('${productoModel.titulo} - ${productoModel.valor}'),
        subtitle: Text(productoModel.id),
        onTap: ()=> Navigator.pushNamed(context, 'producto', arguments: productoModel),
      ),
    );
  }
}