import 'dart:typed_data';

// Stub implementation for non-web platforms. The conditional import will
// replace this with the actual web implementation when running on web.

Future<void> downloadBytes(Uint8List bytes, String filename) async {
  // No-op on non-web platforms. Use platform-specific file saving instead.
  return;
}
