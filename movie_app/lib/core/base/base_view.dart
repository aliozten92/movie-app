import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/base/base_view_model.dart';

abstract class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  T createViewModel();
  Widget buildView(BuildContext context, T viewModel);

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late final T _viewModel;
  final _logger = Logger();

  @override
  void initState() {
    super.initState();
    _viewModel = widget.createViewModel();
    _logger.i('${widget.runtimeType} sayfası açıldı');
    _initializeViewModel();
  }

  Future<void> _initializeViewModel() async {
    try {
      await _viewModel.init();
      _logger.i('${widget.runtimeType} view model başlatıldı');
    } catch (e, stackTrace) {
      _logger.e('${widget.runtimeType} view model başlatılırken hata oluştu',
          error: e, stackTrace: stackTrace);
    }
  }

  @override
  void dispose() {
    _logger.i('${widget.runtimeType} sayfası kapatıldı');
    _viewModel.dispose();
    super.dispose();
  }

  void logInfo(String message) => _logger.i(message);
  void logError(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
  void logWarning(String message) => _logger.w(message);
  void logDebug(String message) => _logger.d(message);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: _viewModel,
      child: Consumer<T>(
        builder: (context, viewModel, _) {
          return widget.buildView(context, viewModel);
        },
      ),
    );
  }
}
