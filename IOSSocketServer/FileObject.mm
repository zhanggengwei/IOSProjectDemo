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
#include <errno.h>
#define MAX_PATH 512
long long print_file_info(char *pathname,long long * size);
void dir_order(char *pathname,long long * size);

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
 
    //DIR  FILE direntn
    long long size = 0;
    dir_order(path,&size);
    printf("size == %lld",size);
    
    
    
}

void dir_order(char *pathname,long long * size)
{
    DIR *dfd;
    char name[MAX_PATH];
    struct dirent *dp;
    if ((dfd = opendir(pathname)) == NULL)
    {
        printf("dir_order: can't open %s\n %s", pathname,strerror(errno));
        return;
    }
    while ((dp = readdir(dfd)) != NULL)
    {
        if (strncmp(dp->d_name, ".", 1) == 0)
            continue; /* 跳过当前目录和上一层目录以及隐藏文件*/
        if (strlen(pathname) + strlen(dp->d_name) + 2 > sizeof(name))
        {
            printf("dir_order: name %s %s too long\n", pathname, dp->d_name);
        } else
        {
            memset(name, 0, sizeof(name));
            sprintf(name, "%s/%s", pathname, dp->d_name);
             *size += print_file_info(name,size);
        }
    }
    closedir(dfd);
    
}
long long print_file_info(char *pathname,long long * size)
{
    struct stat filestat;
    if (stat(pathname, &filestat) == -1)
    {
        printf("cannot access the file %s", pathname);
        return 0;
        
    }
    if ((filestat.st_mode & S_IFMT) == S_IFDIR)
    {
        dir_order(pathname,size);//
    }
    printf("%s %lld\n", pathname, filestat.st_size);
    return filestat.st_size;
    
    
}
