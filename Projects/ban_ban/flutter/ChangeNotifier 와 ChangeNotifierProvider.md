---
tags:
  - "#flutter"
last updated: 2024-06-27
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> https://www.youtube.com/watch?v=de6tAJS2ZG0&list=PLQt_pzi-LLfoOpp3b-pnnLXgYpiFEftLB&index=34

### background Information

### changeNotifier 한계점
1. 매번 수동으로 addListener 를 등록해 주어야함
2. 수동으로 addListener 를 제거시켜 주어야 함
3. FishModel 인스턴스를 매번 생성자를 통해서 전달 해야 함
4. UI 리빌드도 수동으로 해결해야함

### ChangeNotifierProvider 
1. 모든 위젯들이 listen 할 수 있는 ChangeNoitifier 인스턴스 생성 
2. 자동으로 필요없는 ChangeNotifier 제거 
3. Provider.of 를 통해서 위젯들이 쉽게 ChangeNotifier 인스턴스에 접근할 수 있게 해줌
4. 필요시 UI 를 리빌드 시켜줄 수 있음
5. 굳이 UI를 리빌드 할 필요가 없는 위젯을 위해서 listen : false 기능 제공


### Study



### Trouble





### shooting
