// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  FirebaseAuth,
], customMocks: [
  MockSpec<FirebaseAuth>(
      as: #MockFirebaseAuthForTest, onMissingStub: OnMissingStub.returnDefault),
])
void main() {}
