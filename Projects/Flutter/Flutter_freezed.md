---
tags:
  - flutter
  - freezed
last updated: 2024-09-29
due date: 2024-09-29
Project: 
aliases:
---

### tasks

> [! Todo] Title
> Flutter 의 freezed 사용하는 이유
>

### background Information

- freezed 를 사용하는 이유 기존에 데이터 클래스를 생성할 때  freezed 를 사용하지 않으면 객체 비교, 직렬화 방법, 역직렬화 방법등 작성해야하는 잔코드들이 다수 있음
- 하지만 이를 코드 제너레이션을 통해서 쉽게 작성하기 위해서 사용하는 것이 freezed 패키지임

### Study

**설치하기**
```dart
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed

# if using freezed to generate fromJons/toJson, also add:

flutter pub add json_annotation
flutter pub add dev:json_serialization
```

**사용법 간단 정리**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';  
import 'package:flutter/foundation.dart';  
  
part 'home_model.g.dart';  
  
part 'home_model.freezed.dart';
```

- 위 패키지 들을 임포트할 것 
-  ```part 'home_model.g.dart'```  해당 파일에는 FromJson , ToJson 함수가 구현되어서 저장됨 
- ```part 'home_model.freezed.dart' ``` 해당 파일에는 toString, operator override 가 저장됨 


**예시 model 생성 예시**
```dart
  
@freezed  
class HomeModel with _$HomeModel {  
  @JsonSerializable(fieldRename: FieldRename.snake)  
  const factory HomeModel({  
    String? status,  
    int? totalCount,  
    @Default([]) List<HomeItemModel> projects,  
  }) = _HomeModel;  
  
  factory HomeModel.fromJson(Map<String, dynamic> json) =>  
      _$HomeModelFromJson(json);  
}
```

- @freezed  해당 클래스를 freezed code generation 을 사용한다는 에노테이션
-   @JsonSerializable(fieldRename: FieldRename.snake)   필드 이름을  snake case 로 전환한다는 에노테이션 api 에 맞춰서 변경하면됨
	- 단일 필드를 적용하고 싶을때는 @JsonProperty 을 이용해서 정해주시면됩니다.
- @Default([]) List<HomeItemModel> projects,   해당 Default annotation 을 이용하면 리스트의 초기 값을 정해주기 때문에 이를 활용할 수 있습니다.

**구체적인 설명**

사실 더 구체적으로 코드를 까보면 알게되겠지만  FromJson , ToJson 의 선언 부는 freezed 파일에 있고 해당 함수의 구현이 g 파일에 위치하는 것입니다. 




### Trouble

- 장점은 코드 중복이 줄어든다는 것이다. 단점은 만약에 객체간의 비교를 모든 필드의 값을 점증하지 않고 이용해야한다면? 이 때 생성되는 boool operation 을 재정의 하면서 일부 코드의 설계가 깨지는 현상이 있습니다.



### shooting

