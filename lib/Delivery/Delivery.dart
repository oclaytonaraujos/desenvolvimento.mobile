import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  // Aqui você pode adicionar parâmetros, como o ID do pedido, status, etc., se necessário
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        elevation: 0,
        title: const Text(
          'Acompanhar Pedido',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status do Pedido:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Aqui você pode adicionar o status do pedido
            Card(
              color: Colors.yellow[100],
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Pedido em andamento',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Seu pedido está sendo preparado e será entregue em breve!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.5, // Aqui você pode alterar com base no progresso real
                      color: Colors.yellow[700],
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Estimativa de entrega: 20 minutos',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Aqui você pode adicionar a lógica para mostrar mais detalhes ou atualizar o pedido
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Atualizando status do pedido...'),
                  ),
                );
              },
              child: const Text('Atualizar Status', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}