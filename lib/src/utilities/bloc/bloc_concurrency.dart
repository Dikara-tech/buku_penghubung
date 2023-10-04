import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<Event> debounceTime<Event>() {
  return (events, mapper) {
    return events
        .debounceTime(const Duration(milliseconds: 800))
        .switchMap(mapper);
  };
}
