-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null

-- auto_increment
alter table author modify colum id bigint auto_increment;
alter table post modify colum id bigint auto_increment;

--자주 일어나는 일은 아니지만 수업차원에서 배우는 거 
-- author.id에 제약조건 추가시 fk로 인해 문제 발생시
-- fk 먼저 제거 이후에 author.id에 제약조건 추가
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'post';
-- 삭제
alter table post drop foreign key post_ibfk_1;
-- 삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 에러뜸
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'post';
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update casecade;

-- (실습) delete는 set null, update는 cascade
SELECT BOARD_ID,WRITER_ID,TITLE,PRICE,
case STATUS
    WHEN 'SALE' then '판매중'
    WHEN 'RESERVED' then '예약중'
    when 'DONE' then  '거래완료'
END as STATUS
from USED_GOODS_BOARD 
where CREATED_DATE='2022-10-05'
order by BOARD_ID desc

--12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE,
ifnull(TLNO, 'NONE') as TLNO
from PATIENT 
where AGE <= 12 and GEND_CD='W'
order by AGE desc, PT_NAME asc