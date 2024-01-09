---
tags: 
last updated: 2023-12-07
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> https://console.ncloud.com/naver-service/application

위 주소로 접속해서 application 을 등록한다 필자는 geo coding 과 web dynmic map 을 사용할것이기 때문에 해당 기능을 선택했다.



### background Information
~~~js
mounted() {

// 네이버 지도 API 로드

const script = document.createElement("script");

script.src =

"https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=yrId";

script.async = true;

script.defer = true;

document.head.appendChild(script);

  

script.onload = () => {

// 네이버 지도 생성

new window.naver.maps.Map("map", {

center: new window.naver.maps.LatLng(37.5670135, 126.978374),

zoom: 10,

});

};

},
~~~

개발 가이드에 따라서 map.vue 를 만들고 해당 컴포넌트를 삽입할 때 지도가 삽입되도록 했다.

### Trouble
개발 과정에서 문제가 발생했다 문제는 

~~~html
<template>

<div id="app">

	<SideBar></SideBar>
	
	<side-view></side-view>
	
	<map-view></map-view>
	
	  
	
	<router-view></router-view>

</div>

</template>
~~~

위와 같이 다른 컴포넌트들과 함께 사용하려고 했지만 이상하게 지도가 페이지에 나타나지 않았다.
예상되는 문제점 
생성되는 map div 가 다른 컴포넌트 들의 밑에 존재하는것 같다.
### shooting
메인 뷰에서 Flex display 로 설정한 이후에 뷰가 정상적으로 나타났다.