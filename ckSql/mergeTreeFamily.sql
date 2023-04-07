--排序键ORDER BY所声明的表达式是后续作为判断数据是否重复的依据。
--如果没有设置ver版本号，则保留同一组重复数据中的最后一行。
CREATE TABLE loda.replace_table(
    id String,
    code String,
    create_time DateTime
)ENGINE = ReplacingMergeTree()
PARTITION BY toYYYYMM(create_time)
ORDER BY (id,code)
PRIMARY KEY id;

-- 2021-05_1_1_0
insert into loda.replace_table select number%10 ,'code', '2021-05-01' from numbers(20);

-- 2021-05_2_2_0
insert into loda.replace_table select number%10 ,'code', '2021-05-03' from numbers(20);
-- 2021-05_1_2_1
optimize table loda.replace_table final;
-- 2021-06_3_3_0
insert into loda.replace_table select number%10 ,'code', '2021-06-01' from numbers(20);
-- 2021-07_4_4_0
insert into loda.replace_table select number%10 ,'code', '2021-07-01' from numbers(20);
-- 2021-07_5_5_0
insert into loda.replace_table select number%10 ,'code', '2021-07-03' from numbers(20);
-- 2021-05_1_2_2
-- 2021-06_3_3_1
optimize table loda.replace_table final;
select * from loda.replace_table;