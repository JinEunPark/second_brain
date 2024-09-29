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
-  ```part 'home_model.g.dart'```  dladfrkf'rih'erig'q5jtn'rih

  
### Trouble





### shooting
