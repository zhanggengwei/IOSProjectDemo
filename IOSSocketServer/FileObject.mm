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
#include <string.h>
FileObject::FileObject(char * filePath)
{
    
    this->path = filePath;
    this->file = fopen(filePath, "r");
    this->checkArgumentsValid();
    struct stat fileStat;
    if(stat(filePath, &fileStat)!=-1)
    {
        this->updateTime = ctime(&fileStat.st_mtime);
        this->isDir = S_ISDIR(fileStat.st_mode);
        this->size = 0;
        if(this->isDir)
        {
            this->DirectonarySize(this->path,&this->size);
            this->size/=1024;
        }
        else
        {
            this->size = fileStat.st_size/1024;
        }
    }else
    {
        
    }
    
    
}
FileObject::~FileObject()
{
    fclose(this->file);
}
long long FileObject::fileSize(void)
{
    this->checkArgumentsValid();
    return this->size;
    
}
char * FileObject::fileAlterUpdateTime(void)
{
    this->checkArgumentsValid();
    return this->updateTime;
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

void FileObject::description()
{
    printf("file modifytime == %s",this->fileAlterUpdateTime());
    printf("file size == %lld",this->fileSize());
    
}

void FileObject::DirectonarySize(char * filePath,long long * filesize)
{
    return;
    struct stat fileSat;
    if(stat(filePath, &fileSat)!=-1)
    {
        if (S_ISDIR(fileSat.st_mode))
        {
            
            DIR * dir = opendir(filePath);
            dirent * dirent = NULL;
            
            while ((dirent=readdir(dir)))
            {
                char name[1024] = {'\0'};
                strncpy(name, dirent->d_name, dirent->d_namlen);
              
                //char * lastDir = strcat(strcat(filePath, "/"),name);
                if (dirent->d_type == DT_DIR)
                {
                    printf("目录 %s\n",name);
                    
                }else
                {
                    printf("文件 %s\n",name);
                }
            }
            
        }
        else
        {
            * filesize += fileSat.st_size;
            printf("filename == %s",filePath);
            
        }
    }
    
  
}

void  FileObject::printDirectonaryList(char * path)
{
    struct stat  statFile;
    if(stat(path,&statFile)!=-1)
    {
        //目录
        if(S_ISDIR(statFile.st_mode))
        {
            DIR * dir = opendir(path);
            dirent * list = NULL;
            while ((list=readdir(dir)))
            {
                char fileName[] = {'\0'};
                strncpy(fileName,list->d_name,list->d_namlen);
                printf("filename ==%s  %d\n",fileName,1);
//                if(strcmp(fileName, ".")==0||strcmp(fileName, "..")==0)
//                {
//                    continue;
//                }
                
//                if(list->d_type == DT_DIR)
//                {
//                    printf("directonaruy = %s",fileName);
//                    //path = strcat(strcat(path,"/"),fileName);
//                    //printDirectonaryList(path);
//                
//                }else
//                {
//                    printf("name == %s",fileName);
//                }
            }
            
            
        }else
        {
            printf("name == %s",path);
        }
    }
    
}
