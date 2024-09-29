-- insert into : 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2,데이터3);
--id, name, email -> author 1건 추가
insert into author(id, name, email) values(1,'hongildong','hongildong@naver.com');
-- select : 데이터 조회 ( * : 모든 컬럼 조회)
select * from author;

--posts테이블에 id, title, content, author_id -> posts에 1건 추가
insert into posts(id,title,content,author_id) values(1,"제목1","내용1",1);
select * from posts;

-- 테이블 제약조건 조회 (information_schema:시스템 전체 스키마의 설정)
select * from information_schema.key_column_usage where table_name = 'posts';

-- insert문을 통해 author 데이터 4개정도 추가, post 데이터5개정도 추가(1개정도는 익명)
insert into post(id,title,contents) values(2,"제목2","내용3");
insert into post(id,title,contents,author_id) values(5,"제목5","내용5",3);
insert into post(id,title,contents,author_id) values(3,"제목3","내용3",1);
insert into post(id,title,contents,author_id) values(4,"제목4","내용4",2);

-- update 테이블명 set 컬럼명1=데이터1, 컬럼명2=데이터2 where id = 1;
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set name='abc',email='abc@test.com' where id=1;
update author set email='abc@naver2.com' where id=2;

-- delete from 테이블명 where 조건
-- where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의
delete from author where id=4;

-- SELECT의 다양한 조회 방법
select * from author;
select * from author where id=1;
select * from author where id>2;
select * from author where id>2 and name='test3';

-- uuid
alter table post add column user_id char(36) DEFAULT (UUID());

--unique 제약조건
alter table author modify column email varchar(255) unique;


-- 특정 컬럼만을 조회할 때
select name, email from author where id=3;

-- 중복 제거하고 조회
select distinct title from post;
(select title from post 하면 중복 제거 안 됨)

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬 조건 없이 조회할 경우에는 PK기준으로 오름차순 정렬
-- asc:오름차순, desc:내림차순
select * from author order by name desc;

-- 멀티 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬. 중복시, 그다음 정렬 옵션 적용 ((진짜 중요!!!))
select * from post order by title; --asc/desc 생략 시 오름차순!!!!이거 중요해!!!!!
select * from post order by title, id desc; --만약에 타이틀이 중복이면 id 기준으로 내림차순

-- limit number : 특정 숫자로 결과값 개수 제한, limit는 실용적으로 중요!!!
select * from author order by id desc limit 1; -- 가장 최근에 가입한 1명 조회

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name, a.email from author as a;

-- null을 조회 조건으로(기억해~~~~)
select * from post where author_id is null;
select * from post where author_id is not null;

--실습 믄제 : https://school.programmers.co.kr/learn/courses/30/lessons/59404
--실습 문제 : https://school.programmers.co.kr/learn/courses/30/lessons/59405
