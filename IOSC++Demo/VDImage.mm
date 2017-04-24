//
//  VDImage.cpp
//  IOSProjectDemo
//
//  Created by Donald on 17/4/24.
//  Copyright © 2017年 Susu. All rights reserved.
//

#include "VDImage.hpp"
#include <iostream>
#include <Foundation/Foundation.h>

using namespace std;
VDImage::VDImage(char * fileName)
{
    this->file = fopen(fileName,"rb");
    this->filePath = fileName;
    this->image = [UIImage imageNamed:@"签名"];

}
void VDImage::printFileContent()
{
    if(this->file == NULL)
    {
        cout<<"文件打开失败"<<endl;
        return;
    }
    FILE * newFile = fopen("/Users/donald/Desktop/jpg/123.png","wb");
    
    char content[1024] = {'\0'};
    char c;
    
    size_t size = 0;
    
    while((size=fread(content,1, 1024, file))!=0){   //从源文件中读取数据知道结尾
       
        fwrite(content, 1,size, newFile);
        cout<<content;
        
    }
    fclose(file);
    fclose(newFile);
    
//    while (fgets(content,1024,file))
//    {
//
//        cout<<content<<endl;
//       
//        fprintf(newFile,"%s", content);
//        memset(content, '\0', 1024);
//        
//        
//       // memset(content, '0', 1024);
//    }
//    UIImage
}

void VDImage::ImageRGBAArray()
{
    
    
}

