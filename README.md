# TextKitDemo  


*  Text Kit特点
*  Text Kit在实际开发中具有如下特点：
*      1.在UI控件中Text Kit完全掌控着文字的排版和渲染
*      2.UITextView、UITextField和UILabel是构建于Text Kit之上的
*      3.能够与动画、UICollectionView和UITableView做到无缝集成
*      4.Text Kit具有这样一些能力：Subclassing、Delegation和Notifcation。

* Text Kit功能概述
*  这里列出了是一些常用和重要功能：
*      1.对文字进行分页或多列排版
*      2.支持文字的换行、折叠和着色等处理
*      3.可以调整字与字之间的距离、行间距、文字大小、指定特定的字体
*      4.支持富文本编辑，可以自定义文字截断
*      5.支持凸版印刷效果(letterpress)
*      6.支持数据类型的检测(例如链接、附件等)


* Text Kit中主要有4个重要的对象  
1.  `NSTextContainer。定 了文本可以排版的区 。 认情况下是矩形区 ，如果是其它形状的区域，需要通过子类化NSTextContainer来创建。`
2. `NSLayoutManager。该类负责对文字进行编 排版处理，将存储在NSTextStorage中的数据转换为可以在视图控件中显示的文本内容，并把字编码映射到到对应的字形上，然后将字形排版到NSTextContainer定义的区域中。`
3. `NSTextStorage。主要用来存储文本的字 和相关属性`
4. `NSAttributedString。 持渲染不同风格的文本。` 
5. `NSMutableAttributedString。可变类 的NSAttributedString，是NSAttributedString的子类`  

NSLayoutManager对象从NSTextStorage对象中取得文本内容， 进行排版，然后把排版之后的文本放到NSTextContainer对象指定的区 上。最后 由一个文本控件从 NSTextContainer中取出内容显示到屏幕中。  


[代码实例](https://github.com/zhangbinbin5335/TextKitDemo.git)

