import 'package:flutter/material.dart';
import 'package:mamamia_pizzaria/pedidos/pedidos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String selectedCategory = 'pizzas';
  final List<Map<String, dynamic>> cart = [];

  // Listas fictícias para as opções
  final List<Map<String, dynamic>> pizzas = [
    {
      'image': 'lib/assets/pizza1.jpg',
      'title': 'MARGHERITA',
      'description': 'Mussarela, Tomate e Manjericão',
      'sizes': {
        'Pequena': '20.00',
        'Média': '25.00',
        'Grande': '30.00',
      },
    },
    {
      'image': 'lib/assets/pizza2.jpg',
      'title': 'CALABRESA',
      'description': 'Mussarela, Calabresa e Cebola',
      'sizes': {
        'Pequena': '18.00',
        'Média': '22.00',
        'Grande': '28.00',
      },
    },
    {
      'image': 'lib/assets/pizza3.jpg',
      'title': 'FRANGO COM CATUPIRY',
      'description': 'Mussarela, Frango desfiado e Catupiry',
      'sizes': {
        'Pequena': '22.00',
        'Média': '27.00',
        'Grande': '32.00',
      },
    },
    {
      'image': 'lib/assets/pizza4.jpg',
      'title': 'PORTUGUESA',
      'description': 'Mussarela, Presunto, Ovo, Cebola e Azeitona',
      'sizes': {
        'Pequena': '23.00',
        'Média': '28.00',
        'Grande': '33.00',
      },
    },
    {
      'image': 'lib/assets/pizza5.jpg',
      'title': 'QUATRO QUEIJOS',
      'description': 'Mussarela, Parmesão, Gorgonzola e Provolone',
      'sizes': {
        'Pequena': '24.00',
        'Média': '29.00',
        'Grande': '35.00',
      },
    },
    {
      'image': 'lib/assets/pizza6.jpg',
      'title': 'BAIANA',
      'description': 'Mussarela, Calabresa picante, Pimenta e Cebola',
      'sizes': {
        'Pequena': '22.00',
        'Média': '27.00',
        'Grande': '32.00',
      },
    },
    {
      'image': 'lib/assets/pizza7.jpg',
      'title': 'CARNE SECA',
      'description': 'Mussarela, Carne seca desfiada e Cebola roxa',
      'sizes': {
        'Pequena': '25.00',
        'Média': '30.00',
        'Grande': '36.00',
      },
    },
  ];

  final List<Map<String, dynamic>> desserts = [
    {
      'image': 'lib/assets/dessert1.jpg',
      'title': 'CHOCOLATE',
      'description': 'Mussarela, chocolate e granulado.',
      'sizes': {
        'Pequena': '22.00',
        'Média': '28.00',
        'Grande': '35.00',
      },
    },
    {
      'image': 'lib/assets/dessert2.jpg',
      'title': 'DOCE DE LEITE',
      'description': 'Mussarela, doce de leite e coco.',
      'sizes': {
        'Pequena': '20.00',
        'Média': '26.00',
        'Grande': '32.00',
      },
    },
    {
      'image': 'lib/assets/dessert3.jpg',
      'title': 'BRIGADEIRO',
      'description': 'Mussarela, chocolate ao leite e granulado de chocolate.',
      'sizes': {
        'Pequena': '23.00',
        'Média': '29.00',
        'Grande': '36.00',
      },
    },
    {
      'image': 'lib/assets/dessert4.jpg',
      'title': 'PRESTÍGIO',
      'description': 'Mussarela, chocolate ao leite e coco ralado.',
      'sizes': {
        'Pequena': '24.00',
        'Média': '30.00',
        'Grande': '37.00',
      },
    },
    {
      'image': 'lib/assets/dessert5.jpg',
      'title': 'BANANA COM CANELA',
      'description': 'Mussarela, banana em rodelas, açúcar e canela.',
      'sizes': {
        'Pequena': '21.00',
        'Média': '27.00',
        'Grande': '33.00',
      },
    },
    {
      'image': 'lib/assets/dessert6.avif',
      'title': 'ROMEU E JULIETA',
      'description': 'Mussarela, goiabada e queijo cremoso.',
      'sizes': {
        'Pequena': '22.00',
        'Média': '28.00',
        'Grande': '34.00',
      },
    },
    {
      'image': 'lib/assets/dessert7.jpg',
      'title': 'MORANGO COM CHOCOLATE',
      'description': 'Mussarela, morangos frescos e chocolate ao leite.',
      'sizes': {
        'Pequena': '25.00',
        'Média': '31.00',
        'Grande': '38.00',
      },
    },
  ];

  
   List<Map<String, dynamic>> beverages = [
  {
    'image': 'lib/assets/drink1.jpg',
    'title': 'REFRIGERANTE',
    'description': 'Refrigerante de limão.',
    'sizes': {
      '350ml': 5.00,
      '600ml': 7.50,
      '1L': 10.00,
    },
  },
  {
    'image': 'lib/assets/drink2.jpg',
    'title': 'ÁGUA COM GÁS',
    'description': 'Água mineral com gás.',
    'sizes': {
      '300ml': 3.00,
      '500ml': 4.50,
      '1L': 6.50,
    },
  },
  {
    'image': 'lib/assets/drink3.jpg',
    'title': 'ÁGUA SEM GÁS',
    'description': 'Água mineral sem gás.',
    'sizes': {
      '300ml': 2.50,
      '500ml': 3.50,
      '1L': 5.00,
    },
  },
  {
    'image': 'lib/assets/drink4.jpg',
    'title': 'SUCO DE LARANJA',
    'description': 'Suco natural de laranja.',
    'sizes': {
      '300ml': 4.50,
      '500ml': 6.00,
      '1L': 8.50,
    },
  },
  {
    'image': 'lib/assets/drink5.jpg',
    'title': 'REFRIGERANTE COLA',
    'description': 'Refrigerante sabor cola.',
    'sizes': {
      '350ml': 5.00,
      '600ml': 7.50,
      '1L': 10.00,
    },
  },
  {
    'image': 'lib/assets/drink6.jpg',
    'title': 'REFRIGERANTE GUARANÁ',
    'description': 'Refrigerante sabor guaraná.',
    'sizes': {
      '350ml': 5.00,
      '600ml': 7.50,
      '1L': 10.00,
    },
  },
  {
    'image': 'lib/assets/drink7.jpg',
    'title': 'CHÁ GELADO',
    'description': 'Chá gelado sabor pêssego.',
    'sizes': {
      '300ml': 4.50,
      '500ml': 6.00,
      '1L': 8.00,
    },
  },
  {
    'image': 'lib/assets/drink8.jpg',
    'title': 'MOJITO',
    'description': 'Drink refrescante com rum, limão e hortelã.',
    'sizes': {
      '200ml': 12.00,
      '350ml': 15.00,
    },
  },
];



  void addToCart(Map<String, dynamic> item) {
  setState(() {
    // Check if the item already exists in the cart
    bool itemExists = cart.any((cartItem) =>
        cartItem['title'] == item['title'] &&
        cartItem['size'] == item['size']);
    if (!itemExists) {
      cart.add(item);
    }
  });
}

 Widget buildContent() {
  List<Map<String, dynamic>> items;
  switch (selectedCategory) {
    case 'doces':
      items = desserts;
      break;
    case 'bebidas':
      items = beverages;
      break;
    default:
      items = pizzas;
  }

  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Permitir seleção de tamanho para bebidas
              if (selectedCategory == 'pizzas' ||
                  selectedCategory == 'doces' ||
                  selectedCategory == 'bebidas') {
                showSizeSelectionDialog(items[index]);
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(items[index]['image']!,
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index]['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[index]['description']!,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

  void showSizeSelectionDialog(Map<String, dynamic> item) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Escolha o tamanho - ${item['title']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: item['sizes'].keys.map<Widget>((size) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  size,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('R\$ ${item['sizes'][size]}'),
                onTap: () {
                  Map<String, dynamic> selectedItem = {
                    'title': item['title'],
                    'size': size,
                    'price': item['sizes'][size],
                  };
                  addToCart(selectedItem);
                  Navigator.of(context).pop();
                },
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mamamia Pizzaria'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('PIZZAS', 'pizzas'),
                _buildCategoryButton('DOCES', 'doces'),
                _buildCategoryButton('BEBIDAS', 'bebidas'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          buildContent(),
          // Botão "Meu Pedido", visível apenas quando o carrinho não estiver vazio
          if (cart.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PedidoScreen(cart: cart, ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ), // Cor de fundo do botão
                ),
                child: const Text(
                  'Meu Pedido',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label, String category) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedCategory == category ? Colors.orange : Colors.grey[300],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 2,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedCategory == category ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
