import 'dart:io';
import 'package:dashboard_bloc/app/data/model/model_sub_categoria/sub_categoria_data.dart';
import 'package:dashboard_bloc/app/data/model/model_sub_categoria/sub_categoria_model.dart';
import 'package:dashboard_bloc/app/data/provider/sub_categoria_provider.dart';

SubCategoriaProvider subCategoriaProvider = SubCategoriaProvider();

class SubCategoriaRepository {
    Future<SubCategoriaModel?> getDataModelSubCategoria({required String idCategoria}) async {
        try {
            final response = await subCategoriaProvider.getDataModelSubCategoria(idCategoria: idCategoria);
            if (response.body == null) {
                // Manejar el caso en el que el cuerpo de la respuesta es nulo
                return null;
            }

            final data1 = response.body['data'] as List<dynamic>;
            List<SubCategoriaData> subCategoriaList = [];

            for (var producto in data1) {
                final subCategoriaData = SubCategoriaData(
                    id:             producto['id'] as String,
                    idcategoria:    producto['idcategoria'] as String,
                    nombre:         producto['nombre'] as String,
                    precio:         producto['precio'] as double,
                    imagen:         producto['imagen'] != null ? producto['imagen'] as String : '',
                    descripcion:    producto['descripcion'] != null ? producto['descripcion'] as String : '',
                    activo:         producto['activo'] as bool,
                    time:           producto['time'] as String,
                    calorias:       producto['calorias'] as double,
                    createdAt:      producto['created_at'] as int,
                    updatedAt:      producto['updated_at'] as int?,
                );
                subCategoriaList.add(subCategoriaData);
            }

            return SubCategoriaModel(data: subCategoriaList, errors: null, messages: []);
        } catch (e) {
            if (e is SocketException) {
                // Maneja errores de red
                print('Error de red: $e');
                return null; // O muestra un mensaje al usuario
            } else {
                // Maneja otros errores
                print('Error inesperado: $e');
                // Opcionalmente, relanza la excepción con más información
                throw Exception('Error en getDataModelSubCategoria: $e');
            }
        }
    }
}
