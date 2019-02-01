# 打表工具
## 1. 支持的打表方式和数据类型
|          |bool  |uint8 |int8  |uint16|int16 |uint32|int32 |uint64|int64 |float |double|string|array |object|
|----------|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|console   |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|json      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|json-unity|      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|json-go   |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|lua-module|      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|lua-return|      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|lua-table |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|python    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|protobuf  |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|tbl       |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |*     |      |      |
|mysql     |      |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |      |      |
|mongo     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |+     |

## 2. Excel中可填写的数值格式
1. `bool`支持的格式
	* `true`,`T`,`Y`,`1`代表`true`
	* `false`,`F`,`N`,`0`代表`false`
2. `uint32`支持的格式
	* 普通数字
	* `0x`开头的十六进制，如: `0x01ABCDEF`
	* `#`开头的颜色格式，如: `#RRGGBB`, `#AARRGGBB`
	* `,`分隔的颜色格式，如: `255,255,255`, `255,255,255,255`
	* `.`分隔的IP地址格式，如: `192.168.1.1`
3. `int8-64`/`uint8-64`支持的格式
	* 普通数字
	* `*`开头的二进制，可任意添加空格分隔。如：`*1010 0001`

## 3. protobuf方式打表
1. 生成的`proto`文件为表格行数据格式描述
2. 生成的`pbt`文件为表格数据的protobuf二进制序列化，格式如下：  
	`LengthPrefix := VarInt of Base128`  

| 序列化数据 | 说明 |
| -------- | -------- |
| LengthPrefix + **FileDescriptorSet**| 数据格式的标准化描述 |
| LengthPrefix + *&lt;record&gt;* | 表格行数据 |
| ... | 表格行数据... |

## 4. tbl方式打表
1. 支持的数据类型:
	* `bool`
	* `uint8, int8, uint16, int16, uint32, int32, uint64, int64`
	* `float, double`
	* `string`, 必须指定`size`属性以限定生成内容的二进制**字节数**
2. `output`节点格式：
	* `encoding.data`: 指定生成的`tbl`二进制数据中的字符串编码
	* `encoding.code`: 指定生成的`C++`代码文件编码

## 5. lua方式打表
1. 可通过`encoding.code`指定生成的lua代码文件编码
2. 当表格行数过多时，可自动拆分闭包，避免[LuaJIT报错](http://love2d.org/forums/viewtopic.php?t=33095&p=100700)
3. 支持多种格式的lua输出：
	* lua-table
```lua
task = {
[1]={["id"]=1,["taskId"]="1",["taskName"]="首次充值1"},
[2]={["id"]=2,["taskId"]="2",["taskName"]="赢取20盘"},
}
task.query = function(index) return task[index] end
```
	* lua-module
```lua
module('task', package.seeall)
task[1]={["id"]=1,["taskId"]="1",["taskName"]="首次充值1"}
task[2]={["id"]=2,["taskId"]="2",["taskName"]="赢取20盘"}
task.query = function(index) return task[index] end
```
	* lua-return
```lua
local task = {
[1]={["id"]=1,["taskId"]="1",["taskName"]="首次充值1"},
[2]={["id"]=2,["taskId"]="2",["taskName"]="赢取20盘"},
}
task.query = function(index) return task[index] end
return task
``` 
4. 没有指定`key`时，将输出下标从`1`开始的lua致密数组。同时生成按照下标访问的`query`查询函数
5. 当只有1个`key`时，可支持除`object`和`array`之外的所有标量键类型。生成按照该key访问的`query`查询函数
6. 当有多个`key`时，所有key只能采用整数类的类型，通常需要加配`mul`属性，最终查询key的计算方式为 `KEY = SUM(m_i * mul_)`，`mul`缺省值为`1`。将生成按照key声明顺序的`query`查询函数。  
	* 如下配置描述了`id * 0x10000 + level * 0x100`的查询主键： 
```xml
<output type="lua-table" code="SkillKey2" file="SkillTable.xlsx" sheet="Sheet1">
	<key code="id" mul="0x10000" />
	<key code="level" mul="0x100" />
	<field column="id" type="int32" />
	<field column="level" type="int32" />
	<field column="name" type="string" />
</output>
```
	其等价的字节位占用状态如下，相当于`(id << 16) | (level < 8)`:  
```
|      第 3-4 节     |   第2字节    |  第1字节 |
| <------ id ------> | <- level -> |     0    |
```


