class Api {
  /// base url

  static const baseUrl = "https://intensely-optimal-unicorn.ngrok-free.app";
  //static const socket = "https://socket.thirdshotslot.co.uk/";


  ///auth
  static const signup = "$baseUrl/auth/register/";//done
  static const login = "$baseUrl/auth/login/"; //done
  static const verification = "$baseUrl/auth/verify-otp/"; //done
  static const forgotPassword = "$baseUrl/auth/forgot-password/"; //done
  static const resetPassword = "$baseUrl/auth/set-new-password/"; //done

  /// homepage
  static const categories = "$baseUrl/home/categories/";
  static const searchByCategories = "$baseUrl/home/shops/search/?category_name=";
  static const beyondNeighbourhood = "$baseUrl/home/shops/search/?is_beyond_neighborhood=true";
  static const speedyDeliveries = "$baseUrl/home/shops/search/?ordering=delivery_time_minutes";

  /// search
  static const frequentSearch = "$baseUrl/auth/all-search-history/";

  /// Discover list
  static const discoverList = "$baseUrl/discover/list/";

  /// Profile
  static const followedVendors = "$baseUrl/vendors/customers/followed-vendors/";
  static const cart = 'https://intensely-optimal-unicorn.ngrok-free.app/order/cart/';

  static String menu(int userId) {
    return "$baseUrl/discover/menu/1/name";
  }

  static String menuPatch(int menuId) {
    return "$baseUrl/discover/menu/$menuId/update-item-selection/";
  }

  /// Orders
  static const activeOrders = "$baseUrl/discover/my-orders/?status=active";
  static const completedOrders = "$baseUrl/discover/my-orders/?status=completed";

  static const deals = 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/deals/';
}