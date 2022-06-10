INTEGER：INT
REAL：FLOAT，DOUBLE
TEXT：CHAR(50)，VARCHAR


时间
TEXT：它以“yyyy-mm-dd hh:mm:ss.sss” 格式指定日期
REAL：它规定了从公元前4714年11月24日在格林威治中午以后的天数。
INTEGER：它指定从1970-01-01 00:00:00 utc开始的秒数。

布尔
在SQLite中，没有一个单独的布尔存储类。一个代替办法是将布尔值存储为整数0(假)和1(真)。



CREATE TABLE if not exists departments  
(
    department_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    department_name VARCHAR  
); 

CREATE TABLE employees  
(
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    department_id INTEGER,  
    CONSTRAINT fk_departments  
    FOREIGN KEY (department_id)  
    REFERENCES departments(department_id)  
);

`CONSTRAINT fk_departments FOREIGN KEY (department_id) REFERENCES departments(department_id)`是一行语句





INSERT INTO student (ID,NAME,AGE,ADDRESS,FEES)  
VALUES (1, 'Maxsu', 27, 'Shengzhen', 20000.00);

应该确保值的顺序与表中列的顺序相同。
INSERT INTO student VALUES (6, 'Javasu', 21, 'Shengzhen', 18000.00 );




