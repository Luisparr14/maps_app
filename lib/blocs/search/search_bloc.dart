import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<SearchEvent>((event, emit) {});
    on<OnToggleManualMarker>((event, emit) =>
        emit(state.copyWith(displayManualMarker: event.activate)));
  }

  Future getCoordsStartToEnd(LatLng start, LatLng end) async {
    final res = await trafficService.getCoordsStartToEnd(start, end);
    return res;
  }
}
