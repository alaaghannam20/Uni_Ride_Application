class TripDetailsArgs {
  final String from;
  final String fromSub;
  final String to;
  final String toSub;
  final int duration;
  final double distance;
  final int seats;
  final int price;
  final String status;
  final String date;
  final String time;
  final String driverName;
  final String driverInitial;
  final double driverRating;
  final int driverTrips;
  final String carModel;
  final String carColor;
  final String plateNumber;
  final int carYear;
  final int? bookedSeats;

  const TripDetailsArgs({
    required this.from,
    this.fromSub = 'Tulkarm, Palestine',
    required this.to,
    this.toSub = 'Main Square, Tulkarm',
    required this.duration,
    this.distance = 8.5,
    required this.seats,
    required this.price,
    this.status = 'available',
    this.date = 'Today, March 2',
    this.time = '2:30 PM',
    this.driverName = 'Mohammed K.',
    this.driverInitial = 'M',
    this.driverRating = 4.8,
    this.driverTrips = 142,
    this.carModel = 'Hyundai i10',
    this.carColor = 'White',
    this.plateNumber = '7-1234-98',
    this.carYear = 2022,
    this.bookedSeats,
  });
}
