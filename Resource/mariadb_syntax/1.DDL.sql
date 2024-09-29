-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- (스키마)데이터베이스 생성 (테이블은 소문자로 쓰는 게 정석)
CREATE DATABASE board;

-- 데이터베이스 선택
use board;

-- 테이블 조회
show tables;

-- author 테이블 생성 (int는 범위 지정할 필요 없다. int는 이미 정해져있음) (type 옆에 제약조건 써야함!!!!!) ((PK는 무조건 설정해줘야함))
CREATE table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼조회
describe author;

-- 컬럼 상세조회
show full columns from author;

-- 테이블 생성문 조회 : 어떤 생성문 써서 만들어졌는지 조회하는 것
show create table author;

-- posts테이블 신규 조회
CREATE table posts(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255),author_id INT, foreign KEY(author_id) references author(id));

-- 테이블 인덱스 조회
show index from author;
show index from posts;

-- ALTER문 : 테이블의 구조를 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table author add column test1 varchar(50);
-- 테이블 컬럼 삭제
alter table author drop column test1;
-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255)
-- 테이블 컬럼 타입과 제약조건 변경
alter table author modify column email varchar(255) not null;

-- 실습 : author 테이브레 address 컬럼 추가(VARCHAR(255))
alter table author add column address varchar(255);
-- 실습 : post 테이블에 title은 not null, contents는 3000자로 변경 
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
drop 테이블명;
-- 위 명령어로 없애기 전에 이거 하면 아래의 결과값 나와! 그러면 아래 결과값 복붙하면 데이터는 안되더라도 골조는 복붙 된다.
show create table post;

 CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
)