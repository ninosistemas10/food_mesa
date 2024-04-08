

import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:get/get.dart';

class MesaProvider extends GetConnect{

    Future <Response> getDataModelMesa() async {
        var headers = {
            'Content-Type': 'application/json; charset=utf-8',
        };
        var url = Uri.parse( ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.publicMesa);
        final raw = await get(url.toString(), headers: headers);

        if (raw.statusCode == 200){
            print('aceto el status');
            return raw;
        } else if (raw.statusCode == 400){
            final message = raw.body('message');
            throw message;
        } else {
            throw 'problemas de conexion';
        }
        
    }

    

}