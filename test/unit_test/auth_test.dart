import 'package:flutter_test/flutter_test.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity Tests', () {
    test('should correctly initialize AuthEntity', () {
      const auth = AuthEntity(
        userId: '123',
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        image: 'profile.jpg',
        password: 'securepassword',
      );

      expect(auth.userId, '123');
      expect(auth.fName, 'Adarsh');
      expect(auth.lName, 'Bajracharya');
      expect(auth.email, 'adarsh@example.com');
      expect(auth.phone, '1234567890');
      expect(auth.address, 'Teku');
      expect(auth.image, 'profile.jpg');
      expect(auth.password, 'securepassword');
    });

    test('should support value equality', () {
      const auth1 = AuthEntity(
        userId: '123',
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        image: 'profile.jpg',
        password: 'securepassword',
      );

      const auth2 = AuthEntity(
        userId: '123',
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        image: 'profile.jpg',
        password: 'securepassword',
      );

      expect(auth1, equals(auth2));
    });

    test('should return different instances for different properties', () {
      const auth1 = AuthEntity(
        userId: '123',
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        password: 'securepassword',
      );

      const auth2 = AuthEntity(
        userId: '124', // Different userId
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        password: 'securepassword',
      );

      expect(auth1, isNot(equals(auth2)));
    });

    test('should allow nullable userId', () {
      const auth = AuthEntity(
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        password: 'securepassword',
      );

      expect(auth.userId, isNull);
    });

    test('should allow nullable image', () {
      const auth = AuthEntity(
        userId: '123',
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        password: 'securepassword',
      );

      expect(auth.image, isNull);
    });

    test('should fail equality check when password differs', () {
      const auth1 = AuthEntity(
        userId: '123',
        fName: 'Adarsh',
        lName: 'Bajracharya',
        email: 'adarsh@example.com',
        phone: '1234567890',
        address: 'Teku',
        password: 'password1',
      );

      const auth2 = AuthEntity(
        userId: '123',
        fName: 'John',
        lName: 'Doe',
        email: 'john@example.com',
        phone: '1234567890',
        address: '123 Street',
        password: 'password2', // Different password
      );

      expect(auth1, isNot(equals(auth2)));
    });

    test('should correctly override props method', () {
      const auth = AuthEntity(
        userId: '123',
        fName: 'John',
        lName: 'Doe',
        email: 'john@example.com',
        phone: '1234567890',
        address: '123 Street',
        image: 'profile.jpg',
        password: 'securepassword',
      );

      expect(auth.props, [
        '123',
        'John',
        'Doe',
        'profile.jpg',
        'john@example.com',
        '1234567890',
        '123 Street',
        'securepassword'
      ]);
    });

    test('should handle empty string values properly', () {
      const auth = AuthEntity(
        userId: '',
        fName: '',
        lName: '',
        email: '',
        phone: '',
        address: '',
        image: '',
        password: '',
      );

      expect(auth.userId, '');
      expect(auth.fName, '');
      expect(auth.lName, '');
      expect(auth.email, '');
      expect(auth.phone, '');
      expect(auth.address, '');
      expect(auth.image, '');
      expect(auth.password, '');
    });

    test('should correctly compare objects with only required properties', () {
      const auth1 = AuthEntity(
        fName: 'Alice',
        lName: 'Smith',
        email: 'alice@example.com',
        phone: '9876543210',
        address: '456 Road',
        password: 'mypassword',
      );

      const auth2 = AuthEntity(
        fName: 'Alice',
        lName: 'Smith',
        email: 'alice@example.com',
        phone: '9876543210',
        address: '456 Road',
        password: 'mypassword',
      );

      expect(auth1, equals(auth2));
    });

    test('should be different if one has image and other does not', () {
      const auth1 = AuthEntity(
        userId: '123',
        fName: 'Bob',
        lName: 'Brown',
        email: 'bob@example.com',
        phone: '1122334455',
        address: '789 Avenue',
        image: 'bob.jpg',
        password: 'securepass',
      );

      const auth2 = AuthEntity(
        userId: '123',
        fName: 'Bob',
        lName: 'Brown',
        email: 'bob@example.com',
        phone: '1122334455',
        address: '789 Avenue',
        password: 'securepass',
      );

      expect(auth1, isNot(equals(auth2)));
    });
  });
}
