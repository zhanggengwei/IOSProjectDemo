//
//  ObjectModel.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ObjectModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation ObjectModel
{
    
}
@synthesize name=_name;
@dynamic passWord;

//@synthesize的语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动为你加上这两个方法。
//
//
//
//@dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。（当然对于readonly的属性只需提供getter即可）。假如一个属性被声明为@dynamic var，然后你没有提供@setter方法和@getter方法，编译的时候没问题，但是当程序运行到instance.var =someVar，由于缺setter方法会导致程序崩溃；或者当运行到 someVar = var时，由于缺getter方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。

/*
   SEL :方法的selector用于表示运行时方 法的名字。Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL。如下 代码所示：
   IMP: IMP实际上是一个函数指针，指向方法实现的首地址
 
 
 
   方法的调用过程：
 首先检测这个 selector 是不是要忽略。比如 Mac OS X 开发，有了垃圾回收就不理会 retain，release 这些函数。
 检测这个 selector 的 target 是不是 nil，Objc 允许我们对一个 nil 对象执行任何方法不会 Crash，因为运行时会被忽略掉。
 如果上面两步都通过了，那么就开始查找这个类的实现 IMP，先从 cache 里查找，如果找到了就运行对应的函数去执行相应的代码。
 如果 cache 找不到就找类的方法列表中是否有对应的方法。
 如果类的方法列表中找不到就到父类的方法列表中查找，一直找到 NSObject 类为止。
 如果还找不到，就要开始进入动态方法解析了，后面会提到。
 
 我们经常用到关键字 self ，但是 self 是如何获取当前方法的对象呢？
 其实，这也是 Runtime 系统的作用，self 实在方法运行时被动态传入的
 
 */



- (void)printModelAddress
{

   // NSLog(@"%p %p %p ",self,&_name,&_passWord);
    NSLog(@"%ld",sizeof(_name));
    /*
         使用@property声明的属性在编译阶段会自动生成一个以下划线开头的ivar并且绑定setter和getter方法，所以我们可以在类文件中使用_property的方式访问变量。那么根据上面的地址偏移的输出，属性生成的变量实际上是跟在成员变量的后面的，那么这是怎么实现的？
         
     
     */
   
}

- (void)logIvarMethods
{
    unsigned int count = 0;
    Ivar * varList = class_copyIvarList(self.class, &count);
    
    for (int i = 0; i < count; i++)
    {
        Ivar var = varList[i];
        NSLog(@"%s:%@:%s",ivar_getName(var), object_getIvar(self, var),ivar_getTypeEncoding(var));
    }
    free(varList);
    [self runPrivateMethod];
    
    
}

- (void)runPrivateMethod
{
    unsigned int count = 0;
    Method * methodsList = class_copyMethodList(self.class, &count);
    
    for (int i = 0; i < count; i++)
    {
        Method method = methodsList[i];
        
        SEL selector = method_getName(method);
        
        const char * methodName = sel_getName(selector);
        NSLog(@"%s",methodName);
        if(!strcmp(methodName, "private_Methods:"))
        {
//            ((void(*)(id, SEL, id))objc_msgSend)(self,method_getName(method),@"23");
           
             ((void(*)(id, Method, id))method_invoke)(self,method,@"23");
            
        }
       
        //Objective-C运行时objc_msgSend_stret  返回一个结构体的指针
        //Objective-C运行时objc_msgSend(); 返回id 类型的对象指针
        
        
        
        
    }
    free(methodsList);
//    struct objc_category cat;
    
    
    //尝试调用私有方法
    
    
    
}


- (void)private_Methods:(NSString *)a
{
    NSLog(@"私有方法 %@",a);
    
}

@end
