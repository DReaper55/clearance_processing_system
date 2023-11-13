enum LoadState { loading, idle, success, error, loadmore, done }

enum ImageType { single, multi }

enum VendorBusinessType {
  consumables,
  products,
  restaurant,
  grocery,
  gas,
  cloth,
  phone,
  appliance,
  art,
  book,
  nonConsumables,
  services,
  logistics,
  bookings,
}

enum OrderStatus {
  driver, // pending SendMe driver selection
  driverAccepted, // SendMe driver agreed to pickup order
  driverRejected, // SendMe driver denied request to pickup order
  pending,
  denied,
  canceled,
  moving,
  response,
  confirmed,
  awaiting,
  processing,
  ready,
  checkedIn, // for bookings vendors
  paid,
  reviewed,
  report,
  completed,
  refunded,
  transferred,
}

enum PopupAction { edit, create, done }

enum DeliveryType { standard, sendMe, pickup }

enum PayStackSubStatus { active, inactive }
