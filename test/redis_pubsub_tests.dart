library redis_pubsub_tests;

import 'package:redis_client/redis_client.dart';
import 'package:test/test.dart';

import 'helper.dart';

main() {
  group('PubSub tests', () {
    RedisClient client;

    RedisClient client1;

    setUp(() {
      return RedisClient.connect("127.0.0.1:6379").then((c) {
        client = c;
        client.flushall();
      }).then((a) {
        return RedisClient.connect("127.0.0.1:6379").then((c1) {
          client1 = c1;
        });
      });
    });

    tearDown(() {
      try {
        client.close();
        client1.close();
      } finally {}
    });

    test("publish", () {
      async(client.publish("redizzz", "izzzkool").then((val) {
        expect(val, equals(0));
      }));
    });

    test("subscribe & publish", () {
      async(client.subscribe(["chan0"], (Receiver message) {
        message.receiveMultiBulkStrings().then((List<String> message) {
          expect(message[0], equals("message"));
          expect(message[1], equals("chan0"));
          expect(message[2], equals("You okay?"));
        });
      }).then((m) {
        client1.publish("chan0", "You okay?");
      }));
    });

    test("Can work after unsubscribe", () {
      async(client.subscribe(["chan0"], (Receiver message) {
        return message
            .receiveMultiBulkStrings()
            .then((bb) => client.unsubscribe(["chan0"]))
            .then((v) => client.set("key", "val"))
            .then((c1) => client.get("key"))
            .then((ttt) {
          expect(ttt, equals("val"));
        });
      }).then((a) => client1.publish("chan0", "You okay?")));
    });
  });
}
