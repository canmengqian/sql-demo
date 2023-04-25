/*
  多行注释, 简单PL/SQL块
 */

DECLARE
    -- 定义变量
    name             varchar2(20)     := 'zhangsan' || 'ok';
    plNum            PLS_INTEGER      := 1;
    intNum           INT              := 10;
    sum              INTEGER          := 0;
    -- 定义常量, 默认值为0
    v_const CONSTANT INTEGER NOT NULL := 0;
    r_fundCode       FUND_INFO.fund_code%type ;
    v_fundCode       varchar2(20)     := 'X00001';

begin
    -- DBMS_OUTPUT.PUT_LINE(name);
    -- DBMS_OUTPUT.PUT_LINE('Value of v_const:' || v_const);
    -- SELECT FUND_CODE INTO r_fundCode FROM FUND_INFO FI  WHERE  FUND_CODE =v_fundCode;
    -- 条件运算
    if (v_const > 10) then
        DBMS_OUTPUT.PUT_LINE('SUM 大于10');
    else
        DBMS_OUTPUT.PUT_LINE('SUM 小于10');
    end if;

    -- 子块
    declare
        v_const CONSTANT INTEGER NOT NULL := 1;
    begin
        DBMS_OUTPUT.PUT_LINE('Value of v_const:' || v_const);
        DBMS_OUTPUT.PUT_LINE('Value of v_const:' || (v_const + 2));
    end;
    -- case语句
    case v_const
        when 0 then DBMS_OUTPUT.PUT_LINE('Value of v_const:' || v_const);
        when 1 then DBMS_OUTPUT.PUT_LINE('Value of v_const is 1');
        else DBMS_OUTPUT.PUT_LINE('Value of v_const is error');
        end case;
exception
    WHEN no_data_found THEN
        dbms_output.put_line('没有找到符合条件的客户信息!');
    WHEN others THEN
        dbms_output.put_line('Error!');
end

;

/*
  LOOP 循环
 */
DECLARE
    x NUMBER := 10;
begin
    loop
        DBMS_OUTPUT.PUT_LINE(x);
        x := x + 10;
        if x > 50 then
            exit ;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('使用exit when 作为结束条件');
    x := 0;
    loop
        DBMS_OUTPUT.PUT_LINE(x);
        x := x + 10;
        exit when x > 50; -- 结束判断条件
    end loop;
end;


/*
  while 循环
 */
declare
    x number := 0;
begin
    while x < 50
        loop
            DBMS_OUTPUT.PUT_LINE(x);
            x := x + 10;
        end loop;
end;

/*
    for 循环
 */
declare
    x number := 0;
begin
    for x in 10 .. 20
        loop
            DBMS_OUTPUT.PUT_LINE(x);
        end loop;
end;


/**
 反向 for 循环
 */
declare
    x number := 0;
begin
    for x in reverse 10 .. 20
        loop
            DBMS_OUTPUT.PUT_LINE(x);
        end loop;
end;
/*
  定义数组
 */
declare
    type name_array IS VARRAY (1000000) of varchar2(200);
    names name_array;
begin
    names := name_array('a', 'b', 'c', 'd');
    DBMS_OUTPUT.PUT_LINE('数组长度为:' || names.COUNT);
    for i in 1 .. names.COUNT
        loop
            DBMS_OUTPUT.PUT_LINE('name from array is ' || names(i));
        end loop;
end;

SELECT *
FROM FUND_INFO;
/*
 数组实例2
 */
declare
    cursor c_fund is select *
                     from FUND_INFO;
    type f_arr is varray (100) of FUND_INFO.fund_name%type;
    d_funds f_arr   := f_arr();
    cnt     integer := 0;
begin
    for n in c_fund
        loop
            exit when cnt > 30;
            cnt := cnt + 1;
            d_funds.extend;
            d_funds(cnt) := n.FUND_NAME;
            DBMS_OUTPUT.PUT_LINE(d_funds(cnt));
        end loop;
end;

/*
 创建存储过程
 */
create or replace procedure pro_test1
AS
begin
    DBMS_OUTPUT.PUT_LINE('hello');
end;

/*
 使用程序块调用存过
 */
begin
    pro_test();
end;

/*
 删除存过
 */
DROP PROCEDURE pro_test;

/*
 IN 模式
 */
declare
    a number;
    b number;
    c number;
    PROCEDURE findMin(x IN number, y IN number, z out number) IS
    begin
        if x > y then
            z := y;
        else
            z := x;
        end if;
    end;
begin
    a := 12;
    b := 13;
    findMin(a, b, c);
    DBMS_OUTPUT.PUT_LINE('the result is ' || c);
end;

/*
 IN OUT模式
 */
declare
    a number;
procedure squareNum(x IN OUT  number) IS
 begin
     x:= x * x ;
end;
begin
    a:= 11;
    squareNum(a);
    DBMS_OUTPUT.PUT_LINE('the a result is '|| a);
end;

begin
    pro_test1();
end;



