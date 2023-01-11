import 'package:hive/hive.dart';

import '../modals/note_modal.dart';

class Boxes{
  static Box<NotaModal> getData() => Hive.box<NotaModal>('notes');
}