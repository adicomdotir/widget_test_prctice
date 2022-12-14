import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/data/models/post_model.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'PostModel serialization/deserialization',
    () {
      test(
        'post successfully serialized',
        () {
          final jsonResult = jsonDecode(fixture('post.json'));
          final fromJsonModel = PostModel.fromJson(jsonResult);

          expect(fromJsonModel, mockPost);
        },
      );

      test(
        'post successfully deserialized',
        () {
          final jsonResult = jsonDecode(fixture('post.json'));
          final mockPostToJson = mockPost.toJson();

          expect(jsonResult, equals(mockPostToJson));
        },
      );
    },
  );
}
