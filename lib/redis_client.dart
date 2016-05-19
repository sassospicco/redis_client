/**
 * A redis client that communicates with redis through a socket and exposes
 * a high level API.
 *
 * Internally, it uses the [RedisProtocolTransformer] to transform binary
 * data from the socket to formatted [RedisReply]s.
 *
 * Please see the [RedisClient] documentation for detailed documentation on
 * how to use this library.
 */
library redis_client;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import 'redis_protocol_transformer.dart';

part 'redis_client/redis_client.dart';
part 'redis_client/redis_client_commands.dart';
part 'redis_client/redis_connection.dart';
part 'redis_client/redis_connection_settings.dart';
part 'redis_client/redis_serializer.dart';
