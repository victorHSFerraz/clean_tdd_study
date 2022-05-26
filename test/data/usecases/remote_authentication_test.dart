import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:surveys_app/data/http/http_client.dart';
import 'package:surveys_app/data/usecases/remote_authentication.dart';
import 'package:surveys_app/domain/usecases/authentication.dart';
import 'package:test/test.dart';

void main() {
  late final RemoteAuthentication sistemUnderTest;
  late final HttpClientSpy httpClient;
  late final String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sistemUnderTest = RemoteAuthentication(
      httpClient: httpClient,
      url: url,
    );
  });
  test(
    'should call httpClient with correct values',
    () async {
      final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
      // act
      await sistemUnderTest.auth(params);
      // assert
      verify(
        httpClient.request(
          url: url,
          method: 'post',
          body: {
            'email': params.email,
            'password': params.password,
          },
        ),
      );
    },
  );
}

class HttpClientSpy extends Mock implements HttpClient {}
