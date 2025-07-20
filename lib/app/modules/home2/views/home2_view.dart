import 'package:flutter/material.dart';

class Home2View extends StatefulWidget {
  const Home2View({super.key});

  @override
  State<Home2View> createState() => _Home2ViewState();
}

class _Home2ViewState extends State<Home2View> {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.breakfast_dining, 'label': 'Breakfast'},
    {'icon': Icons.local_cafe, 'label': 'Coffee'},
    {'icon': Icons.shopping_bag, 'label': 'Grocery'},
    {'icon': Icons.fastfood, 'label': 'Fast Food'},
    {'icon': Icons.set_meal, 'label': 'Wings'},
    {'icon': Icons.local_pizza, 'label': 'Pizza'},
  ];

  final List<Map<String, dynamic>> shops = [
    {'name': '7-Eleven', 'time': '10 min'},
    {'name': 'Speedway', 'time': '15 min'},
    {'name': 'Lowe\'s', 'time': '20 min'},
    {'name': 'Wawa', 'time': '10 min'},
    {'name': 'Pet Supplies', 'time': '11 min'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Deals'),
          BottomNavigationBarItem(icon: Icon(Icons.local_mall), label: 'My Deals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 5),
                  const Text("Elizabeth City", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Icon(Icons.notifications_none),
                  const SizedBox(width: 10),
                  const Icon(Icons.shopping_bag_outlined),
                ],
              ),
              const SizedBox(height: 16),
              const Text.rich(
                TextSpan(
                  text: 'Hungry? ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                  children: [
                    TextSpan(
                      text: 'See What’s Cooking\nNear You',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search food, store, deals…',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(categories[index]['icon'], size: 28),
                        ),
                        const SizedBox(height: 8),
                        Text(categories[index]['label'], style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  FilterChip(label: const Text("Pick-up"), onSelected: (_) {}),
                  const SizedBox(width: 10),
                  FilterChip(label: const Text("Offers"), onSelected: (_) {}),
                  const SizedBox(width: 10),
                  FilterChip(label: const Text("Delivery Fee"), onSelected: (_) {}),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Beyond Your Neighborhood", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("See All", style: TextStyle(color: Colors.redAccent))
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('assets/food_banner.png'),
                    ),
                    const SizedBox(height: 8),
                    const Text('Sonic', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('US\$0 Delivery Free • 16 mi'),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text("4.5 (27) • 45 min"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text("Shops Near You", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: shops.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(shops[index]['name'][0]),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          shops[index]['name'],
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          shops[index]['time'],
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
