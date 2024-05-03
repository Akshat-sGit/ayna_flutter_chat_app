import 'package:hive/hive.dart';
import 'message_model.dart';

class MessageRepository {
  static const String boxName = 'messages';

  Future<Box<MessageModel>> openBox() async {
    if (!Hive.isAdapterRegistered(MessageModelAdapter().typeId)) {
      Hive.registerAdapter(MessageModelAdapter());
    }
    return await Hive.openBox<MessageModel>(boxName);
  }

  Future<void> addMessage(MessageModel message) async {
    final box = await openBox();
    await box.add(message);
  }

  Future<List<MessageModel>> getAllMessages() async {
    final box = await openBox();
    return box.values.toList();
  }
}
