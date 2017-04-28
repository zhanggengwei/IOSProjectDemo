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
    char * fileSize(void);
    char * fileAlterUpdateTime(void);
    char * filePath(void);
private:
    char * path;
    long long  updateTime;
    long long  size;
    FILE * file;
    
    void checkArgumentsValid();
    
};
#endif /* FileObject_hpp */
