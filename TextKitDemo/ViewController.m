//
//  ViewController.m
//  TextKitDemo
//
//  Created by zhangbinbin on 2017/3/22.
//  Copyright © 2017年 zhangbinbin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

// 定义了文本可以排版的区
@property (nonatomic,strong) NSTextContainer* textContainer;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

// 突出word
- (void) markWord:(NSString*)word inTextStorage:(NSTextStorage*)textStorage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
    //textView.enable = NO才可以识别电话等
    self.textView.dataDetectorTypes = UIDataDetectorTypePhoneNumber |
                                      UIDataDetectorTypeLink;
    self.textView.text = @"zbb,http://www.baidu.com 18616924096";
     */

    // 创建一个矩形区，这个区是通过CGRectInset函数创建的，这个函数能指定一个中
    // 心点，后面的两个参数 着self.view.bounds区域向内内进量。这样可以使得文字部分不会太靠近视图的边界。
    CGRect textViewRect = CGRectInset(self.view.bounds, 10.0, 20.0);
    
    // 主要用来存储文本的字 和相关属性
    NSTextStorage* textStorage = [[NSTextStorage alloc]initWithString:_textView.text];
    
    // 该类负责对文字进行编 排版处理,将存储在NSTextStorage中的数据转换为可以在视图控件中显示的文本内容
    NSLayoutManager* layoutManager = [[NSLayoutManager alloc]init];
    
    [textStorage addLayoutManager:layoutManager];
    
    // 定义了文本可以排版的区
    _textContainer = [[NSTextContainer alloc]initWithSize:textViewRect.size];
    
    /**
     *  NSLayoutManager对象从NSTextStorage对象中取得文本内容，进行排版，
     *  然后把排版之后的文本放到NSTextContainer对象指定的区域上。
     *  最后由一个文本控件从NSTextContainer中取出内容显示到屏幕中。
     */
    [layoutManager addTextContainer:_textContainer];
    
    [_textView removeFromSuperview];
    
    _textView = [[UITextView alloc]initWithFrame:textViewRect
                                   textContainer:_textContainer];
    _textView.textColor = [UIColor yellowColor];
    _textView.editable = NO;
    [self.view addSubview:_textView];
    [self.view bringSubviewToFront:_imageView];
    
    // 设置凸印效果
    [textStorage beginEditing];
    
    NSDictionary *attrsDic = @{NSTextEffectAttributeName: NSTextEffectLetterpressStyle};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:_textView.text
                                          attributes:attrsDic];
    [textStorage setAttributedString:attrStr];
    
    [self markWord:@"you" inTextStorage:textStorage];
    [self markWord:@"I" inTextStorage:textStorage];
    [self markWord:@"言" inTextStorage:textStorage];
    
    [textStorage endEditing];
    
    // 文字图文混和排版
    // Text Kit通过环绕路径(exclusion paths)将文字按照指定的路径环绕在图片等视图对象的周围
    
    // 设置环绕路径，可以指定多个
    _textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
    
    // 动态字体
    // 注册 UIContentSizeCategoryDidChangeNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

# pragma mark -- 设置富文本
- (void) markWord:(NSString*)word inTextStorage:(NSTextStorage*)textStorage{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word
                                                                           options:0
                                                                             error:nil];
    NSArray *matches = [regex matchesInString:_textView.text
                                      options:0
                                        range:NSMakeRange(0,[_textView.text length])];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        [textStorage addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:matchRange];
    }
}

#pragma mark -- 取得imageView的贝塞尔曲线路径
-(UIBezierPath*) translatedBezierPath{
    // 将imageView相对于View的坐标转换为相对于textView的坐标
    CGRect imageRect = [self.textView convertRect:_imageView.frame
                                         fromView:self.view];
    
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:imageRect];
    return newPath;
}

#pragma mark -- 监听字体变化
- (void)preferredContentSizeChanged:(NSNotification *)notification{
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}


@end
