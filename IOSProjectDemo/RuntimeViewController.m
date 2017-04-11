//
//  RuntimeViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "RuntimeViewController.h"
#import "ObjectModel.h"
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ObjectModel * model = [ObjectModel new];
    
    [model printModelAddress] ;
    
    /*
     NSMethodSignature顾名思义应该就是“方法签名”，类似于C++中的编译器时的函数签名。苹果官方定义该类为对方法的参数、返回类似进行封装，协同NSInvocation实现消息转发。通过消息转发实现类似C++中的多重继承。
     iOS中的SEL，它的作用和C、C++中的函数指针很相似，通过performSelector:withObject:函数可以直接调用这个消息。但是perform相关的这些函数，有一个局限性，其参数数量不能超过2个，否则要做很麻烦的处理，与之相对，NSInvocation也是一种消息调用的方法，并且它的参数没有限制。这两种直接调用对象消息的方法，在IOS4.0之后，大多被block结构所取代，只有在很老的兼容性系统中才会使用。
     
     1.每个实例对象的类都是类对象，每个类对象的类都是元类对象，每个元类对象的类都是根元类（root meta class的isa指向自身）
     2.类对象的父类最终继承自根类对象NSObject，NSObject的父类为nil
     3.元类对象（包括根元类）的父类最终继承自根类对象NSObject
     objc_object是表示一个类的实例的结构体，它的定义如下(objc/objc.h)：
     
     1
     2
     3
     4
     5
     struct objc_object {
     Class isa  OBJC_ISA_AVAILABILITY;
     };
     
     typedef struct objc_object *id;
     可以看到，这个结构体只有一个字体，即指向其类的isa指针。这样，当我们向一个Objective-C对象发送消息时，运行时库会根据实例对象的isa指针找到这个实例对象所属的类。Runtime库会在类的方法列表及父类的方法列表中去寻找与消息对应的selector指向的方法。找到后即运行这个方法。
     
     当创建一个特定类的实例对象时，分配的内存包含一个objc_object数据结构，然后是类的实例变量的数据。NSObject类的alloc和allocWithZone:方法使用函数class_createInstance来创建objc_object数据结构。
     
     另外还有我们常见的id，它是一个objc_object结构类型的指针。它的存在可以让我们实现类似于C++中泛型的一些操作。该类型的对象可以转换为任何一种对象，有点类似于C语言中void *指针类型的作用。
     */
    
    [self test];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
     cache：用于缓存最近使用的方法。一个接收者对象接收到一个消息时，它会根据isa指针去查找能够响应这个消息的对象。在实际使用中，这个对象只有一部分方法是常用的，很多方法其实很少用或者根本用不上。这种情况下，如果每次消息来时，我们都是methodLists中遍历一遍，性能势必很差。这时，cache就派上用场了。在我们每次调用过一个方法后，这个方法就会被缓存到cache列表中，下次调用的时候runtime就会优先去cache中查找，如果cache没有，才去methodLists中查找方法。这样，对于那些经常用到的方法的调用，但提高了调用的效率。
   version：
      我们可以使用这个字段来提供类的版本信息。这对于对象的序列化非常有用，它可是让我们识别出不同类定义版本中实例变量布局的改变。
 */

- (void)test {
    int a = 1;
    int b = 2;
    int c = 3;
    SEL myMethod = @selector(myLog:param:parm:);
    SEL myMethod2 = @selector(myLog);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量要和调用的一致。
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:myMethod];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    //    2.FirstViewController *view = self;
    //    2.[invocation setArgument:&view atIndex:0];
    //    2.[invocation setArgument:&myMethod2 atIndex:1];
    // 设置target
    //    1.[invocation setTarget:self];
    // 设置selector
    [invocation setSelector:myMethod];
    
    
    // 注意：1、这里设置参数的Index 需要从2开始，因为前两个被selector和target占用。
    [invocation setArgument:&a atIndex:2];
    [invocation setArgument:&b atIndex:3];
    [invocation setArgument:&c atIndex:4];
    //    [invocation retainArguments];
    // 我们将c的值设置为返回值
    [invocation setReturnValue:&c];
    int d;
    // 取这个返回值
    [invocation getReturnValue:&d];
    NSLog(@"d:%d", d);
    
    NSUInteger argCount = [sig numberOfArguments];
    NSLog(@"argCount:%ld", argCount);
    
    for (NSInteger i=0; i<argCount; i++) {
        NSLog(@"%s", [sig getArgumentTypeAtIndex:i]);
    }
    NSLog(@"returnType:%s ,returnLen:%ld", [sig methodReturnType], [sig methodReturnLength]);
    NSLog(@"signature:%@" , sig);
    
    // 消息调用
    //    2.
    [invocation invokeWithTarget:self];
}

//注意：代码中用1.标识的为第一种用法，通过setTarget和setSelector来设置NSInvocation的参数，而用2.标识的是另一种用法，通过setArgument atIndex:来设置参数。看个人的喜好。。。

- (int)myLog:(int)a param:(int)b parm:(int)c
{
    NSLog(@"MyLog:%d,%d,%d", a, b, c);
    return a+b+c;
}

- (void)myLog
{
    NSLog(@"你好,South China University of Technology");
}
/*
 转发
 当动态方法解析不做处理返回 NO 时，则会触发消息转发机制。这时 forwardInvocation: 方法会被执行，我们可以重写这个方法来自定义我们的转发逻辑：
 
 - (void)forwardInvocation:(NSInvocation *)anInvocation
   {
    if ([someOtherObject respondsToSelector:
    [anInvocation selector]])
    [anInvocation invokeWithTarget:someOtherObject];
    else
   [super forwardInvocation:anInvocation];
   }
 唯一参数是个 NSInvocation 类型的对象，该对象封装了原始的消息和消息的参数。我们可以实现 forwardInvocation: 方法来对不能处理的消息做一些处理。也可以将消息转发给其他对象处理，而不抛出错误。
 
 注意：参数 anInvocation 是从哪来的？
 在 forwardInvocation: 消息发送前，Runtime 系统会向对象发送methodSignatureForSelector: 消息，并取到返回的方法签名用于生成 NSInvocation 对象。所以重写 forwardInvocation: 的同时也要重写 methodSignatureForSelector: 方法，否则会抛异常。
 
 当一个对象由于没有相应的方法实现而无法相应某消息时，运行时系统将通过 forwardInvocation: 消息通知该对象。每个对象都继承了 forwardInvocation: 方法。但是， NSObject 中的方法实现只是简单的调用了 doesNotRecognizeSelector:。通过实现自己的 forwardInvocation: 方法，我们可以将消息转发给其他对象。
 
 forwardInvocation: 方法就是一个不能识别消息的分发中心，将这些不能识别的消息转发给不同的接收对象，或者转发给同一个对象，再或者将消息翻译成另外的消息，亦或者简单的“吃掉”某些消息，因此没有响应也不会报错。这一切都取决于方法的具体实现。
 
 注意：
 forwardInvocation:方法只有在消息接收对象中无法正常响应消息时才会被调用。所以，如果我们向往一个对象将一个消息转发给其他对象时，要确保这个对象不能有该消息的所对应的方法。否则，forwardInvocation:将不可能被调用。
 
 
 */
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
//{
//    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
//    if (!signature) {
//        signature = [target methodSignatureForSelector:selector];
//    }
//    return signature;
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(foo)) {
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "V@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//    if (!signature) {
//        for (id target in self.allDelegates) {
//            if ((signature = [target methodSignatureForSelector:aSelector])) {
//                break;
//            }
//        }
//    }
//    return signature;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    for (id target in self.allDelegates) {
//        if ([target respondsToSelector:anInvocation.selector]) {
//            [anInvocation invokeWithTarget:target];
//        }
//    }
//}
//
//- (BOOL)respondsToSelector:(SEL)aSelector
//{
//    if ([super respondsToSelector:aSelector]) {
//        return YES;
//    }
//
//    for (id target in self.allDelegates) {
//        if ([target respondsToSelector:aSelector]) {
//            return YES;
//        }
//    }
//    return NO;
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
