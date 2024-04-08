

import 'package:dashboard_bloc/app/data/model/model_promocion/model_promocion.dart';
import 'package:dashboard_bloc/app/data/provider/promocion_provider.dart';

PromocionProvider promocionProvider = PromocionProvider();

class PromocionRepository {
    Future <ModelPromocion> getDataModelPromocion() async {
        final raw = await promocionProvider.getDataModelPromocion();
        final data = raw.body;

        ModelPromocion modelPromocion = ModelPromocion.fromJson(data);
        return modelPromocion;
    } 
}