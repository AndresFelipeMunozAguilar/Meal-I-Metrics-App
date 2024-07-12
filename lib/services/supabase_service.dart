import 'package:supabase/supabase.dart';

import '../models/dish.dart';
import '../models/order.dart';
import '../models/order_dish.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService(String supabaseUrl, String supabaseKey)
      : client = SupabaseClient('https://ddyveuettsjaxmdbijgb.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRkeXZldWV0dHNqYXhtZGJpamdiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMzA1MDgzNCwiZXhwIjoyMDI4NjI2ODM0fQ.FoRjsJj9d7R-XSkNN4hokmfmTG-mEcr2QuWWT9RFnxc');

  Future<List<Dish>> getDishes() async {
    final response = await client.from('Platillo').select().execute();
    if (response.error != null) {
      throw response.error!;
    }
    final data = response.data as List<dynamic>;
    return data.map((map) => Dish.fromMap(map)).toList();
  }

  Future<List<Order>> getOrders() async {
    final response = await client.from('Pedido').select().execute();
    if (response.error != null) {
      throw response.error!;
    }
    final data = response.data as List<dynamic>;
    return data.map((map) => Order.fromMap(map)).toList();
  }

  Future<List<OrderDish>> getOrderDishes() async {
    final response = await client.from('Relacion_Pedido_Platillo').select().execute();
    if (response.error != null) {
      throw response.error!;
    }
    final data = response.data as List<dynamic>;
    return data.map((map) => OrderDish.fromMap(map)).toList();
  }
}
