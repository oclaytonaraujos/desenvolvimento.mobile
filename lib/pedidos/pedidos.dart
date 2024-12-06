import 'package:flutter/material.dart';
import 'package:mamamia_pizzaria/pagamento/pagamento.dart';

class PedidoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  PedidoScreen({required this.cart});

  @override
  _PedidoScreenState createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  double calculateTotal() {
    double total = 0.0;
    for (var item in widget.cart) {
      final price = double.tryParse(item['price']?.toString() ?? '0') ?? 0.0;
      final quantity = item['quantity'] ?? 0;
      total += price * quantity;
    }
    return total;
  }

  void increaseQuantity(int index) {
    setState(() {
      widget.cart[index]['quantity'] =
          (widget.cart[index]['quantity'] ?? 0) + 1;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if ((widget.cart[index]['quantity'] ?? 1) > 1) {
        widget.cart[index]['quantity']--;
      } else {
        removeItem(index);
      }
    });
  }

  void removeItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Item'),
        content:
            const Text('Tem certeza que deseja remover este item do carrinho?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.cart.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Pedido'),
        backgroundColor: Colors.orange.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Ação para o ícone do carrinho
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Itens Selecionados:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
            const SizedBox(height: 10),
            widget.cart.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Seu carrinho está vazio!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) {
                        var item = widget.cart[index];
                        final price =
                            double.tryParse(item['price']?.toString() ?? '0') ??
                                0.0;
                        final quantity = item['quantity'] ?? 0;
                        return Card(
                          color: Colors.orange.shade50,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.fastfood,
                              color: Colors.orange.shade700,
                            ),
                            title: Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Tamanho: ${item['size']}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: SizedBox(
                              width:
                                  130, // Ajuste o tamanho total para comportar os botões e o texto
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'R\$ ${(quantity * price).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange.shade700,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly, // Centraliza os botões e o texto
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decreaseQuantity(index),
                                        icon: const Icon(Icons.remove,
                                            color: Colors.red),
                                        iconSize:
                                            16, // Ajusta o tamanho do ícone
                                        padding: const EdgeInsets.all(
                                            0), // Remove o padding padrão
                                        constraints:
                                            const BoxConstraints(), // Remove restrições extras
                                      ),
                                      Text(
                                        '$quantity',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            increaseQuantity(index),
                                        icon: const Icon(Icons.add,
                                            color: Colors.green),
                                        iconSize: 16,
                                        padding: const EdgeInsets.all(0),
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onLongPress: () => removeItem(index),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.orange.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'R\$ ${calculateTotal().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      cart: widget.cart,
                      totalFromOrders: calculateTotal(),
                      itemCount: widget.cart.length,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  'Pagar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
