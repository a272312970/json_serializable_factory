# json_serializable_factory
###  Json解析工厂工具,此工具分成两部分功能：
#### 1.@JsonInit 此注解标注在一个类上会生成一个xx.init.dart文件，里面会有一个static init的方法，在合适的时候（应用初始化）调用一下此init方法
####  2.@JsonModel 此注解标注在一个类上会生成一个xx.model.g.dart,内部需要提供一个static fromJson（Map）的静态方法，该处可以配合json_serializable库使用
#### 3.运行 flutter packages pub run build_runner build 之后json_serializable和此库会先后运行，之后jsonSerializationMap中已经保存了该类的fromJson方法了，之后的网络框架库可以传入泛型进去，然后拿jsonSerializationMap[T.toString()]拿出解析方法解析到特定的对象


