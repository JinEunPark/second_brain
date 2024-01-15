
### if(조건문, 참일때 적용값, 거짓일 때 적용값)

```sql
select 
	warehouse_id, 
	warehouse_name, 
	address, 
	if(isnull(freezer_yn) = true, "N", freezer_yn) as freezer_yn
```


### 사용자 정의 변수

```sql
SET @변수이름 = 대입값; 
-- or 
SET @변수이름 := 대입값;


SELECT @변수이름 := 대입값;
```

동호가 := 이다

```sql
SET @start = 15, @finish = 20;

-- 또는

SELECT @start := 15, @finish := 20;

SELECT * FROM employee WHERE id BETWEEN @start AND @finish;
```


### **지역변수 선언 및 초기화**

sql

```
DELIMITER $$
  CREATE PROCEDURE testPro(var1 INT)
  BEGIN
    DECLARE start INT DEFAULT 1; -- int start = 1 과 같다.
    DECLARE finish INT DEFAULT 10;

    SELECT var1, start, finish;
    SELECT * FROM employees WHERE id BETWEEN start AND fisnish;
  END $$
DELIMITER ;

CALL testPro(1);
```

DECLARE 로 먼저 선언 후에 사용하며, 지역변수로 사용하거나 스토어 프로시저(저장 프로시저)의 매개변수로 사용될 수 있다.

또한 **변수의 범위**는 변수가 선언되는 곳의 **BEGIN ~ END 블록**으로 제한된다.

출처: [https://inpa.tistory.com/entry/MYSQL-📚-변수](https://inpa.tistory.com/entry/MYSQL-%F0%9F%93%9A-%EB%B3%80%EC%88%98) [Inpa Dev 👨‍💻:티스토리]



## limit 절

`SELECT` 명령에서 **결과값으로 반환되는 행을 제한**할 수 있었다.

이번에는 `LIMIT` 구로 **행의 갯수를 제한**하는 방법에 대해 알아보자. 이 방법은 많은 데이터를 페이지로 나눠서 보여주는 방법에서 사용된다.

1SELECT 열 명 FROM 테이블 명 LIMIT 행수 [OFFSET 시작행]

들어가기에 앞서, `LIMIT` 구는 **표준 SQL이 아니다.**

**MySQL**과 **PostgreSQL**에서 사용할 수 있는 문법이라는 점에 유의하자.

### 2. 오프셋 지정

시작할 때 말했듯이 대량의 데이터를 한 번에 불러와서 화면에 표시하는 것은 **기능적이나 속도 측면에서도 효율적이지 못하다.**

일반적으로 **페이지 나누기(_Pagination_)** 기능을 사용하는데 이때 `LIMIT`와 `OFFSET`을 사용하여 처리할 수 있다.

예를 들어 한 페이지당 5개의 데이터를 표시하도록 하려면 첫 페이지는 `LIMIT 5`로 결괏값을 표시하면 된다.

그리고 그 다음 페이지는 **6번째 행부터 5건의 데이터를 표시**하면 된다.

이때 몇 번째 행부터 데이터를 취득할 것인지를 가리키는 방법이 `OFFSET`이다.

```
1SELECT * FROM sample33 LIMIT 3 OFFSET 0;
```



### 윈도우 함수

**over( partition by 컬럼  order by 컬럼)**
간단하게 설명하면 어떻게 나눌 것인지 나눈것을 어떤 순서로 적용할 것인지 

~~~sql
함수(컬럼) OVER (Partition by 컬럼 Order by 컬럼)  
  
함수 : Min, Max, Sum, Count, Rank 등과 같은 기존의 함수 or 윈도우 함수용으로 추가된 함수 (Row_number 등)  
OVER : over 은 윈도우 함수에서 꼭 들어가야 하며 Over 내부에 Partition By 절과 Order by 절이 들어갑니다.  
partition by : 전체 집합을 어떤 기준(컬럼)에 따라 나눌지를 결정하는 부분.  
order by : 어떤 항목(컬럼)을 기준으로 순위를 정할 지 결정하는 부분
~~~


```sql
MAX(COUNT(member_id)) OVER () AS max_review_count 
```


위의 예시에서는 over 에는 빈 값이 들어가는데 빈값을 파라미터로 사용할 경우에는 전체 쿼리 집합이 대상이 된다. 따라서 위의 쿼리에서는


인데 전체 그룹별 최댓값을 구해서 컬럼으로 추가하는 코드가 된다.