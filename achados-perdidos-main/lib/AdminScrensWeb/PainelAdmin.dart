import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/AdminScrensWeb/Dashboard.dart';
import 'package:perdidos_e_achados/AdminScrensWeb/CategoryRegistrationScreen.dart';
import 'package:perdidos_e_achados/AdminScrensWeb/LocationRegistrationScreen.dart';

class paineladminScreen extends StatefulWidget {
  const paineladminScreen({Key? key}) : super(key: key);

  @override
  State<paineladminScreen> createState() => _paineladminScreenState();
}

class _paineladminScreenState extends State<paineladminScreen> {
  int _selectedIndex = 0;
  String _titleBarSelected = 'Dashboard';

  static final List<Widget> _widgetOptions = [
    DashboardWidget(),
    Text("Itens"),
    Text("Criar usuário admin"),
    Text("Lista de Usuarios"),
    LocationRegistrationScreen(),
    CategoryRegistrationScreen()
  ];

  void _onItemTapped(int index, String title) {
    setState(() {
      _titleBarSelected = title;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        body: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243)),
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isWeb)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Borda arredondada
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 216, 210, 210).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text(
                            _titleBarSelected,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Center(
                          child: ListTile(
                            leading: const Icon(
                              Icons.dashboard,
                              size:
                                  40.0, // Aumenta o tamanho do ícone para 30.0
                            ),
                            title: const Text('Dashboard'),
                            onTap: () {
                              _onItemTapped(0, "Dashboard");
                            },
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.emoji_objects, size: 40.0),
                          title: const Text('Itens'),
                          onTap: () {
                            _onItemTapped(1, "Itens");
                          },
                        ),
                        ExpansionTile(
                          leading: Icon(Icons.person, size: 40.0),
                          title: const Text('Usuários'),
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.add,
                                size: 40.0,
                              ),
                              title: Text("Criar usuário admin"),
                              onTap: () {
                                _onItemTapped(2, "Criar usuário admin");
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.list, size: 40.0),
                              title: Text("Lista de Usuarios"),
                              onTap: () {
                                _onItemTapped(3, "Lista de Usuarios");
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on, size: 40.0),
                          title: const Text('Localizações'),
                          onTap: () {
                            _onItemTapped(4, "Localizações");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.category, size: 40.0),
                          title: const Text('Categorias'),
                          onTap: () {
                            _onItemTapped(5, "Categorias");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _widgetOptions[_selectedIndex],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
