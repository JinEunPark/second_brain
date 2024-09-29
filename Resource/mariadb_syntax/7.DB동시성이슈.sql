-- dirty read 실습
-- 워크벤치에서 auto_commit 해제 후 아무거나 update -> commit이 안 된 상태
-- 터미널을 열어서 select 했을 때 위 변경사항이 변경됐는지 확인
-- 변경 안 된 거면 dirty read 아닌 거

-- phantom read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 2번의 select가 이뤄지고,
-- 터미널에서 중간에 insert 실행 --> 2번의 select 결과값이 동일한지 확인
START TRANSACTION;
SELECT count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에 아래의 insert문 실행
insert into author(name,email) values("kim","kim@naver.com");

-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 워크벤치에서 아래 코드 실행
-- select는 허용하되 update는 허용 안 되는 걸 확인할 수 있음
start transaction;
select post_count from author where id=5555 lock in share mode;
do sleep(5);
select post_count from author where id=5555 lock in share mode;
commit;
-- 터미널
select post_count from author where id=5555;
update author set post_count=0 where id=5555;

-- 배타적 잠금(exclusive lock) : select for update
-- select 부터 lock
start transaction;
select post_count from author where id=5555 for update;
do sleep(5);
select post_count from author where id=5555 for update;
commit;
-- 터미널
select post_count from author where id=5555 for update;
update author set post_count=0 where id=5555;