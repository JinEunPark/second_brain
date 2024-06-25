#### 연결 연산자

- || 
- 열이나 문자열 연결에 사용
- 문자, 날짜는 반드시 싱글 쿼트로 묶어야함
#### null 값 연산

- 산술연산 불가능
- 비교연산 isNull 가능 
- 논리연산 
	- true and nnull ->  null
	- false and null -> false
	- true or null -> true
	- false or null -> null

#### 치환변수 

- 치환변수 정이 방법
	-  & : 1회성 변수 정의
	- && : 세션동안 유지되는 변수 실행 환경에서 정의
	- DEF[INE] : 세션동안 유지되는 변수 실행 환경에서 정의
	- UNDEF[FINE] : 변수 해제
- 현경변수
	- show 명령어로 확인
	- set 명령어로 변경
	- session 종료

#### 단일 행 함수
- 문자함수 
	- INITCAP() 첫글자 대문자 변환
	```sql
	select job , initcap(job)
	from emp;
	```
	- length() 길이  |  instr(x,'y') 지정된 문자열의 위치 반환 x 라는 문자열에서 y 라는 문자의 위치를 반환 없으면 0을 반환한다.
	- concat('answkduf', 'haegyo') 문자열 붙임

- 숫자함수 
	- round : 반올림
	- trunc : 버림
	- mod :  나머지 값 구하기
	- 

