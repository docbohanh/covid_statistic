import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/main_info.dart';
import 'package:covid_statistic/network/response/response.dart';
import 'package:rxdart/rxdart.dart';

import 'base_vm.dart';

class MainViewModel extends BaseViewModel {
  final BehaviorSubject<CovidStatsResponse> _statsResponse = BehaviorSubject();
  final BehaviorSubject<CovidInfo> _pandemicResponse = BehaviorSubject();
  final BehaviorSubject<bool> _refresh = BehaviorSubject();
  final BehaviorSubject<MainInfo> _mainInfo = BehaviorSubject();

  MainViewModel() {
    mainInfoChanged(MainInfo.world);
  }

  Function(CovidStatsResponse) get statsResponse => _statsResponse.sink.add;
  Function(CovidInfo) get pandemicResponse => _pandemicResponse.sink.add;
  Function(bool) get onRefresh => _refresh.sink.add;
  Function(MainInfo) get mainInfoChanged => _mainInfo.sink.add;

  Stream<CovidStatsResponse> get pandemicStats => _statsResponse.stream;
  Stream<CovidInfo> get pandemicInfo => _pandemicResponse.stream;
  Stream<bool> get refreshStream => _refresh.stream;
  Stream<MainInfo> get mainInfoStream => _mainInfo.stream;

  MainInfo get mainInfoItem => _mainInfo.value;

  fetchedStatistic() async {
    repo.getWorldometersInfo().then((value) {
      statsResponse(value);
    }).catchError((error) {
      errorEvent(error);
      statsResponse(null);
    });
  }

  fetchedPandemicVN() {
    onRefresh(true);
    repo.getPandemicVN().then((value) {
      pandemicResponse(value);
      onRefresh(false);
    }).catchError((error) {
      errorEvent(error);
      pandemicResponse(null);
    });
  }

  fetchedPandemicWorld() {
    onRefresh(true);
    repo.getPandemicWorld().then((value) {
      pandemicResponse(value);
      onRefresh(false);
    }).catchError((error) {
      errorEvent(error);
      pandemicResponse(null);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _statsResponse.close();
    _pandemicResponse.close();
    _refresh.close();
    _mainInfo.close();
  }
}