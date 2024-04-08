

import 'package:dashboard_bloc/app/data/model/model_mesa/model_mesa.dart';
import 'package:dashboard_bloc/app/data/provider/mesa_provider.dart';


MesaProvider mesaProvider = MesaProvider();

class MesaRepository {
  Future<ModelMesa> getDataModelMesa() async {
    try {
       final raw = await mesaProvider.getDataModelMesa();
        final data = raw.body;
        ModelMesa modelMesa = ModelMesa.fromJson(data);
        return modelMesa;
    } catch (e) {
      throw 'Error al obtener los datos de la mesa: $e';
    }
  }
}
