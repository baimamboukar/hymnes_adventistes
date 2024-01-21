import 'package:flutter_bloc/flutter_bloc.dart';

class SabbathSongsBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // Log or handle the event in a more serious manner
    // Example: Analytics or external logging
    // AnalyticsService.logEvent(event.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Handle error in a more serious manner
    // Example: Send error report to a server
    // ErrorReportingService.reportError(error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Handle state change in a more serious manner
    // Example: Notify analytics about state changes
    // AnalyticsService.logStateChange(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Handle transition in a more serious manner
    // Example: Log transitions for monitoring
    // MonitoringService.logTransition(transition.toString());
  }
}
