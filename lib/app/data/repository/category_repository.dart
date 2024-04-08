
import 'package:dashboard_bloc/app/data/model/model_categoria/model_category.dart';
import 'package:dashboard_bloc/app/data/provider/category_provider.dart';

CategoryProvider categoryProvider = CategoryProvider();

class CategoryRepository {
    Future<ModelCategory> getDataModelCategory() async {
        final raw = await categoryProvider.getDataModelCategory();
        final data = raw.body;
        ModelCategory modelCategory = ModelCategory.fromJson(data);
        return modelCategory;
    }
}  