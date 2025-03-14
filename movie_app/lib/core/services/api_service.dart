import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:movie_app/core/config/flavors.dart';
import 'package:logger/logger.dart';

class ApiService {
  late final Dio _dio;
  late final String _baseUrl;
  late final String _apiKey;
  late final String _imageBaseUrl;
  bool _isInitialized = false;
  final _logger = Logger();

  ApiService();

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _logger.i('Config dosyası yükleniyor...');
      final configJson =
          await rootBundle.loadString('assets/config/config.json');
      _logger.d('Config dosyası yüklendi: $configJson');

      final config = json.decode(configJson);
      _logger.d('Config parse edildi: $config');

      // Flavor'a göre config seçimi
      final flavorConfig = config[F.appFlavor.toString().split('.').last];
      if (flavorConfig == null) {
        throw Exception('Flavor config bulunamadı: ${F.appFlavor}');
      }

      _baseUrl = flavorConfig['base_url'] as String;
      _apiKey = flavorConfig['api_key'] as String;
      _imageBaseUrl = flavorConfig['image_base_url'] as String;

      _logger.i('Dio başlatılıyor...');
      _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (F.isDev || F.isQa) {
        _dio.interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (object) => _logger.d(object.toString()),
        ));
      }

      _isInitialized = true;
      _logger.i('ApiService başarıyla başlatıldı');

      // Test connection
      try {
        final response = await _dio.get('/configuration');
        _logger.i('API bağlantısı başarılı: ${response.statusCode}');
      } catch (e) {
        _logger.e('API bağlantı testi başarısız', error: e);
        rethrow;
      }
    } catch (e, stackTrace) {
      _logger.e('ApiService başlatılırken hata oluştu',
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  String getImageUrl(String path) {
    if (path.isEmpty) return '';
    return '$_imageBaseUrl$path';
  }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      _logger.i('Trend filmler yükleniyor...');
      final response = await _dio.get('/movie/top_rated');
      _logger.d('API yanıtı alındı: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw Exception('API yanıt kodu hatalı: ${response.statusCode}');
      }

      final results = response.data['results'] as List;
      _logger.i('${results.length} film bulundu');

      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e, stackTrace) {
      _logger.e('Trend filmler yüklenirken hata oluştu',
          error: e, stackTrace: stackTrace);
      throw Exception('Failed to load trending movies: $e');
    }
  }

  Future<List<Movie>> getMoviesByCategory(String categoryId) async {
    try {
      if (categoryId == 'trend') {
        return getTrendingMovies();
      }

      _logger.i('$categoryId kategorisindeki filmler yükleniyor...');
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: {
          'with_genres': categoryId,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('API yanıt kodu hatalı: ${response.statusCode}');
      }

      final List<dynamic> results = response.data['results'];
      _logger.i('${results.length} film bulundu');
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e, stackTrace) {
      _logger.e('Kategori filmleri yüklenirken hata oluştu',
          error: e, stackTrace: stackTrace);
      throw Exception('Failed to load movies by category: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      _logger.i('Film araması yapılıyor: $query');
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );

      if (response.statusCode != 200) {
        throw Exception('API yanıt kodu hatalı: ${response.statusCode}');
      }

      final results = response.data['results'] as List;
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e, stackTrace) {
      _logger.e('Film araması başarısız', error: e, stackTrace: stackTrace);
      throw Exception('Failed to search movies: $e');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      _logger.i('Film detayları yükleniyor: $movieId');
      final response = await _dio.get('/movie/$movieId');

      if (response.statusCode != 200) {
        throw Exception('API yanıt kodu hatalı: ${response.statusCode}');
      }

      return Movie.fromJson(response.data);
    } catch (e, stackTrace) {
      _logger.e('Film detayları alınamadı', error: e, stackTrace: stackTrace);
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      _logger.i('Popüler filmler yükleniyor...');
      final response = await _dio.get('/movie/popular');

      if (response.statusCode != 200) {
        throw Exception('API yanıt kodu hatalı: ${response.statusCode}');
      }

      final results = response.data['results'] as List;
      _logger.i('${results.length} popüler film bulundu');
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e, stackTrace) {
      _logger.e('Popüler filmler alınamadı', error: e, stackTrace: stackTrace);
      throw Exception('Failed to load popular movies: $e');
    }
  }
}
