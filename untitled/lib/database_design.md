DogEntity 在 MyEntity 的基础上，DogDAO 在 MyDAO 的基础上。

调用的时候，不用 MyEntity 和 MyDAO，而是用具体的实现。

# implement or extends

## Entity: implement or extends

用implement，因为属性都不一样，那么toMap()，getKeyId()肯定不一样，那么就没有父类方法能共用，都需要自己实现。

## DAO: implement or extends


用接口implement，好像多此一举。比如，根据主键id删除entity，那么好像每个XXXDAO都得写一遍这样重复的语句，多余。

所以，要用extends，在MyDAO中写好，有必要重载就重载，没必要就不用重载。

如果要extends，那么就要解决主键名不一致的问题，这就是每个XXXEntity中getKeyId()和setKeyId()的目的。

# Entity属性

`late String table_name;`：表名。这样在DAO中就能获取表名。
`late String key_id_name;`：主键名

