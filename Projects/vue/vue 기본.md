# Options API

- 옵션 API를 사용하여 옵션의 data, method 및 mounted 같은 객체를 사용하여 컴포넌트의 로직을 정의한다.
    
- 옵션으로 정의된 속성은 인스턴스를 가리키는 함수 내부의 this에 노출이 된다.
    
    ```jsx
    <script>
    export default {
      // data()에서 반환된 속성들은 반응적인 상태가 되어 `this`에 노출됩니다.
      data() {
        return {
          count: 0
        }
      },
    
      // methods는 속성 값을 변경하고 업데이트 할 수 있는 함수.
      // 템플릿 내에서 이벤트 리스너로 바인딩 될 수 있음.
      methods: {
        increment() {
          this.count++
        }
      },
    
      // 생명주기 훅(Lifecycle hooks)은 컴포넌트 생명주기의 여러 단계에서 호출됩니다.
      // 이 함수는 컴포넌트가 마운트 된 후 호출됩니다.
      mounted() {
        console.log(`숫자 세기의 초기값은 ${ this.count } 입니다.`)
      }
    }
    </script>
    
    <template>
      <button @click="increment">숫자 세기: {{ count }}</button>
    </template>
    ```




# Composition API

- Composition API를 사용하는 경우, import해서 가져온 API 함수들을 사용하여 컴포넌트의 로직을 정의한다.
    
- SFC에서 Composition API는 일반족으로`<script setup>`과 함께 사용된다.
    
- setup 속성은 Vue가 더 적은 코드 문맥으로 Composition API를 사용하고, 컴파일 시 의도한대로 올바르게 동작할 수 있게 코드를 변환하도록 하는 힌트이다.
    
- `<script setup>`에 import 되어 가져온 객체들과 선언된 최상위 변수 및 함수는 템플릿에서 직접 사용할 수 있다.
    
    ```jsx
    <script setup>
    import { ref, onMounted } from 'vue'
    
    // 반응적인 상태의 속성
    const count = ref(0)
    
    // 속성 값을 변경하고 업데이트 할 수 있는 함수.
    function increment() {
      count.value++
    }
    
    // 생명 주기 훅
    onMounted(() => {
      console.log(`숫자 세기의 초기값은 ${ count.value } 입니다.`)
    })
    </script>
    
    <template>
      <button @click="increment">숫자 세기: {{ count }}</button>
    </template>
    ```


---
### 컴포지션 함수 set up

- view 내부 속성 정의 및 구현 setup() 함수 사용하면 객체 형태로 반환
---
