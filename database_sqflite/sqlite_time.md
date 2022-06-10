--where start_time = '2022-1-1 1:1'

select *
from my_table
-where strftime('%Y-%m-%d %H:%M', start_time) = strftime('%Y-%m-%d %H:%M', '2022-01-01 01:01')
;
1	2022-01-01 01:01	killer

select *
from my_table
where strftime('%Y-%m-%d %H:%M', start_time) = '2022-01-01 01:01'
1	2022-01-01 01:01	killer


select *
from my_table
where strftime('%m', start_time) = '01'
;
1	2022-01-01 01:01	killer
2	2022-01-15 08:10	qurdratic


select *
from my_table
where strftime('%Y-%m-%d' , start_time) = '2022-01-30'

1	2022-01-01 01:01	killer
2	2022-01-15 08:10	qurdratic





List<Map> maps = await db.rawQuery("""
      select *
      from ${myEntity.table_name}
      where start_time = $selected_time;
      ;
    """);
以为$selected_time传入`String selected_time = '2022-01-10 03:03'`后会带`''`，结果不带，那么`      where start_time = 2022-01-10 03:03`肯定是错的。

List<Map> maps = await db.rawQuery("""
      select *
      from ${myEntity.table_name}
      where start_time = '$selected_time';
      ;
    """);