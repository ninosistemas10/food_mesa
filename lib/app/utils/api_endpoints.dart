
class ApiEndPoints {
    static String baseUrl = 'http://localhost:8081';
    //static String baseUrl = 'https://6a8b-2a0c-5a83-a202-a00-30d1-846a-f388-df5e.ngrok-free.app';
    static AuthEndPoints authEndpoints = AuthEndPoints();
}

class AuthEndPoints {
    final String registerEmail  = '/ninosistemas/public/users';
    final String loginEmail     = '/ninosistemas/public/login';


    final String publicCategory   = '/ninosistemas/public/category';
    final String adminCategory    = '/ninosistemas/admin/category';
    final String adminCategoryImage = '/ninosistemas/admin/category/upDateNoImagen';
    final String productosAllIdCagetoria = '/ninosistemas/public/productos/categoria';
    
    
    final String adminProductos = '/ninosistemas/admin/productos';
    final String publicProductos = '/ninosistemas/public/productos';
    final String adminProductosImage = '/ninosistemas/admin/productos/upDateNoImagen';


    final String publicMesa = '/ninosistemas/public/mesa';
    final String adminMesa = '/ninosistemas/admin/mesa';


    final String publicPromocion = '/ninosistemas/public/promocion';
    final String adminPromocion = '/ninosistemas/admin/promocion';
}
