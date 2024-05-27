![[스크린샷 2024-05-27 오후 6.02.08.png]]


```sql

create table member  
(  
    created_at timestamp(6),  
    id         bigserial  
        primary key,    updated_at timestamp(6),  
    email      varchar(255),  
    name       varchar(255)  
);  
  
alter table member  
    owner to jin_eun;  
  
create table member_location  
(  
    geo_id          bigserial  
        primary key,    member_id       bigint  
        unique        constraint fko6mxytmnk546jt18pp1cnnd3y  
            references member,  
    depart_location geometry(Point, 4326) not null,  
    des_location    geometry(Point, 4326) not null  
);  
  
alter table member_location  
    owner to jin_eun;  
  
create table taxi_group  
(  
    people_num     integer,  
    departure_time timestamp(6),  
    id             bigserial  
        primary key,    depart_add     varchar(255) not null,  
    des_add        varchar(255) not null  
);  
  
alter table taxi_group  
    owner to jin_eun;  
  
create table chat_room  
(  
    created_at       timestamp(6),  
    id               bigserial  
        primary key,    taxi_group_id_id bigint  
        unique        constraint fk1fbh7wntvfxgs5v9o7t80o87u  
            references taxi_group  
);  
  
alter table chat_room  
    owner to jin_eun;  
  
create table chat_message  
(  
    char_room_id bigint  
        constraint fkkhfuv410to0gvikno3x2bl6pt  
            references chat_room,  
    created_at   timestamp(6),  
    id           bigserial  
        primary key,    sender_id    bigint  
        unique        constraint fk8jhls1uruq1px1lt5n35cgirp  
            references taxi_group,  
    content      varchar(255)  
);  
  
alter table chat_message  
    owner to jin_eun;  
  
create table taxi_member  
(  
    id               bigserial  
        primary key,    member_id_id     bigint  
        unique        constraint fknd25iff43v3phffqmxnuuts7p  
            references member,  
    taxi_group_id_id bigint  
        constraint fkowwl9syb8y1n139qmqva7g79m  
            references taxi_group  
);  



```