

import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:get/get_connect/connect.dart';

class PromocionProvider extends GetConnect {
    Future <Response> getDataModelPromocion() async {
        var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.publicPromocion);
        final raw = await get(url.toString());

        if (raw.statusCode == 200) {
            // Imprimir el contenido de la respuesta en la consola
            print('Contenido de la respuesta entero   ssss:');
            print(raw.bodyString);

            return raw;
        } else if (raw.statusCode == 400) {
            print('Contenido de la respuestassssss: ${raw.statusCode}');
            final message = raw.body('message');
            throw message;
        } else {
            print('Error - Status Code: ${raw.statusCode}, Body: ${raw.body}');
            throw 'Problemas de conexión';
        }

    }
}