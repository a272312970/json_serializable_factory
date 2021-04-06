// @Author cz
// @CreateDate: 2021/3/30 2:58 PM
// @Description:

import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'json_args.dart';

class JsonModelCollector {
  List<String> importList = <String>[];
  List<String> classNameList = <String>[];
}

class JsonSerializationGenerator extends GeneratorForAnnotation<JsonModel> {
  static JsonModelCollector collector = JsonModelCollector();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement){
      throw InvalidGenerationSourceError('注解必须使用在类上');
    }
    var importStr = "";
    if (buildStep.inputId.path.contains('lib/')) {
      importStr =
          "package:${buildStep.inputId.package}/${buildStep.inputId.path.replaceFirst('lib/', '')}";
    } else {
      importStr = "${buildStep.inputId.path}";
    }
    String className = element.name;
    if (!collector.importList.contains(importStr)) {
      collector.importList.add(importStr);
    }
    if (!collector.classNameList.contains(className)) {
      collector.classNameList.add(className);
    }
    print(
        'JsonSerializationGenerator:importStr = $importStr,className = $className');

    return null;
  }
}

class JsonFactoryGenerator extends GeneratorForAnnotation<JsonInit> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind == ElementKind.CLASS) {
      String path = buildStep.inputId.path; // lib/xxx.dart
      String relatedFileName = baseName(path); // xxx.dart
      String relatedClassName = element.name ?? 'JsonInit';
      print(
          'JsonFactoryGenerator:collector = ${JsonSerializationGenerator.collector.importList.toString()}');
      print(
          'JsonFactoryGenerator:path = $path,relatedFileName=$relatedFileName,relatedClassName=$relatedClassName');
      return generateJson(relatedFileName, relatedClassName);
    }
    return '----- implement error --------';
  }

  generateJson(String relatedFileName, String relatedClassName) {
    String imports = "";
    String jsonSerialization = "";
    for (String import in JsonSerializationGenerator.collector.importList) {
      imports = imports + "import '" + import + "';\n";
    }
    for (String className
        in JsonSerializationGenerator.collector.classNameList) {
      jsonSerialization = jsonSerialization +
          "jsonSerialization<$className>($className.fromJson);\n";
    }

    return """
import 'package:json_serializable_factory/json_serializable_factory.dart';
$imports

class \$$relatedClassName{    

  static void init() {
    $jsonSerialization
  }  
}

""";
  }
}

String baseName(String path) {
  final split = path.split('/');
  return split[split.length - 1];
}
