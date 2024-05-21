---
tags: 
last updated: 
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> Contents

### background Information

### 인덱스의 개념

- INDEX
    
    - 인덱스(index)란?
        - 인덱스는 색인과 목차처럼 데이터 검색 속도를 향상시키는데 사용
        - 책의 목차에서 원하는 주제를 찾아 해당 페이지로 바로 이동하는 것처럼 DB는 해당 인덱스를 활용하여 테이블의 전체 레코드를 스캔하지 않고도 필요한 데이터를 빠르게 찾음
    - 기본적으로 DB는 데이터를 검색할 때 테이블 전체를 탐색해야 하나, 인덱스를 사용하면 테이블의 특정 컬럼 값과 그 레코드의 위치 정보를 보유하고 있어, 테이블 전체를 읽지 않아도 돼 성능 향상
    - 일반적으로 인덱스는 B-tree의 자료구조를 가지고, 이는 이진 트리를 확장한 형태로, 한 노드가 두 개 이상의 자식을 가질 수 있는 자료구조
        - 이진트리는 최대 2개의 자식 노드를 가지는 구조로. 모두 2개의 자식노드만을 가진 이진트리를 완전이진트리라 부른다.
    - 결론은, 테이블의 특정 컬럼의 INDEX 정보를 만들어 검색의 속도를 높이기 위해서 사용
    - 예시)특정컬럼에 index가 없이 테이블 전체를 읽어야 하는 case id=897 번째의 데이터를 조회하기 위해서는 897번의 check가 필요
    
   ![[Pasted image 20240518172013.png]]
    
    - 예시)id 컬럼에 대해 index가 만들어져 있어, 성능이 향상되는 case
        
       ![[Pasted image 20240518172028.png]]
        
        - root페이지는 100개당 1개씩 branch를 갖는 구조
        - branch는 10개당 1개씩 leaf를 갖는 구조
    - id=897 번째의 데이터를 조회한다면 root에서8번, 그 다음 branch에서 9번, 그 다음 leaf에서 7번, 24번만에 검색완료
        
    - 특정 테이블에 생성된 index 조회
        
        - show index from 테이블명;
    - 인덱스 생성 방법
        
        - pk, fk, unique 제약조건 추가시에 해당컬럼에 대해 index 자동생성
        - 단일 컬럼 index : CREATE INDEX index_name ON 테이블명(컬럼명);
        - 복합(다중 컬럼) 인덱스 생성 : CREATE INDEX index_name ON 테이블명(컬럼1, 컬럼2);
    - 인덱스의 사용
        
        - 인덱스 정보를 활용하여 검색이 되려면, 조회 where 조건에 index 컬럼을 조건으로 걸어줘야 index페이지를 활용하여 검색이 이루어짐
        - select * from author where id = 1;
        - select * from author where id = 1 and name = ‘abc’;
            - 이경우, name에 index가 없다면 id인덱스 페이지를 참조
            - name에도 별도로 Index가 있다면, MariaDB엔진에서 최적의 알고리즘 실행
            - id, name에 동시에 index가 걸려있다면 해당 index 참조하여 검색

### Study

```sql
create database board2;  
use board2;  
#index 생성문  
#create index 인덱스명 on 테이블(컬럼명);  
  
#index 조회  
# show index fronm 테이블명  
  
# index 삭제문  
# alter table 테이블명 drop index 인덱스명
create table author(  
id bigint(20) not null auto_increment,  
email varchar(225) default null,  
primary key (id)  
);  
  
  
  
DELIMITER //  
CREATE PROCEDURE insert_authors()  
BEGIN  
DECLARE i INT DEFAULT 1;  
DECLARE email VARCHAR(100);  
DECLARE batch_size INT DEFAULT 10000; -- 한 번에 삽입할 행 수  
DECLARE max_iterations INT DEFAULT 100; -- 총 반복 횟수 (100000000 / batch_size)DECLARE iteration INT DEFAULT 1;  
WHILE iteration <= max_iterations DO  
START TRANSACTION;  
WHILE i <= iteration * batch_size DO  
SET email = CONCAT('seonguk', i, '@naver.com');  
INSERT INTO author (email) VALUES (email);  
SET i = i + 1;  
END WHILE;  
COMMIT;  
SET iteration = iteration + 1;  
DO SLEEP(0.1); -- 각 트랜잭션 후 0.1초 지연  
END WHILE;  
END //  
DELIMITER ;  
  
call insert_authors();  
  
  
select * from author where id = 1000000;

```


인덱스가 없는 테이블을 생성하고 프로스저를 이용해서 약 100만건의 데이터를 삽입했다.

이후 where 절의 실행과 동작 시간.

![[스크린샷 2024-05-21 오후 4.48.32.png]]

314ms 정도 수행되었다.


### Trouble





### shooting
