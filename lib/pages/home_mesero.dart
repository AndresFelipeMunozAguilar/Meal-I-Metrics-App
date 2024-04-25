import 'package:flutter/material.dart';
import 'package:mealimetrics/widgets/home_admin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mealimetrics/widgets/home_widget.dart';

class HomeMesero extends StatefulWidget {
  const HomeMesero({super.key});

  @override
  State<HomeMesero> createState() => _HomeMeseroState();
}

class _HomeMeseroState extends State<HomeMesero> {
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 209, 254),
        title: const Text(
          'Home Mesero',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
        ),
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
    if(!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
  }

}