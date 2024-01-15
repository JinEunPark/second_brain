
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



### limit 절

`SELECT` 명령에서 **결과값으로 반환되는 행을 제한**할 수 있었다.

이번에는 `LIMIT` 구로 **행의 갯수를 제한**하는 방법에 대해 알아보자. 이 방법은 많은 데이터를 페이지로 나눠서 보여주는 방법에서 사용된다.

1SELECT 열 명 FROM 테이블 명 LIMIT 행수 [OFFSET 시작행]

들어가기에 앞서, `LIMIT` 구는 **표준 SQL이 아니다.**

**MySQL**과 **PostgreSQL**에서 사용할 수 있는 문법이라는 점에 유의하자.

## 2. 오프셋 지정

시작할 때 말했듯이 대량의 데이터를 한 번에 불러와서 화면에 표시하는 것은 **기능적이나 속도 측면에서도 효율적이지 못하다.**

일반적으로 **페이지 나누기(_Pagination_)** 기능을 사용하는데 이때 `LIMIT`와 `OFFSET`을 사용하여 처리할 수 있다.

예를 들어 한 페이지당 5개의 데이터를 표시하도록 하려면 첫 페이지는 `LIMIT 5`로 결괏값을 표시하면 된다.

그리고 그 다음 페이지는 **6번째 행부터 5건의 데이터를 표시**하면 된다.

이때 몇 번째 행부터 데이터를 취득할 것인지를 가리키는 방법이 `OFFSET`이다.

1SELECT * FROM sample33 LIMIT 3 OFFSET 0;