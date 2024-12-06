import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatefulWidget {
  @override
  _OrderConfirmationScreenState createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  String orderStatus = "Preparando";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: const Text(
          'Pedido Confirmado',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Pedido Confirmado!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Obrigado por comprar conosco. Acompanhe o status do seu pedido abaixo.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            _buildStatusTile('Preparando', orderStatus == 'Preparando'),
            _buildStatusTile('A caminho', orderStatus == 'A caminho'),
            _buildStatusTile('Entregue', orderStatus == 'Entregue'),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _updateOrderStatus,
              child: const Text(
                'Atualizar Status',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTile(String status, bool isActive) {
    return ListTile(
      leading: Icon(
        isActive ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isActive ? Colors.green : Colors.grey,
      ),
      title: Text(
        status,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.green : Colors.grey,
        ),
      ),
    );
  }

  void _updateOrderStatus() {
    setState(() {
      if (orderStatus == "Preparando") {
        orderStatus = "A caminho";
      } else if (orderStatus == "A caminho") {
        orderStatus = "Entregue";
      }
    });
  }
}
