--tinyint는 -128~127까지 표현
--author테이블에 age컬럼 추가
alter table author add column age tinyint;
--insert시에 age:200 -> 125
insert into author(id,email,age) values (5,'hello@naver.com',130);
insert into author(id,email,age) values (5,'hello@naver.com',125);
--unsigned시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned; 
insert into author(id,email,age) values(6,'hello@naver.com',200);

--decimal 실습
alter table post add column price decimal(10,3) --총자리 10자리 중 소수부 3자리
describe post;

--decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id,title,price) values (5,'hello java',3.123123);
-- update : price를 1234.1로 업데이트 하기
update post set price=1234.1 where id=5;

-- blob 바이너리데이터 실습
-- author테이블에 profile_image컬럼을 blob형식으로 추가
alter table author add column profile_image longblob;
insert into author(id,email,profile_image) values(9,'ddd@naver.com',LOAD_FILE('C:\\Users\\erp\\cat.jpeg'))

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role컬럼
alter table author add column role enum('admin','user') not null DEFAULT 'user';
-- enum 컬럼 실습
-- user1을 insert => 에러
insert into author(id,email,role) values(14,'test@test.com',user1);
-- user 또는 admin insert => 정상
insert into author(id,email,role) values(14,'test@test.com',user);

-- date 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author(id,email, birth_day) values(17, 'hello@va.cm','1999-04-21');

-- datetime 타입
-- author, post 둘 다 datetime으로 created_time 컬럼 추가
alter table author add column created_time datetime;
insert into author(id,email,created_time) values (18, 'hello11@dd.com','2000-12-01 12:00:00');
alter table post add column created_time datetime;
insert into post(id,title,created_time) values(6,'제목','2024-05-17 12:00:00');
-- 시간 자동으로 들어가게 하기 (not null 안 주면 이전값들은 영향 안 주는데 not null을 넣으면 에러 나옴)
alter table author modify column created_time datetime DEFAULT current_timestamp;
alter table post modify column created_time datetime DEFAULT current_timestamp;

-- 비교연산자
-- and 또는 && 
select * from post where id>=2 and id<=4;
select * from post where id between 2 and 4;
-- or 또는 ||
-- NOT 또는 !
select * from post where !(id<2 OR id>4);
--null인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;
-- in(), not in()  ()안에는 리스트 형태 들어감
select * from post where id in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o' --o로 끝나는 title 검색
select * from post where title like 'h%' --h로 시작하는 title 검색
select * from post where title like '%llo%' --단어의 중간에 llo라는 키워드가 있는 경우 검색
select * from post where title not like '%o' --o로 끝나는 title이 아닌 title 검색

--ifnull(a,b) : 만약에 a가 null이면 b반환, null이 아니면 a반환
select title, contents, ifnull(author_id,'익명') from post;

-- 경기도에 위치한 식품창고 목록 출력하기

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name REGEXP '[a-z]';
select * from author where name REGEXP '[가-힣]';


-- 날짜 변환 : 숫자->날짜, 문자->날짜
-- CAST와 CONVERT
SELECT CAST(20200101 AS DATE);
SELECT CAST('20200101' AS DATE);
SELECT CONVERT(20200101, DATE);
SELECT CONVERT('20200101' ,DATE);

-- datetime 조회방법
select * from author where created_time like '2000-12%';
select * from post where created_time <='2000-12-31' and created_time >='1900-01-01';
select * from post where created_time between '2000-12-31' and '1900-01-01';
-- data format
select date_format(created_time,'%Y-%m') from post;
-- (실습) post를 조회할 때 date_format 활용하여 2024년 데이터 조회, 결과는 *
select * from post where date_format(created_time,'%Y')='2024';
-- 오늘 날짜 
select now();
-- 흉부외과 또는 일반외과 의사 목록 출력하기 제출 내역
SELECT DR_NAME, DR_ID, MCDP_CD, date_format(HIRE_YMD, '%Y-%m-%d') as HIRE_YMD FROM DOCTOR WHERE MCDP_CD in('CS','GS') order by HIRE_YMD desc, DR_NAME; 