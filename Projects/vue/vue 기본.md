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

### 컴포넌트 생명주기

## onMounted()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onmounted)

컴포넌트가 마운트된 후 호출될 콜백을 등록합니다.

- **타입**:
    
    
    ```js
    function onMounted(callback: () => void): void
    ```
    
- **세부 사항**:
    
    컴포넌트가 마운트 되었다고 간주하는 조건은 다음과 같습니다:
    
    - 동기식 자식 컴포넌트가 모두 마운트됨(`<Suspense>` 트리 내부의 비동기 컴포넌트 또는 컴포넌트는 포함하지 않음).
        
    - 자체 DOM 트리가 생성되어 상위 컨테이너에 삽입됨. 앱의 루트 컨테이너가 Document 내에 있는 경우에만 컴포넌트의 DOM 트리가 문서 내에 있음을 보장함.
        
    
    일반적으로 이 훅은 컴포넌트의 렌더링된 DOM에 접근해야 하는 사이드 이펙트를 실행하거나, [서버에서 렌더링 된 앱](https://ko.vuejs.org/guide/scaling-up/ssr.html)에서 DOM과 관련 코드를 클라이언트에서만 실행하도록 제한하는 데 사용됩니다.
    
    **이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.
    
- **예제**
    
    템플릿 ref를 통해 엘리먼트에 접근:
    
    
    ```js
    <script setup>
    import { ref, onMounted } from 'vue'
    
    const el = ref()
    
    onMounted(() => {
      el.value // <div>
    })
    </script>
    
    <template>
      <div ref="el"></div>
    </template>
    ```
    

## onUpdated()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onupdated)

반응형 상태 변경으로 컴포넌트의 DOM 트리가 업데이트된 후 호출될 콜백을 등록합니다.

- **타입**:
    
    ts
    
    ```
    function onUpdated(callback: () => void): void
    ```
    
- **세부 사항**:
    
    부모 컴포넌트의 updated 훅은 자식 컴포넌트의 훅 이후에 호출됩니다.
    
    이 훅은 컴포넌트의 DOM 업데이트 후에 호출됩니다. 이는 다양한 상태 변경으로 인해 발생할 수 있습니다. 여러 상태 변경은 성능상의 이유로 단일 렌더 주기로 묶일 수 있습니다. 특정 상태 변경 이후에 업데이트된 DOM에 접근해야 한다면, 대신에 [nextTick()](https://ko.vuejs.org/api/general.html#nexttick)을 사용하세요.
    
    **이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.
    
    주의
    
    updated 훅에서 컴포넌트 상태를 변경하면 안되는데, 무한 업데이트 루프가 발생할 수 있기 때문입니다!
    
- **예제**
    
    업데이트된 DOM에 접근:
    
    ```js
    <script setup>
    import { ref, onUpdated } from 'vue'
    
    const count = ref(0)
    
    onUpdated(() => {
      // 텍스트 내용은 현재 `count.value`와 같아야 함
      console.log(document.getElementById('count').textContent)
    })
    </script>
    
    <template>
      <button id="count" @click="count++">{{ count }}</button>
    </template>
    ```
    

## onUnmounted()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onunmounted)

컴포넌트가 마운트 해제된 후 호출될 콜백을 등록합니다.

- **타입**:
    
    
    ```js
    function onUnmounted(callback: () => void): void
    ```
    
- **세부 사항**:
    
    컴포넌트가 마운트 해제되었다고 간주하는 조건은 다음과 같습니다:
    
    - 모든 자식 컴포넌트가 마운트 해제됨.
        
    - 관련된 모든 반응형 이펙트(`setup()`에서 생성된 렌더 이펙트, 계산된 속성, 감시자)가 중지됨.
        
    
    이 훅을 사용하여 타이머, DOM 이벤트 리스너 또는 서버 연결처럼 수동으로 생성된 사이드 이펙트를 정리합니다.
    
    **이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.
    
- **예제**
    
    
    ```js
    <script setup>
    import { onMounted, onUnmounted } from 'vue'
    
    let intervalId
    onMounted(() => {
      intervalId = setInterval(() => {
        // ...
      })
    })
    
    onUnmounted(() => clearInterval(intervalId))
    </script>
    ```
    

## onBeforeMount()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onbeforemount)

컴포넌트가 마운트되기 직전에 호출될 훅을 등록합니다.

- **타입**:
    
    
    ```js
    function onBeforeMount(callback: () => void): void
    ```
    
- **세부 사항**:
    
    이 훅은 컴포넌트의 반응형 상태 설정이 완료된 후 호출되지만, 아직 DOM 노드가 생성되지 않은 단계입니다. 첫 DOM 렌더 이펙트를 실행하려고 합니다.
    
    **이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.
    

## onBeforeUpdate()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onbeforeupdate)

반응형 상태 변경으로 컴포넌트의 DOM 트리를 업데이트하기 직전에 호출될 콜백을 등록합니다.

- **타입**:
    
    ts
    
    ```js
    function onBeforeUpdate(callback: () => void): void
    ```
    
- **세부 사항**:
    
    이 훅은 Vue가 DOM을 업데이트하기 전에 DOM 상태에 접근하는 데 사용할 수 있습니다. 이 훅 내부에서 컴포넌트 상태를 수정하는 것도 안전합니다.
    
    **이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.
    

## onBeforeUnmount()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onbeforeunmount)

컴포넌트 인스턴스가 마운트 해제되기 직전에 호출될 콜백을 등록합니다.

- **타입**:
    
    ts
    
    ```js
    function onBeforeUnmount(callback: () => void): void
    ```
    
- **세부 사항**:
    
    이 훅이 호출될 때, 여전히 컴포넌트 인스턴스는 완전히 동작하는 상태입니다.
    
    **이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.
    

## onErrorCaptured()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onerrorcaptured)

자식 컴포넌트에서 전파된 에러가 캡쳐되었을 때 호출될 콜백을 등록합니다.

- **타입**:
    
    ts
    
    ```js
    function onErrorCaptured(callback: ErrorCapturedHook): void
    
    type ErrorCapturedHook = (
      err: unknown,
      instance: ComponentPublicInstance | null,
      info: string
    ) => boolean | void
    ```
    
- **세부 사항**:
    
    다음과 같은 출처의 에러를 캡처할 수 있습니다:
    
    - 컴포넌트 렌더
    - 이벤트 핸들러
    - 생명주기 훅
    - `setup()` 함수
    - 감시자
    - 커스텀 디렉티브 훅
    - 트랜지션 훅
    
    훅은 '에러', '에러를 트리거한 컴포넌트 인스턴스', '에러 소스 유형을 지정하는 정보 문자열' 세 개의 인자를 받습니다.
    
    TIP
    
    프로덕션에서는 3번째 인수(`info`)가 전체 정보 문자열 대신 축약된 코드로 제공됩니다. 코드와 문자열 매핑은 [프로덕션 오류 코드 참조](https://ko.vuejs.org/error-reference/#runtime-errors)에서 확인할 수 있습니다.
    
    `errorCaptured` 훅에서 컴포넌트 상태를 수정하여 사용자에게 에러 상태를 표시할 수 있습니다. 그러나 에러가 난 컴포넌트에서 에러 상태를 렌더링해서는 안됩니다. 그렇지 않으면 컴포넌트가 무한 렌더링 루프에 빠집니다.
    
    훅은 `false`를 반환하여 에러가 더 이상 전파되지 않도록 할 수 있습니다. 아래의 에러 전파 세부 사항을 참조하십시오.
    
    **에러 전파 규칙**
    
    - 기본적으로 모든 에러는 단계적으로 전파되며, [`app.config.errorHandler`](https://ko.vuejs.org/api/application.html#app-config-errorhandler)가 정의된 경우, 최종적으로 이곳으로 전파되므로 한 곳에서 서비스 분석 및 보고 작업을 할 수 있습니다.
        
    - 컴포넌트의 상속 체인 또는 부모 체인에 여러 개의 `errorCaptured` 후크가 존재하는 경우, 모든 후크는 동일한 오류에 대해 아래에서 위로 순서대로 호출됩니다. 이는 네이티브 DOM 이벤트의 버블링 메커니즘과 유사합니다.
        
    - `errorCaptured` 훅 자체에서 에러가 발생하면, 이 에러와 원래 캡처된 에러가 모두 `app.config.errorHandler`로 전송됩니다.
        
    - `errorCaptured` 훅에서 `false`를 반환하면 더 이상 에러가 전파되지 않습니다. 이것은 본질적으로 "이 에러는 처리되었으므로 무시되어야 합니다."를 의미합니다. 따라서 이후 단계적으로 전파되어야 할 `errorCaptured` 훅 또는 `app.config.errorHandler`에 이 에러로 인한 호출 동작은 없습니다.
        

## onRenderTracked() [​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onrendertracked)

컴포넌트의 렌더 이펙트에 의해 반응형 의존성이 추적됐을 때, 호출될 디버그 콜백을 등록합니다.

**이 훅은 개발 모드 전용이며, 서버 사이드 렌더링 중에 호출되지 않습니다**.

- **타입**:
    
    ts
    
    ```js
    function onRenderTracked(callback: DebuggerHook): void
    
    type DebuggerHook = (e: DebuggerEvent) => void
    
    type DebuggerEvent = {
      effect: ReactiveEffect
      target: object
      type: TrackOpTypes /* 'get' | 'has' | 'iterate' */
      key: any
    }
    ```
    
- **참고**: [반응형 심화](https://ko.vuejs.org/guide/extras/reactivity-in-depth.html)
    

## onRenderTriggered() [​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onrendertriggered)

컴포넌트의 렌더 이펙트가 반응형 의존성에 의해 다시 실행되도록 트리거된 경우, 호출될 디버그 콜백을 등록합니다.

**이 훅은 개발 모드 전용이며, 서버 사이드 렌더링 중에 호출되지 않습니다**.

- **타입**:
    
    ts
    
    ```js
    function onRenderTriggered(callback: DebuggerHook): void
    
    type DebuggerHook = (e: DebuggerEvent) => void
    
    type DebuggerEvent = {
      effect: ReactiveEffect
      target: object
      type: TriggerOpTypes /* 'set' | 'add' | 'delete' | 'clear' */
      key: any
      newValue?: any
      oldValue?: any
      oldTarget?: Map<any, any> | Set<any>
    }
    ```
    
- **참고**: [반응형 심화](https://ko.vuejs.org/guide/extras/reactivity-in-depth.html)
    

## onActivated()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onactivated)

[`<KeepAlive>`](https://ko.vuejs.org/api/built-in-components.html#keepalive)로 캐시된 컴포넌트 인스턴스가 DOM 트리의 일부로 삽입된 후 호출될 콜백을 등록합니다.

**이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.

- **타입**:
    
    ts
    
    ```js
    function onActivated(callback: () => void): void
    ```
    
- **참고**: [가이드 - 캐시된 인스턴스의 생명 주기](https://ko.vuejs.org/guide/built-ins/keep-alive.html#lifecycle-of-cached-instance)
    

## onDeactivated()[​](https://ko.vuejs.org/api/composition-api-lifecycle.html#ondeactivated)

[`<KeepAlive>`](https://ko.vuejs.org/api/built-in-components.html#keepalive)로 캐시된 컴포넌트 인스턴스가 DOM 트리에서 제거된 후 호출될 콜백을 등록합니다.

**이 훅은 서버 사이드 렌더링 중에 호출되지 않습니다**.

- **타입**:
    
    ts
    
    ```
    function onDeactivated(callback: () => void): void
    ```
    
- **참고**: [가이드 - 캐시된 인스턴스의 생명 주기](https://ko.vuejs.org/guide/built-ins/keep-alive.html#lifecycle-of-cached-instance)
    

## onServerPrefetch() [​](https://ko.vuejs.org/api/composition-api-lifecycle.html#onserverprefetch)

컴포넌트 인스턴스가 서버에서 렌더링 되기 전에 완료(resolve)되어야 하는 비동기 함수를 등록합니다.

- **타입**:
    
    ts
    
    ```
    function onServerPrefetch(callback: () => Promise<any>): void
    ```
    
- **세부 사항**:
    
    콜백이 Promise를 반환하면, 서버 렌더러는 컴포넌트를 렌더링하기 전 Promise가 해결될 때까지 기다립니다.
    
    이 훅은 SSR(서버 사이드 렌더링) 중에만 호출되므로, 서버 전용 데이터 가져오기를 실행하는 데 사용할 수 있습니다.
    
- **예제**
    
    vue
    
    ```vue
    <script setup>
    import { ref, onServerPrefetch, onMounted } from 'vue'
    
    const data = ref(null)
    
    onServerPrefetch(async () => {
      // 서버에서 미리 데이터를 가져오는 것은
      // 클라이언트에서 데이터를 요청하는 것보다 빠름.
      // 최초 데이터 요청 결과로 컴포넌트의 일부가 렌더링 됨.
      data.value = await fetchOnServer(/* ... */)
    })
    
    onMounted(async () => {
      if (!data.value) {
        // 마운트 시 데이터가 null일 경우,
        // 컴포넌트가 클라이언트에서 동적으로 렌더링되도록
        // 클라이언트 측에서 가져오기를 실행해야 함.
        data.value = await fetchOnClient(/* ... */)
      }
    })
    </script>
    ```
    
---


## 선언적 렌더링

```js
//mustach syntax
{{data}} 
// v text 디렉티브
<p v-text="msg></p>

// v-html
<div v-html="<p> hi</p>"></div> 해당변수 p 테그 렌더링

//v-pre 
<div v-pre>{{msg}}z</div> -> "{{msg}}" 문자 그대로 출력

```


--- 
## 데이터 결합을 통한 사용자 입력 처리
## ref()[​](https://ko.vuejs.org/api/reactivity-core#ref)

전달된 값을 갖게 되고, 이것을 가리키는 단일 속성 `.value`가 있는 변경 가능한 반응형 ref 객체를 반환합니다.

- **타입**:
    
    ```js
    function ref<T>(value: T): Ref<UnwrapRef<T>>
    
    interface Ref<T> {
      value: T
    }
    ```
    
- **세부 사항**:
    
    ref 객체는 반응형이며, `.value` 속성에 새 값을 할당할 수 있습니다. 즉, `.value`에 대한 모든 읽기 작업이 추적되고, 쓰기 작업은 관련 이펙트를 트리거합니다.
    
    객체가 ref의 값(`.value`)으로 할당되면, [reactive()](https://ko.vuejs.org/api/reactivity-core#reactive)로 내부 깊숙이(deeply) 반응하게 됩니다. 이러한 동작은 객체 내부 깊숙이 ref가 포함되어 있으면, 언래핑됨을 의미합니다.
    
    내부 깊숙이까지 변환되는 것을 방지하려면, [`shallowRef()`](https://ko.vuejs.org/api/reactivity-advanced.html#shallowref)를 사용해야 합니다.
    
- **예제**
    
    ```
    const count = ref(0)
    console.log(count.value) // 0
    
    count.value = 1
    console.log(count.value) // 1
    ```
    

- v-model 은 해당 태그의 value attribute로 자동으로 바인딩된다. 그리고 양방향 바인딩 템플릿에서 객체의 값을 변경하는 것이 가능
- v-bind 는 템플릿에서 객체의 값을 변경하는 것이 불가능.

---
## 이벤트 리스너르 이용한 사용자 입력 처리
- v-on 을 사용해서 이벤트를 맵핑 @{이벤트} 사용가능 
- 이벤트 수식어 
	- stop
	- prevent
	- capture
	- self
	- once
	- passive
	- exact
	- left
	- right
	- middle
---
## 템플릿 내부 조건문 

```js
// v-if 는 조견이 변경될때마다 관련된 모든 컴포넌트를 다시 만드는 반면
<p v-if="counter < 5" ></p>
// v-show 는 일단 만들고 hide 옵션을 이ㅛㅇㅇ해서 숨김
<p v-show="counter <5"></p>

```

---
## 템플릿 내부 반복문

```
v-for="값 in 배열"
v-for"(값, 인덱스) in 배열"
```