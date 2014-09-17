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




## 部分截图：

ALToast

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/ALToast.png)


## log:

20140916 增加ALToast
20140917 增加UIView+Frame

