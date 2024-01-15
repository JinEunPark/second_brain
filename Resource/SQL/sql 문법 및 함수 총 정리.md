
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