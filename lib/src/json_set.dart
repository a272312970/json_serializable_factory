// @Author cz
// @CreateDate: 2021/3/30 2:29 PM
// @Description:

typedef JsonSerializationFunc<T> = T Function(Map<String,dynamic> json);

Map<String, JsonSerializationFunc> jsonSerializationMap = <String, JsonSerializationFunc>{};

Map<String, JsonSerializationFunc> jsonSerialization<T>(JsonSerializationFunc<T> func) {
  if (!jsonSerializationMap.containsKey(T.toString())) {
    jsonSerializationMap[T.toString()] = func;
  }
  return jsonSerializationMap;
}
