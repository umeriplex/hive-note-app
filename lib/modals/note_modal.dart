
import 'package:hive/hive.dart';
part 'note_modal.g.dart';

@HiveType(typeId: 0)
class NotaModal {

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  NotaModal({
    required this.title,
    required this.description
});
}
