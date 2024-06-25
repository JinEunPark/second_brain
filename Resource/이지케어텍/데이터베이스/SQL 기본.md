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
	- show 명령어로 확인₩
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
	- concat('answkduf', 'haegyo') 문자열 붙이기 

- 숫자함수 
	- https://ittrue.tistory.com/362
- 일반함수
	- **1)** nvl : null 값을 실제값으로 대체하는 함수 / nvl( , )안의 값은 둘이 형이 맞아야함
	
	- **2) nvl2 : null값을 실제값으로 대체하는 함수**
              **nvl2(기준값, null이 아니면 2번째 수행할 연산,  기준값이 null이면 수행할 연산)**
	```sql
	select 
		salary, 
		nvl2(commission_pct, 
		salary * 12 + commission_pct, 
		salary * 12)

	from employees;
	```

	-   **3) coalesce : null값이 안나오도록 계속 수행/ null이 나오면 다음 인수를 계산 /**
	
```sql 
select 
	coalesce(salary*12 + commission_pct, 
	salary*12, salary)
from employees;
```

**4) nullif : 두개의 인수값이 동일하면 null/ 동일하지 않으면 첫번째 인수값을 보여줌**

```sql
select 
	last_name, 
	first_name, 
	nullif(length(last_name), 
	length(first_name)) nullif
from employees;
```

  **5) decode : 첫번째 인수 기준값 / 두번째 인수 비교값 / 세번째 인수 참값**

```sql
select 
	employee_id, 
	job_id, 
	salary, 
	decode(job_id, 'IT_PROG', salary*1.1)
from employees;
```



