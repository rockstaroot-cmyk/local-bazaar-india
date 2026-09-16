
import 'package:flutter/material.dart';

void main() {
  runApp(const LocalBazaarApp());
}

class LocalBazaarApp extends StatelessWidget {
  const LocalBazaarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Bazaar India',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String role = 'customer';
  final phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.storefront, size: 80, color: Colors.green),
              const Text('Local Bazaar', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const Text('India ka Apna Market', style: TextStyle(fontSize: 14)),
              const Text('Kirana | Fashion | Electronics | Furniture', style: TextStyle(fontSize: 12)),
              const Text('Available only in India 🇮🇳', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 32),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'customer', label: Text('I want to Buy'), icon: Icon(Icons.shopping_cart)),
                  ButtonSegment(value: 'owner', label: Text('I want to Sell'), icon: Icon(Icons.store)),
                ],
                selected: {role},
                onSelectionChanged: (s) => setState(() => role = s.first),
              ),
              const SizedBox(height: 24),
              TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, maxLength: 10, decoration: const InputDecoration(prefixText: '+91 ', labelText: 'Mobile Number', border: OutlineInputBorder(), helperText: 'Only Indian numbers'))),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () { if (phoneCtrl.text.length != 10) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter 10 digit number'))); return; } Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainApp(role: role, phone: '+91${phoneCtrl.text}'))); }, child: const Text('Continue - Build APK'))),
              const SizedBox(height: 12),
              const Text('No iOS, Android only - APK ready', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  final String role; final String phone;
  const MainApp({super.key, required this.role, required this.phone});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String currentRole;
  @override
  void initState() { currentRole = widget.role; super.initState(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentRole == 'customer' ? '📍 Marathahalli, Bangalore' : 'My Shop Dashboard'), actions: [SegmentedButton<String>(segments: const [ButtonSegment(value: 'customer', label: Text('Buy')), ButtonSegment(value: 'owner', label: Text('Sell'))], selected: {currentRole}, onSelectionChanged: (s) => setState(() => currentRole = s.first)), const SizedBox(width: 8)]),
      body: currentRole == 'customer' ? const CustomerView() : const OwnerView(),
      bottomNavigationBar: NavigationBar(selectedIndex: 0, destinations: const [NavigationDestination(icon: Icon(Icons.home), label: 'Home'), NavigationDestination(icon: Icon(Icons.local_grocery_store), label: 'Kirana'), NavigationDestination(icon: Icon(Icons.shopping_bag), label: 'Bazaar'), NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'), NavigationDestination(icon: Icon(Icons.person), label: 'Account')]),
    );
  }
}

class CustomerView extends StatefulWidget { const CustomerView({super.key}); @override State<CustomerView> createState() => _CustomerViewState(); }

class _CustomerViewState extends State<CustomerView> with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  String bazaarFilter = 'All';
  final bazaarProducts = [
    {'name': 'Levis T-Shirt', 'cat': 'Fashion', 'price': 399, 'store': 'Chickpet Fashion - 2km'},
    {'name': 'Boat Rockerz 255', 'cat': 'Electronics', 'price': 1299, 'store': 'SP Road Electronics - 1.2km'},
    {'name': 'Wooden Chair', 'cat': 'Furniture', 'price': 2499, 'store': 'KR Market - 3km'},
    {'name': 'Redmi Charger 33W', 'cat': 'Electronics', 'price': 599, 'store': 'SP Road - 1.2km'},
    {'name': 'Cotton Saree', 'cat': 'Fashion', 'price': 899, 'store': 'Chickpet - 2km'},
    {'name': 'Office Table', 'cat': 'Furniture', 'price': 4999, 'store': 'KR Market - 3km'},
  ];
  @override void initState() { tabCtrl = TabController(length: 2, vsync: this); super.initState(); }
  List<Map<String, dynamic>> get filteredBazaar => bazaarFilter == 'All' ? bazaarProducts : bazaarProducts.where((p) => p['cat'] == bazaarFilter).toList();
  @override Widget build(BuildContext context) {
    return Column(children: [
      TabBar(controller: tabCtrl, tabs: const [Tab(text: 'Kirana & Daily'), Tab(text: 'Bazaar - Fashion | Electronics | Furniture')]),
      Expanded(child: TabBarView(controller: tabCtrl, children: [
        ListView(padding: const EdgeInsets.all(8), children: [const Wrap(spacing: 8, children: [Chip(label: Text('Atta & Rice')), Chip(label: Text('Oil')), Chip(label: Text('Dairy'))]), Card(child: ListTile(title: const Text('Aashirvaad Atta 5kg'), subtitle: const Text('Sharma Kirana - 320m | ₹275 MRP ₹320 🟢 Veg'), trailing: ElevatedButton(onPressed: (){}, child: const Text('ADD')))), Card(child: ListTile(title: const Text('Amul Milk 1L'), subtitle: const Text('Sharma Kirana - 280m | ₹62'), trailing: ElevatedButton(onPressed: (){}, child: const Text('ADD'))))]),
        Column(children: [
          Padding(padding: const EdgeInsets.all(8), child: Wrap(spacing: 8, children: ['All','Fashion','Electronics','Furniture'].map((f) => ChoiceChip(label: Text(f), selected: bazaarFilter == f, onSelected: (_) => setState(()=> bazaarFilter = f))).toList())),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('Showing: $bazaarFilter (${filteredBazaar.length} items) - FIXED', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
          Expanded(child: ListView.builder(itemCount: filteredBazaar.length, itemBuilder: (ctx,i){ final p=filteredBazaar[i]; return Card(child: ListTile(leading: CircleAvatar(child: Text(p['cat'][0])), title: Text("${p['name']}"), subtitle: Text("${p['cat']} | ${p['store']} | ₹${p['price']} | UPI/COD"), trailing: ElevatedButton(onPressed: (){}, child: const Text('BUY'))));})),
        ]),
      ])),
    ]);
  }
}

class OwnerView extends StatefulWidget { const OwnerView({super.key}); @override State<OwnerView> createState() => _OwnerViewState(); }
class _OwnerViewState extends State<OwnerView> {
  String ownerFilter = 'All';
  @override Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Column(children: [
      Container(color: Colors.green.shade50, padding: const EdgeInsets.all(12), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Column(children: [Text('3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), Text('New Orders')]), Column(children: [Text('₹2,450', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), Text('Today')]), Column(children: [Text('2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)), Text('Low Stock')])])),
      const TabBar(tabs: [Tab(text: 'My Kirana'), Tab(text: 'Orders'), Tab(text: 'My Bazaar')]),
      Expanded(child: TabBarView(children: [
        Stack(children: [ListView(padding: const EdgeInsets.all(8), children: const [ListTile(title: Text('Aashirvaad Atta 5kg'), subtitle: Text('Stock: 20 | ₹275 | MRP ₹320'), trailing: Icon(Icons.edit)), ListTile(title: Text('Amul Milk 1L'), subtitle: Text('Stock: 50 | ₹62'), trailing: Icon(Icons.edit))]), Positioned(bottom: 16, right: 16, child: FloatingActionButton.extended(onPressed: (){}, icon: const Icon(Icons.add), label: const Text('Add Product')))]),
        ListView(padding: const EdgeInsets.all(8), children: [Card(child: ListTile(title: const Text('Order #123 - ₹340'), subtitle: const Text('Customer: +91 98xxxxxx10 | 2 items | COD'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [ElevatedButton(onPressed: (){}, child: const Text('Accept')), const SizedBox(width: 8), OutlinedButton(onPressed: (){}, child: const Text('Reject'))])))]),
        Column(children: [Padding(padding: const EdgeInsets.all(8), child: Wrap(spacing: 8, children: ['All','Fashion','Electronics','Furniture'].map((f)=> ChoiceChip(label: Text(f), selected: ownerFilter==f, onSelected: (_)=> setState(()=> ownerFilter=f))).toList())), Expanded(child: ListView(padding: const EdgeInsets.all(8), children: const [ListTile(title: Text('Boat Headphones - Electronics'), subtitle: Text('Stock: 5 | ₹1299 | 1 Year Warranty')), ListTile(title: Text('Levis T-Shirt - Fashion'), subtitle: Text('Stock: 10 | ₹399 | S,M,L'))]))],
      ])),
    ]));
  }
}
