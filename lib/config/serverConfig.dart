class ServerConfig {

  //172.20.30.82
  //192.168.1.109
  //172.20.30.149
  //192.168.1.134
  //192.168.43.98
  //192.168.43.213

  static const domainNameServer = "http://192.168.1.109:8000/api/employee";

  static const login = "/login";
  static const addCategory = "/addCategory";
  static const editCategory = "/updateCategory";
  static const deleteCategory = "/deleteCategory";
  static const displayCategory = "/displayCategory";
  static const addMeal = "/add_meals?type=meal";
  static const updateMeal = "/update_meal?type=meal";
  static const deleteMeal = "/delete_meal?type=meal";
  static const displayMeals = "/displayMeals?type=meal";
  static const addDrink = "/add_meals?type=drink";
  static const updateDrink = "/update_meal?type=drink";
  static const deleteDrink = "/delete_meal?type=drink";
  static const displayDrinks = "/displayMeals?type=drink";
  static const addMenu = "/addMenu";
  static const dropMenu = "/dropMenu";
  static const displayMenuMeal = "/displayMenu?menu=1&type=meal";
  static const displayMenuDrink = "/displayMenu?menu=1&type=drink";
  static const displayRemovedMeal = "/displayMenu?menu=0&type=meal";
  static const displayRemovedDrink = "/displayMenu?menu=0&type=drink";
  static const addOffer = "/addOffer";
  static const setUnActiveOffer = "/unactiveOffer";
  static const displayOffers = "/displayOffers";
  static const displayActiveOffers = "/displayOffers?active=1";
  static const displayUnActiveOffers = "/displayOffers?active=0";
  static const logout = "/logout";
  static const displayReservation = "/displayWaitReservation";
  static const displayWaitReservation = "/displayWaitDoneReservation";
  static const setDoneReservation = "/setDoneReservation";
  static const displayOrders = "/displayWaitOrder";
  static const acceptRejectOrder = "/acceptOrRejectOrder";
  static const displayAcceptOrders = "/displayAcceptOrder";
  static const displayRejectOrders = "/displayRejectOrder";
  static const acceptRejectReservation = "/setStateReservation";
  static const displayTables = "/displayTables";
  static const openCloseTables = "/closeOrOpenTable";


}