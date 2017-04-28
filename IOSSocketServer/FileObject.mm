//
//  FileObject.cpp
//  
//
//  Created by Donald on 17/4/28.
//
//

#include "FileObject.hpp"

FileObject::FileObject(char * filePath)
{
    
    this->path = filePath;
    this->file = fopen(filePath, "r");
    this->checkArgumentsValid();
}
FileObject::~FileObject()
{
    fclose(this->file);
}
char * FileObject::fileSize(void)
{
    this->checkArgumentsValid();
    return NULL;
    
}
char * FileObject::fileAlterUpdateTime(void)
{
    this->checkArgumentsValid();
    return NULL;
}
char * FileObject::filePath(void)
{
    this->checkArgumentsValid();
    return this->path;
}
void FileObject::checkArgumentsValid()
{
    if(this->path==NULL)
    {
        printf("file path is NULL");
        return;
    }
    if(this->file==NULL)
    {
        printf("open file faild");
        return;
    }
    
}
