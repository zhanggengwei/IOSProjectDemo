//
//  VDImage.hpp
//  IOSProjectDemo
//
//  Created by Donald on 17/4/24.
//  Copyright © 2017年 Susu. All rights reserved.
//

#ifndef VDImage_hpp
#define VDImage_hpp
#include <UIKit/UIKit.h>


#include <stdio.h>
class VDImage
{
public:
    VDImage(char * fileName);
    void printFileContent();
    void ImageRGBAArray();
    char * filePath;
private:
    FILE * file;
    UIImage * image;
    
   
   
    
   
};

#endif /* VDImage_hpp */
