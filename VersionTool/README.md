# 版本工具

* md5 计算文件的md5码
	* 参数1: 文件路径

* index 从散文件获得索引表
	* 参数1: 散文件目录
	* 参数2: 生成索引文件名

* indexmerge 索引文件合并
	* 参数1: 基础索引文件
	* 参数2: 新索引文件，将在基础索引文件之上进行合并
	* 参数3: 输出索引文件

* version|versionweb 创建版本部署文件
	* 参数1: 当前散文件目录
	* 参数2: 部署输出目录（包括索引文件）
	* *参数3: 基础版本索引文件名*
    * *参数4: 是否清空或覆盖部署输出目录 clean:true|false*

* lzma 调用系统`lzma.exe`进行压缩工作
	* e|d 模式可针对目录批量操作
	* 目标路径可自动创建
	```
    Usage:  LZMA <e|d> inputFile outputFile [<switches>...]
		e: encode file
		d: decode file
		b: Benchmark
	<Switches>
		-a{N}:  set compression mode - [0, 1], default: 1 (max)
		-d{N}:  set dictionary size - [12, 30], default: 23 (8MB)
		-fb{N}: set number of fast bytes - [5, 273], default: 128
		-mc{N}: set number of cycles for match finder
		-lc{N}: set number of literal context bits - [0, 8], default: 3
		-lp{N}: set number of literal pos bits - [0, 4], default: 0
		-pb{N}: set number of pos bits - [0, 4], default: 2
		-mf{MF_ID}: set Match Finder: [bt2, bt3, bt4, hc4], default: bt4
		-mt{N}: set number of CPU threads
		-eos:   write End Of Stream marker
		-si:    read data from stdin
		-so:    write data to stdout
	```

* xmlmin XML文件紧缩
	* 参数: 要紧缩的文件名列表，处理完成后将**覆盖原始文件**