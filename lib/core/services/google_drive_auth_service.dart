import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

class GoogleDriveBackupService {
  static const _scopes = [
    'email',
    drive.DriveApi.driveFileScope,
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: _scopes,
  );

  Future<void> uploadBackup(File file) async {
    print('STEP A: Starting Google sign-in...');

    final account = await _googleSignIn.signIn();

    if (account == null) {
      print('STEP B: User cancelled sign-in');
      throw Exception('Google sign-in cancelled');
    }

    print('STEP B: Signed in as ${account.email}');

    final headers = await account.authHeaders;
    print('STEP C: Got auth headers');

    final client = GoogleAuthClient(headers);
    final driveApi = drive.DriveApi(client);

    final driveFile = drive.File()
      ..name = file.uri.pathSegments.last;

    print('STEP D: Preparing file upload: ${driveFile.name}');

    final media = drive.Media(
      file.openRead(),
      await file.length(),
    );

    final uploadedFile = await driveApi.files.create(
      driveFile,
      uploadMedia: media,
    );

    print('STEP E: Upload complete!');
    print('Google Drive File ID: ${uploadedFile.id}');
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}