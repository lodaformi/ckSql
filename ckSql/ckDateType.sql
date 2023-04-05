SELECT array(1, 2) as a , toTypeName(a);
SELECT [1, 2, null] as a , toTypeName(a);

CREATE TABLE Array_TEST (
    c1 Array(String)
) engine = Memory;

insert into Array_TEST  values(array('aa', 'bb'));


SELECT tuple(1,'a',now()) AS x, toTypeName(x);
SELECT (1,2.0,null) AS x, toTypeName(x);

CREATE TABLE Tuple_TEST (
    c1 Tuple(String,Int8)
) ENGINE = Memory;


CREATE TABLE Enum_TEST (
c1 Enum8('ready' = 1, 'start' = 2, 'success' = 3, 'error' = 4)
) ENGINE = Memory;
--正确语句
INSERT INTO Enum_TEST VALUES('ready');
INSERT INTO Enum_TEST VALUES('start');
--错误语句
INSERT INTO Enum_TEST VALUES('stop');

CREATE TABLE nested_test (
name String,
age UInt8 ,
dept Nested(
id UInt8,
name String
)
) ENGINE = Memory;
--行与行之间,数组长度无须对齐
INSERT INTO nested_test VALUES ('bruce' , 30 , [10000,10001,10002], ['研发部','技术支持中心','测试部']);
INSERT INTO nested_test VALUES ('bruce' , 30 , [10000,10001], ['研发部','技术支持中心']);


CREATE TABLE Null_TEST (
c1 String,
c2 Nullable(UInt8)
) ENGINE = TinyLog;
--通过Nullable修饰后c2字段可以被写入Null值：
INSERT INTO Null_TEST VALUES ('nauu',null);
INSERT INTO Null_TEST VALUES ('bruce',20);
SELECT c1 , c2 ,toTypeName(c2) FROM Null_TEST;

CREATE TABLE IP4_TEST (
url String,
ip IPv4
) ENGINE = Memory;
INSERT INTO IP4_TEST VALUES ('www.nauu.com','192.0.0.0')
SELECT url , ip ,toTypeName(ip) FROM IP4_TEST