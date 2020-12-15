part of 'extensions.dart';

extension FirebaseUserExtension on User {
  Users convertToUser({String name = "No Name"}) =>
      Users(this.uid, this.email, name: name);
}
