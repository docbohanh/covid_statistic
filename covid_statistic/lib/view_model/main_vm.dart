import 'package:covid_statistic/model/covid_stats.dart';
import 'package:rxdart/rxdart.dart';

import 'base_vm.dart';

class MainViewModel extends BaseViewModel {
  final BehaviorSubject<List<CovidStats>> _statsResponse = BehaviorSubject();

  Function(List<CovidStats>) get statsResponse => _statsResponse.sink.add;

  Stream<List<CovidStats>> get stats => _statsResponse.stream;

  fetchedStatistic() async {
    repo.getWorldometersInfo().then((value) {
      statsResponse(value);
    }).catchError((error) {
      errorEvent(error);
      statsResponse([]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _statsResponse.close();
  }
}