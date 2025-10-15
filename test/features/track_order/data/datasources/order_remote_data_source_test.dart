import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/features/track_order/data/models/order_model.dart';
import 'package:flower_app/features/track_order/data/datasources/order_remote_data_source.dart';

import 'order_remote_data_source_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  QuerySnapshot,
  Stream,
  OrderModel
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockUserCollection;
  late MockCollectionReference<Map<String, dynamic>> mockOrderCollection;
  late MockDocumentReference<Map<String, dynamic>> mockOrderDoc;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocSnap;
  late OrderRemoteDataSourceImpl dataSource;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockUserCollection = MockCollectionReference();
    mockOrderCollection = MockCollectionReference();
    mockOrderDoc = MockDocumentReference();
    mockDocSnap = MockDocumentSnapshot();
    dataSource = OrderRemoteDataSourceImpl(mockFirestore);
  });

  test('getOrderById returns OrderModel for existing doc', () async {
    when(mockFirestore.collection('users')).thenReturn(mockUserCollection);
    when(mockUserCollection.doc(any)).thenReturn(mockOrderDoc);
    when(mockOrderDoc.collection('orders')).thenReturn(mockOrderCollection);
    when(mockOrderCollection.doc(any)).thenReturn(mockOrderDoc);
    when(mockOrderDoc.get()).thenAnswer((_) async => mockDocSnap);
    when(mockDocSnap.exists).thenReturn(true);
    when(mockDocSnap.data()).thenReturn(<String, dynamic>{
      "id": "id",
      "arrivedAtPickup": false,
      "createdAt": 123,
      "driverId": "d",
      "items": [],
      "lastUpdated": 0,
      "orderNumber": "o",
      "paymentMethod": "p",
      "pickupAddress": <String, dynamic>{},
      "state": "received",
      "total": 10,
      "update_order_button": "received",
      "userAddress": <String, dynamic>{}
    });

    final result = await dataSource.getOrderById(userId: 'u', orderId: 'o');
    expect(result, isA<OrderModel>());
    expect(result?.id, 'id');
  });

  test('getOrderById returns null when doc does not exist', () async {
    when(mockFirestore.collection('users')).thenReturn(mockUserCollection);
    when(mockUserCollection.doc(any)).thenReturn(mockOrderDoc);
    when(mockOrderDoc.collection('orders')).thenReturn(mockOrderCollection);
    when(mockOrderCollection.doc(any)).thenReturn(mockOrderDoc);
    when(mockOrderDoc.get()).thenAnswer((_) async => mockDocSnap);
    when(mockDocSnap.exists).thenReturn(false);

    final result = await dataSource.getOrderById(userId: 'u', orderId: 'o');
    expect(result, isNull);
  });
}
