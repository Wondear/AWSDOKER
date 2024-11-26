-- --------------------------------------------------------
-- db 생성 및 유저 권한 할당
-- --------------------------------------------------------
create database if not exists ohgi_restaurant;

create user if not exists 'ohgiraffers'@'%' identified by 'ohgiraffers';
grant all privileges on ohgi_restaurant.* to 'ohgiraffers'@'%';


use ohgi_restaurant;


-- --------------------------------------------------------
-- ddl
-- --------------------------------------------------------
-- tbl_category(상품 카테고리)
drop table if exists tbl_category;
create table if not exists tbl_category
(
    -- column level constraints
    category_code int auto_increment comment '카테고리식별코드',
    category_name varchar(255) not null comment '카테고리명',
    -- table level constraints
    constraint pk_category_code primary key (category_code)
) engine=innodb comment '상품카테고리';


-- tbl_member(회원)
drop table if exists tbl_member;
create table if not exists tbl_member
(
    -- column level constraints
    member_code int auto_increment comment '회원식별코드',
    member_id varchar(255) unique not null comment '아이디',
    member_name varchar(255) not null comment '회원이름',
    member_password varchar(255) not null comment '비밀번호',
    member_email varchar(255) not null comment '이메일',
    -- table level constraints
    constraint pk_member_code primary key (member_code)
) engine=innodb comment '회원';


-- tbl_authority(권한)
drop table if exists tbl_authority;
create table if not exists tbl_authority
(
    -- column level constraints
    authority_code int auto_increment comment '권한식별코드',
    authority_name varchar(255) not null comment '권한명',
    authority_desc varchar(4000) not null comment '권한설명',
    -- table level constraints
    constraint pk_authority_code primary key (authority_code)
) engine=innodb comment '권한';


-- tbl_member_role(회원별권한)
drop table if exists tbl_member_role;
create table if not exists tbl_member_role
(
    -- column level constraints
    member_code int auto_increment comment '회원식별코드',
    authority_code int not null comment '권한식별코드',
    -- table level constraints
    constraint pk_member_role primary key (member_code, authority_code)
) engine=innodb comment '회원별권한';


-- tbl_order(주문)
drop table if exists tbl_order;
create table if not exists tbl_order
(
    -- column level constraints
    order_code int auto_increment comment '주문식별번호',
    product_code int not null comment '상품코드',
    order_member int not null comment '회원식별코드',
    order_phone varchar(255) not null comment '휴대전화연락처',
    order_email varchar(255) not null comment '이메일주소',
    order_receiver varchar(255) not null comment '받는사람',
    order_address varchar(500) not null comment '배송주소',
    order_amount varchar(50) not null comment '주문개수',
    order_date varchar(255) not null comment '주문일자',
    -- table level constraints
    constraint pk_order_code primary key (order_code)
) engine=innodb comment '주문';


-- tbl_product(상품)
drop table if exists tbl_product;
create table if not exists tbl_product
(
    -- column level constraints
    product_code int auto_increment comment '상품코드',
    product_name varchar(255) not null comment '상품명',
    product_price int not null comment '상품가격',
    product_description varchar(1000) comment '상품설명',
    product_orderable varchar(5) not null comment '구매가능여부',
    category_code int comment '카테고리식별코드',
    product_image_url varchar(255) not null comment '상품이미지경로',
    product_stock int not null comment '상품재고',
    -- table level constraints
    constraint pk_product_code primary key (product_code)
) engine=innodb comment '상품';


-- tbl_review(상품리뷰)
drop table if exists tbl_review;
create table if not exists tbl_review
(
    -- column level constraints
    review_code int auto_increment comment '리뷰식별번호',
    product_code int not null comment '상품코드',
    member_code int not null comment '회원식별코드',
    review_title varchar(255) not null comment '리뷰제목',
    review_content varchar(1000) not null comment '리뷰내용',
    review_create_date varchar(255) not null comment '작성일자',
    -- table level constraints
    constraint pk_review_code primary key (review_code)
) engine=innodb comment '상품리뷰';



-- PASSWORD : 1234
INSERT INTO tbl_member (member_id, member_name, member_password, member_email) VALUES ('admin', '관리자', '$2a$10$COvazywgZPXseeKaYhruh.pAYYfcSeGO5aSrHOsLZN0X8joNwW2dW', 'ohgiraffers.owl@gmail.com');
INSERT INTO tbl_member (member_id, member_name, member_password, member_email) VALUES ('test01', '오지라퍼', '$2a$10$N34MRj4tKVD0AxwvEcC8eOLUyBpXloPKE7Yw.S4/kj5fD1OU5BWsi', 'test01@naver.com');

INSERT INTO tbl_authority (authority_name, authority_desc) VALUES ('ROLE_ADMIN', '관리자');
INSERT INTO tbl_authority (authority_name, authority_desc) VALUES ('ROLE_USER', '일반회원');

INSERT INTO tbl_member_role (member_code, authority_code) VALUES (1, 1);
INSERT INTO tbl_member_role (member_code, authority_code) VALUES (1, 2);
INSERT INTO tbl_member_role (member_code, authority_code) VALUES (2, 2);

INSERT INTO tbl_category (category_name) VALUES ('식사');
INSERT INTO tbl_category (category_name) VALUES ('디저트');
INSERT INTO tbl_category (category_name) VALUES ('음료');

INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('열무김치라떼', 4500, '열무로 만든 김치 라떼', 'Y', 3, '06a0060ae2da4dffb9a8a440ba5d9c5e.PNG', 10);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('우럭스무디', 5000, '우럭으로 만든 스무디', 'Y', 3, 'fcb3e0c8f94940cf99724d26e6020259.PNG', 15);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('생갈치쉐이크', 6000, '생으로 갈아만든 갈치 쉐이크', 'Y', 3, '8e2492fd197e42d5855ffbbb5142b4ed.PNG', 17);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('갈릭미역파르페', 7000, '갈릭 미역을 섞어 만든 파르페', 'Y', 2, '58b3fd68f6074de2b33d4430fd29244b.PNG', 19);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('앙버터김치찜', 13000, '가장 먹을만한 김치찜', 'Y', 1, '7580adcf59d04240b7a16f6cf07bd34b.PNG', 19);

INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('생마늘샐러드', 12000, '생마늘을 넣어 만든 샐러드', 'Y', 2, '7b91aee3ddec49a69a9b7d2849493f7f.PNG', 24);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('민트미역국', 15000, '민트를 넣어만든 미역국', 'Y', 1, 'af732dfe3e4f482bac8d1ef0bd9be02b.PNG', 12);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('한우딸기국밥', 20000, '한우에 딸기를 얹은 국밥', 'Y', 1, '8a4cd876df574970a565b41e47561080.PNG', 22);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('홍어마카롱', 9000, '홍어를 갈아 넣은 마카롱', 'Y', 2, 'c0a177a658b44f749699f91a23c47d8b.PNG', 17);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('코다리마늘빵', 7000, '코다리 마늘빵은 진리', 'Y', 2, '053626c2d16f4814a5e81b842a115dc7.PNG', 17);

INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('정어리빙수', 10000, '정어리를 갈아 만든 빙수', 'Y', 2, '323a5df17163482d90a74f8198a4e4c6.PNG', 12);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('날치알스크류바', 2000, '스크류바에 날치알이라니', 'Y', 2, 'd97144a76a7b42fabfcf8a5662762040.PNG', 12);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('직화구이젤라또', 8000, '젤라또를 직화로', 'Y', 2, 'a4195b272f764a3ab81e85fbbba6c067.PNG', 16);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('과메기커틀릿', 13000, '커틀렛 속에 쏙 과메기', 'Y', 1, '702215dbe9784ebf92561d5504b0b5a6.PNG', 11);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('죽방멸치튀김우동', 11000, '너도 나도 죽방 멸치 우동', 'Y', 1, '5c226e59e7c342608d220ce0c476d01f.PNG', 13);

INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('흑마늘아메리카노', 3000, '흑마늘을 넣은 아메아메아메리카노', 'Y', 3, '684fd2cccfc74ad4944619bc72f76788.PNG', 21);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('아이스가리비관자육수', 50000, '아이스 육수 가리비 관자', 'Y', 1, 'b150ff66223a46adabb75a71299cb25a.PNG', 16);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('붕어빵초밥', 20000, '초밥이 붕어빵에 있는것인가 그 반대인가', 'Y', 1, 'c260a42b01394faba92ed9a7ca868aa9.PNG', 11);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('까나리코코넛쥬스', 5000, '코코넛 주스에 까나리 한스푼', 'Y', 3, '21406eb90b2f4ae09ea0af015d2df6fe.PNG', 28);
INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('마라깐쇼한라봉', 22000, '마라깐쇼 한라봉 고고', 'Y', 3, 'eccf4c58d72241ddb4c84401485d4363.png', 21);

INSERT INTO tbl_product (product_name, product_price, product_description, product_orderable, category_code, product_image_url, product_stock) VALUES ('돌미나리백설기', 5000, '백설기 속에 씹히는 돌미나리', 'Y', 2, '9a6c1b13af0a469fa2d9e3084f6e438c.PNG', 12);

INSERT INTO tbl_review (product_code, member_code, review_title, review_content, review_create_date) VALUES (1, 2, '열무김치라떼 리뷰 입니다.', '정말 맛있는 이 라떼 나만 마실 순 없지요~! 꼭 드세요! 두번두번 드세요~!드세요~!', DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s'));
INSERT INTO tbl_review (product_code, member_code, review_title, review_content, review_create_date) VALUES (21, 2, '돌미나리백설기 리뷰 입니다.', '나는 돌도 씹어먹을 수 있다~ 하시는 분만 드시기 바랍니다~! 진짜 돌이에요', DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s'));
INSERT INTO tbl_review (product_code, member_code, review_title, review_content, review_create_date) VALUES (20, 2, '마라깐쇼한라봉 리뷰 입니다.', '한라봉을 먹는데 매콤하네요? 국물이 시원합니다~!', DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s'));
INSERT INTO tbl_review (product_code, member_code, review_title, review_content, review_create_date) VALUES (19, 2, '까나리코코넛쥬스 리뷰 입니다.', '레거시 미디어에서나 볼 수 있던 그 음료! 영접해봤습니다.', DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s'));
INSERT INTO tbl_review (product_code, member_code, review_title, review_content, review_create_date) VALUES (18, 2, '붕어빵초밥 리뷰 입니다.', '붕어빵으로 만든 초밥인데 이게 빵인지 붕어인지 모르겠습니다.', DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s'));
INSERT INTO tbl_review (product_code, member_code, review_title, review_content, review_create_date) VALUES (17, 2, '아이스가리비관자육수 리뷰 입니다.', '이가 시려워 꽁 발이 시려워 꽁 관자육수 때문에 꽁꽁꽁!', DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s'));