https://getcssscan.com/css-box-shadow-examples

~~~
.flavor-tag {

display: inline-flex; /* 변경: inline-block에서 inline-flex로 변경 */

margin-right: 1rem;

height: 1rem;

background: #f3f0ff;

color: #5f3dc4;

font-size: 0.7rem;

border-radius: 5px;

padding: 0.7rem;

text-align: center;

align-items: center; /* 추가: 세로 중앙 정렬을 위해 align-items를 추가 */

}
~~~
  
이 코드는 CSS를 사용하여 `.flavor-tag` 클래스를 스타일링하는 것입니다. `.flavor-tag` 클래스는 특정 스타일이 적용된 HTML 요소를 나타냅니다. 아래는 코드의 각 부분에 대한 설명입니다:

1. **`display: inline-flex;`**:
    
    - **원리:** 요소를 인라인 플렉스 컨테이너로 만듭니다.
    - **설명:** `inline-flex` 속성은 요소를 텍스트 흐름에 놓이게 하면서 해당 요소를 플렉스 컨테이너로 만듭니다. 이는 플렉스 박스 속성을 사용하여 요소를 수평으로 배치하고 내부 아이템을 유연하게 정렬할 수 있게 해줍니다.
2. **`margin-right: 1rem;`**:
    
    - **원리:** 오른쪽 여백을 1렘으로 설정합니다.
    - **설명:** 오른쪽 여백은 다른 요소로부터 현재 요소를 얼마나 떨어뜨릴지를 나타냅니다.
3. **`height: 1rem;`**:
    
    - **원리:** 요소의 높이를 1렘으로 설정합니다.
    - **설명:** `.flavor-tag` 요소의 세로 크기를 지정합니다.
4. **`background: #f3f0ff;`**:
    
    - **원리:** 배경 색상을 `#f3f0ff`로 설정합니다.
    - **설명:** `.flavor-tag` 요소의 배경 색상을 설정합니다.
5. **`color: #5f3dc4;`**:
    
    - **원리:** 텍스트 색상을 `#5f3dc4`로 설정합니다.
    - **설명:** `.flavor-tag` 요소의 텍스트 색상을 설정합니다.
6. **`font-size: 0.7rem;`**:
    
    - **원리:** 글꼴 크기를 0.7렘으로 설정합니다.
    - **설명:** `.flavor-tag` 요소의 글꼴 크기를 지정합니다.
7. **`border-radius: 5px;`**:
    
    - **원리:** 테두리의 모서리를 5픽셀로 둥글게 만듭니다.
    - **설명:** `.flavor-tag` 요소의 테두리의 모서리를 둥글게 설정합니다.
8. **`padding: 0.7rem;`**:
    
    - **원리:** 내부 여백을 0.7렘으로 설정합니다.
    - **설명:** `.flavor-tag` 요소의 내부 여백을 지정합니다.
9. **`text-align: center;`**:
    
    - **원리:** 텍스트를 가운데 정렬합니다.
    - **설명:** `.flavor-tag` 요소 내의 텍스트를 수평으로 가운데 정렬합니다.
10. **`align-items: center;`**:
    
    - **원리:** 플렉스 컨테이너 내부의 아이템을 수직으로 가운데 정렬합니다.
    - **설명:** `.flavor-tag` 요소가 플렉스 컨테이너로 지정되었기 때문에, 이 속성은 내부 아이템을 수직으로 가운데 정렬합니다.