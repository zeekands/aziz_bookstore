import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/search_book/search_book_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'dummy_data/dummy_data.dart';

class MockGetListBookUsecae extends Mock implements GetListBookUsecae {
  @override
  Future<Either<Failure, BookList>> execute(BookRequestModel params) async {
    if (params.search == "query") {
      return Right(books);
    } else {
      return const Left(ServerFailure("Server Failure", 500));
    }
  }
}

void main() {
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<GetListBookUsecae>(() => MockGetListBookUsecae());

  group('SearchBookCubit', () {
    late SearchBookCubit cubit;
    late MockGetListBookUsecae mockGetListBookUsecae;

    setUp(() {
      mockGetListBookUsecae = getIt<GetListBookUsecae>() as MockGetListBookUsecae;
      cubit = SearchBookCubit(mockGetListBookUsecae);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const SearchBookState.initial());
    });

    blocTest<SearchBookCubit, SearchBookState>(
      'emits [loading, loaded] when searchBook is successful',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.searchBook("query"),
      expect: () => [
        const SearchBookState.loading(),
        SearchBookState.loaded(books),
      ],
    );

    blocTest<SearchBookCubit, SearchBookState>(
      'emits [loading, error] when searchBook is unsuccessful',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.searchBook("false"),
      expect: () => [
        const SearchBookState.loading(),
        const SearchBookState.error(ServerFailure("Server Failure", 500)),
      ],
    );

    blocTest<SearchBookCubit, SearchBookState>(
      'emits [Load More] when searchBook is successful',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.searchBook("false"),
      expect: () => [
        const SearchBookState.loading(),
        const SearchBookState.error(ServerFailure("Server Failure", 500)),
      ],
    );
  });
}
