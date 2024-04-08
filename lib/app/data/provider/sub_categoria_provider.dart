import 'package:dashboard_bloc/app/data/model/model_sub_categoria/sub_categoria_data.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:get/get.dart';

class SubCategoriaProvider extends GetConnect {
    
    Future<Response> getDataModelSubCategoria({required String idCategoria}) async {
        try {
            var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.productosAllIdCagetoria}/$idCategoria');
            final response = await get(url.toString());
            //print('el url es : $url');

            if (response.statusCode == 200) {
                final data = response.body['data'] as List<dynamic>;
                for (var producto in data) {
                    // ignore: unused_local_variable
                    final subCategoriaData = SubCategoriaData(
                        id:             producto['id'] as String,
                        idcategoria:    producto['idcategoria'] as String, 
                        nombre:         producto['nombre'] as String, 
                        precio:         producto['precio'] as double,
                        imagen:         producto['imagen'] != null ? producto['imagen'] as String : '',
                        descripcion:    producto['descripcion'] != null ? producto['descripcion'] as String : '',
                        activo:         producto['activo'] as bool,
                        time:           producto['time'] as String, // Convertir la cadena a DateTime si no es nulo
                        calorias:       producto['calorias'] as double,
                        createdAt:      producto['created_at'] as int,
                        updatedAt:      producto['updated_at'] as int?
                    );            
                }
    
                return response;

            } else if (response.statusCode == 400) {
                //print('El servidor devolvió un código de estado 400.');
                throw Exception('Error: Código de estado 400');
            } else if (response.statusCode == 500) {
                //print('El servidor devolvió un código de estado 500.');
                throw Exception('Error: Código de estado 500');
            } else {
                //print('El servidor devolvió un código de estado inesperado: ${response.statusCode}');
                throw Exception('Error inesperado: Código de estado ${response.statusCode}');
            }
        } catch (e) {
            //print('error 1   : $e');    
            throw Exception('Error durante la solicitud HTTP 1: $e');       
        }
    }
}
