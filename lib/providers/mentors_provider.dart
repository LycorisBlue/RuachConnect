import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mentor.dart';
import '../common/constants/app_constants.dart';

final mentorsProvider = Provider<List<Mentor>>((ref) {
  return [
    Mentor(
      id: '1',
      name: 'Jean Dupont',
      type: AppConstants.userTypeEncadreur,
      phone: '+33123456789',
    ),
    Mentor(
      id: '2',
      name: 'Marie Martin',
      type: AppConstants.userTypeCAN,
      phone: '+33123456790',
    ),
    Mentor(
      id: '3',
      name: 'Paul Durand',
      type: AppConstants.userTypeEncadreur,
      phone: '+33123456791',
    ),
    Mentor(
      id: '4',
      name: 'Sophie Bernard',
      type: AppConstants.userTypePasteur,
      phone: '+33123456792',
    ),
  ];
});