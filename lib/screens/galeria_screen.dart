import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:examen_p2/helpers/database_helper.dart';

class GaleriaScreen extends StatefulWidget {
  const GaleriaScreen({super.key});

  @override
  State<GaleriaScreen> createState() => _GaleriaScreenState();
}

class _GaleriaScreenState extends State<GaleriaScreen> {
  List<Map<String, dynamic>> _registros = [];
  final String _autor = 'AV-D';

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    List<Map<String, dynamic>> datos = await DatabaseHelper.instance
        .getRegistros(_autor);
    setState(() {
      _registros = datos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería SQLite')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Autor: $_autor',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _registros.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _registros.length,
                    itemBuilder: (context, index) {
                      var registro = _registros[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: registro['imageUrl'],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(registro['titulo']),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
