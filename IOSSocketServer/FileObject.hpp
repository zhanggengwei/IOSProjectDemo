//
//  FileObject.hpp
//  
//
//  Created by Donald on 17/4/28.
//
//

#ifndef FileObject_hpp
#define FileObject_hpp

#include <stdio.h>
class FileObject
{
    
public:
    FileObject(char * filePath);
    ~FileObject();
    long long  fileSize(void);
    char * fileAlterUpdateTime(void);
    char * filePath(void);
    bool isDirectonry();
    void description();
    void printDirectonaryList(char * filePath);
    
private:
    char * path;
    char * updateTime;
    long long  size;
    FILE * file;
    bool isDir;
    void checkArgumentsValid();
    //获取一个文件目录的大小
    void DirectonarySize(char * filePath,long long * filesize);
    
   
    
};
#endif /* FileObject_hpp */
