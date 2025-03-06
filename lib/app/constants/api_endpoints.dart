class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receiveTimeOut = Duration(seconds: 1000);
  // for android
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // for iphone
  // static const String baseUrl = "http://localhost:3000/api/v1/";

  // ======== Auth ===============
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String uploadImage = "auth/uploadImage/";
  static const String getUser = "auth/";
  static const String updateUser = "auth/update/";

  // ====================== Item Routes ======================
  static const String createItem = "product/create";
  static const String getAllItems = "product/getAllProducts";
  static const String deleteItem = "product/";

  //========================= Booking Routes ======================
  static const String createBooking = "booking/booking";
  static const String getAllBookings = "booking/bookings";
  static const String deleteBooking = "booking/booking/";
  static const String getBookingsById = "/bookings/customer/";
}
