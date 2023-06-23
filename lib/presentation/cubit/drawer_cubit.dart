import 'package:dependencies/flutter_bloc/flutter_bloc.dart';

class DrawerCubit extends Cubit<int> {
  DrawerCubit() : super(0);

  void setIndex(int index) => emit(index);
}
