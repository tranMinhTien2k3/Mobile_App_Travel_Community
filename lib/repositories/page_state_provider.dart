import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);

final pageControllerProvider = Provider<PageController>((ref) => PageController());

final tickerProvider = Provider<TickerProvider>((ref){
  throw UnimplementedError('TickerProvider shoul be implemend');
});

final tabControllerProvider = Provider.autoDispose<TabController>((ref){
  final TickerProvider vsync = ref.watch(tickerProvider);
  final currentPage = ref.watch(currentPageProvider.notifier).state;
  return TabController(length: 4, vsync: vsync);
});