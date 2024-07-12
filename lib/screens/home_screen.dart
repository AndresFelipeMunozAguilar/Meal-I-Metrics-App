import 'package:flutter/material.dart';

import '../models/dish.dart' as models;
import '../models/order.dart' as services;
import '../models/order_dish.dart' as services;
import '../services/supabase_service.dart' as services;
import '../widgets/bar_chart_widget.dart';
import '../widgets/pie_chart_widget.dart';

class HomeScreen extends StatefulWidget {
  final String supabaseUrl;
  final String supabaseKey;

  HomeScreen({required this.supabaseUrl, required this.supabaseKey});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late services.SupabaseService supabaseService;
  late Future<Map<String, int>> dishSalesFuture;
  late Future<Map<DateTime, double>> salesByDateFuture;

  @override
  void initState() {
    super.initState();
    supabaseService = services.SupabaseService(widget.supabaseUrl, widget.supabaseKey);
    dishSalesFuture = _loadDishSales();
    salesByDateFuture = _loadSalesByDate();
  }

  Future<Map<String, int>> _loadDishSales() async {
    final dishes = await supabaseService.getDishes();
    final orderDishes = await supabaseService.getOrderDishes();
    return calculateDishSales(dishes, orderDishes);
  }

  Future<Map<DateTime, double>> _loadSalesByDate() async {
    final dishes = await supabaseService.getDishes();
    final orders = await supabaseService.getOrders();
    final orderDishes = await supabaseService.getOrderDishes();
    return calculateSalesByDate(dishes, orders, orderDishes);
  }

  Map<String, int> calculateDishSales(List<models.Dish> dishes, List<services.OrderDish> orderDishes) {
    Map<int, int> dishSales = {};

    for (var orderDish in orderDishes) {
      if (!dishSales.containsKey(orderDish.dishId)) {
        dishSales[orderDish.dishId] = 0;
      }
      dishSales[orderDish.dishId] = dishSales[orderDish.dishId]! + orderDish.quantity;
    }

    Map<String, int> dishSalesNamed = {};
    for (var dish in dishes) {
      dishSalesNamed[dish.name] = dishSales[dish.id] ?? 0;
    }

    return dishSalesNamed;
  }

  Map<DateTime, double> calculateSalesByDate(List<models.Dish> dishes, List<services.Order> orders, List<services.OrderDish> orderDishes) {
    Map<DateTime, double> salesByDate = {};

    for (var order in orders) {
      salesByDate[order.createdAt] = 0.0;
    }

    for (var orderDish in orderDishes) {
      var order = orders.firstWhere((o) => o.id == orderDish.orderId);
      var dish = dishes.firstWhere((d) => d.id == orderDish.dishId);
      salesByDate[order.createdAt] = salesByDate[order.createdAt]! + (dish.unitPrice * orderDish.quantity);
    }

    return salesByDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas de Platillos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Map<String, int>>(
              future: dishSalesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay datos disponibles'));
                } else {
                  return BarChartWidget(dishSales: snapshot.data!);
                }
              },
            ),
            FutureBuilder<Map<DateTime, double>>(
              future: salesByDateFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay datos disponibles'));
                } else {
                  return PieChartWidget(salesByDate: snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
