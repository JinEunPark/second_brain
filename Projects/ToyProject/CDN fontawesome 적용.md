---
tags:
  - "#Frontend"
  - "#vue"
  - "#toyProject"
last updated: 2023-12-07
due date: 2023-12-07
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> [어썸 폰트 적용하기](https://fontawesome.com/ )
> 


### background Information

사이드바를 만드는데 일부 필요한 아이콘이 있었서 CDN 으로 적용하게 되었습니다.

### Study
[vue 적용법](https://fontawesome.com/docs/web/use-with/vue/)
위의 Task 에 존재하는 링크로 들어간후 
vue 설정에서 시키는대로 한다 이후에 약간의 팁으로 
~~~
/* import specific icons */

import { createApp } from "vue";

import App from "./App.vue";

import router from "./router/router.js";

import BootstrapVue3 from "bootstrap-vue-3";

import "bootstrap/dist/css/bootstrap.css";

import "bootstrap-vue-3/dist/bootstrap-vue-3.css";

  

/* import the fontawesome core */

import { library } from "@fortawesome/fontawesome-svg-core";

  

/* import font awesome icon component */

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

  

/* import specific icons */

import { faUserSecret } from "@fortawesome/free-solid-svg-icons";

import { fas } from "@fortawesome/free-solid-svg-icons";

import { far } from "@fortawesome/free-regular-svg-icons";

import { fab } from "@fortawesome/free-brands-svg-icons";

  

/* add icons to the library */

library.add(faUserSecret, fas, far, fab);

  

const app = createApp(App);

app.use(BootstrapVue3);

app.use(router);

app.component("font-awesome-icon", FontAwesomeIcon);

  

app.mount("#app");

~~~
 위의 코드를 복붙한다면 하나의 아이콘 하나를 import 해야하는 번거로움을 없엘수 있다
 main.js 에 할것
### Trouble

- 정의한 컴포넌트가 app 에 보이지 않음...



### shooting
~~~
<template>
    <div id="app">
        <SideBar></SideBar>
        <router-view></router-view>
    </div>
</template>

<script>
import SideBar from "./layouts/SideBar.vue";

export default {
    components: {
        SideBar,
    },
};
</script>

<style scoped></style>
~~~

components 는 객체이다.. 나는 배열로 작성함... 제발 진은아
