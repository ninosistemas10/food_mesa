

import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:get/get.dart';

class CategoryProvider extends GetConnect{

    Future <Response> getDataModelCategory() async {
        
        var url = Uri.parse( ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.publicCategory);
        final raw = await get(url.toString());

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