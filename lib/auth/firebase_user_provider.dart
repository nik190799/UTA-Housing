import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UTAHousingFirebaseUser {
  UTAHousingFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

UTAHousingFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<UTAHousingFirebaseUser> uTAHousingFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<UTAHousingFirebaseUser>(
      (user) {
        currentUser = UTAHousingFirebaseUser(user);
        return currentUser!;
      },
    );
