import 'package:flutter/material.dart';
import 'package:mealimetrics/widgets/home_admin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mealimetrics/widgets/home_widget.dart';
import 'package:mealimetrics/pages/gestion_empleados.dart';

class HomeGerente extends StatefulWidget {
  const HomeGerente({super.key});

  @override
  State<HomeGerente> createState() => _HomeGerenteState();
}

class _HomeGerenteState extends State<HomeGerente> {
  final supabase = Supabase.instance.client;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 209, 254),
        title: const Text(
          'Home Gerente',
          style: TextStyle(fontSize: 25,
          fontWeight: FontWeight.bold
            )
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left:15),
          child: IconButton( // Aquí se crea el botón de flecha <- 
            icon: const Icon(Icons.logout_sharp,size: 28), // Icono de flecha hacia atrás
            onPressed: () {
              signOut(); //Cierra la sesion
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0), 
            child: IconButton(
              icon: const Icon(Icons.account_circle_sharp, size: 35), 
              onPressed: () {
                Navigator.pushNamed(context, '/actualizarDatos');
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: _selectedIndex == 0
            ? const GestionEmpleados() 
            : _selectedIndex == 1
              ? const Text('Contenido de la página 2')
              : const Text('Contenido de la página 3'), 
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_person_outlined, size: 30),
            label: 'Empleados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined, size: 30),
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.no_food_outlined, size: 30),
            label: 'Menú',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 20,
        unselectedFontSize: 20,
      ),
    );
  }

  Future<void> signOut() async {
    final User? user = supabase.auth.currentUser;
    if (user?.id == "effc93b2-b2d6-46bc-a6e8-983457c819dc") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeAdmin()));
      return;
    }

    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
  }
}