// @Author cz
// @CreateDate: 2021/3/30 4:16 PM
// @Description:

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder generateJsonParams(BuilderOptions options) =>
    LibraryBuilder(JsonSerializationGenerator(), generatedExtension:'.model.g.dart');

Builder generateJsonFactory(BuilderOptions options)=>
    LibraryBuilder(JsonFactoryGenerator(), generatedExtension: '.init.dart');