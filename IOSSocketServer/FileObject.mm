//
//  FileObject.cpp
//  
//
//  Created by Donald on 17/4/28.
//
//

#include "FileObject.hpp"
#include <sys/stat.h>
#include <time.h>
#include <dirent.h>
#include <unistd.h>
FileObject::FileObject(char * filePath)
{
    
    this->path = filePath;
    this->file = fopen(filePath, "r");
    this->checkArgumentsValid();
    struct stat fileStat;
    if(stat(filePath, &fileStat)!=-1)
    {
        this->updateTime = fileStat.st_mtime;
        this->size = fileStat.st_size;
        printf("time == %s",ctime(&fileStat.st_mtime));
        if(S_ISDIR(fileStat.st_mode))
        {
            DIR * dir = opendir(filePath);
            dirent * list = NULL;
            
            while((list = readdir(dir)))
            {
                printf("%s\n",list->d_name);
            }
            
            
            
            
        }
        
    }
    
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
