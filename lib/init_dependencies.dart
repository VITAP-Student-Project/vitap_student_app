import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:vit_ap_student_app/core/network/http_interceptor.dart';
import 'package:vit_ap_student_app/core/services/notification_service.dart';
import 'package:vit_ap_student_app/core/services/secure_store_service.dart';
import 'package:vit_ap_student_app/firebase_options.dart';
import 'package:vit_ap_student_app/objbox.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';
import 'package:timezone/data/latest.dart' as tzlt;
import 'package:timezone/timezone.dart' as tz;

part 'init_dependencies.main.dart';
