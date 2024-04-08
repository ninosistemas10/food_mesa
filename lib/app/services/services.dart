import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:get/get.dart';


class DataService extends GetConnect implements GetxService{

    

    Future <Response> postData(String uri, dynamic body) async{
        Response response = await post(
        ApiEndPoints.baseUrl + uri,
            body, 
            headers: { 'Content-Type' : 'application/json; charset=UTF-8' }
    
        );
        return response;
    }

}