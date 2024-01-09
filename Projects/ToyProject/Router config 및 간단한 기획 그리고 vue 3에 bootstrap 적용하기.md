[Bootstrap component](https://bootstrap-vue.org/docs/components/sidebar) 내가 사용할 예정인 bootstrap sidebar component


연동과정

```
npm install vue bootstrap bootstrap-vue-3
```

- VsCode에 해당 명령어를 입력해서 bootstrap을 install 합니다.

### mian.js 

~~~javaScript

import { createApp } from 'vue' 
import App from './App.vue' 
import router from './router' 
import BootstrapVue3 from 'bootstrap-vue-3'; 
import 'bootstrap/dist/css/bootstrap.css' 
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css' 


const app = createApp(App) 
app.use(BootstrapVue3) 
app.use(router) 
app.mount('#app');

~~~



