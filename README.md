iosTool
=======

## 开发工具

### ALToast

该控件主要用于提示，采用非arc模式编写

其中，可以设置提示的上下偏移位置，支持转屏显示。如果需要，可进行适当的自定义。

使用：

	 [ALToastView toastInView:self.view withText:@"Hello"];
	 或
	 [ALToastView toastInView:self.view withText:@"Hello" offSetY:-20];
  


### UIView+Frame
工具，提供对view的frame属性的设置和获取
包含:

     * left top right bottom width height centerX centerY origin size
     * removeAllSubviews viewController

### VDShareFileHandle

工具，提供对文件的基本操作(非ARC)。

包括获取系统目录路径、以只读/只写形式获取path的fileHandel、删除文件、是否存在文件、拷贝文件、获取文件大小、删除特定后缀的文件、获取目录中所有文件名、获取文件的修改日期、文件重命名、写入/读取文件Data、创建文件/目录、添加/覆盖数据等

### VDShareFileHandle
增加圆形进度条，该案例提供了对自定义进度条的一种思路，主要通过drawRect进行实现。

ProgressView *progress = [[ProgressView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];

    progress.arcFinishColor = COLOR_STRING(@"#75AB33");

    progress.arcUnfinishColor = COLOR_STRING(@"#0D6FAE");

    progress.arcBackColor = COLOR_STRING(@"#EAEAEA");

    progress.percent = 1;

    [detil addSubview:progress];


## 部分截图：

ALToast

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/ALToast.png)


## log:

20140916 增加ALToast

20140917 增加UIView+Frame

20140922 增加VDFileHandel

20141219 增加UITableView搜索、索引相关

20151021 增加圆形进度条

20160222 增加改造了的SlimeRefresh，刷新控件

