import 'trip_details_screen_args.dart'; // We will create this as well

enum TripStatus { upcoming, completed, cancelled }

class TripModel {
  final String from;
  final String fromSub;
  final String to;
  final String toSub;
  final int duration;
  final double distance;
  final int seats;
  final int totalSeats;
  final int price;
  final TripStatus status;
  final String date;
  final String time;
  final String driver;
  final String driverInitial;
  final double driverRating;
  final int driverTrips;
  final String carModel;
  final bool isRecurring;

  const TripModel({
    required this.from,
    this.fromSub = 'Tulkarm, Palestine',
    required this.to,
    this.toSub = 'Main Square, Tulkarm',
    required this.duration,
    this.distance = 8.5,
    required this.seats,
    this.totalSeats = 4,
    required this.price,
    this.status = TripStatus.upcoming,
    this.date = 'Today, March 2',
    this.time = '2:30 PM',
    this.driver = 'Mohammed K.',
    this.driverInitial = 'M',
    this.driverRating = 4.8,
    this.driverTrips = 142,
    this.carModel = 'Hyundai i10',
    this.isRecurring = false,
  });

  TripDetailsArgs toArgs() => TripDetailsArgs(
    from: from,
    fromSub: fromSub,
    to: to,
    toSub: toSub,
    duration: duration,
    distance: distance,
    seats: seats,
    price: price,
    status: status == TripStatus.upcoming ? 'available' : 'completed',
    driverName: driver,
    driverInitial: driverInitial,
    driverRating: driverRating,
    driverTrips: driverTrips,
    carModel: carModel,
    date: date,
    time: time,
  );
}

// ─────────────────────── Mock Data ───────────────────────

final List<TripModel> mockAvailableTrips = const [
  TripModel(from: 'PTUK University', to: 'City Center', duration: 10, seats: 3, price: 8),
  TripModel(from: 'City Center', to: 'PTUK University', duration: 25, seats: 2, price: 22),
  TripModel(from: 'City Center', to: 'PTUK University', duration: 25, seats: 2, price: 8),
];

final List<TripModel> mockMyTrips = const [
  TripModel(from: 'PTUK University', to: 'City Center', duration: 15, seats: 1, price: 8, status: TripStatus.upcoming, date: 'Today - 2:30 PM', driver: 'Mohammed K.'),
  TripModel(from: 'City Center', to: 'PTUK University', duration: 15, seats: 1, price: 8, status: TripStatus.completed, date: 'Feb 28 - 9:00 AM', driver: 'Fatima H.'),
  TripModel(from: 'PTUK University', to: 'City Center', duration: 15, seats: 1, price: 8, status: TripStatus.cancelled, date: 'Feb 27 - 3:00 PM', driver: 'Yousef S.'),
];

final List<TripModel> mockCarpoolTrips = const [
  TripModel(from: 'PTUK University', to: 'City Center', duration: 15, seats: 2, totalSeats: 4, price: 6, driver: 'Mohammed K.', driverInitial: 'M', carModel: 'Hyundai i10', time: '3:00 PM'),
  TripModel(from: 'City Center', to: 'PTUK University', duration: 15, seats: 3, totalSeats: 4, price: 6, driver: 'Sara A.', driverInitial: 'S', carModel: 'Toyota Yaris', time: '8:00 AM', isRecurring: true),
  TripModel(from: 'PTUK University', to: 'City Center', duration: 15, seats: 1, totalSeats: 3, price: 5, driver: 'Ali M.', driverInitial: 'A', carModel: 'Kia Picanto', time: '5:00 PM'),
];
