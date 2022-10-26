import 'package:json_annotation/json_annotation.dart';

/// 啥玩意

// user.g.dart 将在我们运行生成命令后自动生成
/// 一次性生成：在根目录下执行： flutter packages pub run build_runner build
/// 我们可以通过flutter packages pub run build_runner watch在项目根目录下运行来启动_watcher_。
/// 只需启动一次观察器，然后它就会在后台运行，这是安全的
part 'user.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserBean {
  UserBean(this.name, this.email);

  String name;
  String email;

  //不同的类使用不同的mixin即可
  factory UserBean.fromJson(Map<String, dynamic> json) =>
      _$UserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}
