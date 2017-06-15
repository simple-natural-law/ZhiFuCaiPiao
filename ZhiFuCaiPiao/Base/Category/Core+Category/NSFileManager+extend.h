//
//  NSFileManager+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (extend)

///获取程序的Home目录路径
+(NSString *)GetHomeDirectoryPath;

///获取document目录路径
+(NSString *)GetDocumentPath;

///获取Cache目录路径
+(NSString *)GetCachePath;

///获取Library目录路径
+(NSString *)GetLibraryPath;

///获取Tmp目录路径
+(NSString *)GetTmpPath;

///创建目录文件夹
+(NSString *)CreateList:(NSString *)List ListName:(NSString *)Name;

///写入NsArray文件
+(BOOL)WriteFileArray:(NSArray *)ArrarObject SpecifiedFile:(NSString *)path;

///写入NSDictionary文件
+(BOOL)WriteFileDictionary:(NSMutableDictionary *)DictionaryObject SpecifiedFile:(NSString *)path;

///是否存在该文件
+(BOOL)IsFileExists:(NSString *)filepath;

///删除指定文件
+(void)DeleteFile:(NSString*)filepath;

///删除 document/dir 目录下 所有文件
+(void)deleteAllForDocumentsDir:(NSString*)dir;

///获取目录列表里所有的文件名
+(NSArray *)GetSubpathsAtPath:(NSString *)path;


//直接取文件数据
+(NSData*)GetDataForResource:(NSString*)name inDir:(NSString*) type;
+(NSData*)GetDataForDocuments:(NSString *)name inDir:(NSString*)dir;
+(NSData*)GetDataForPath:(NSString*)path;

//获取文件路径
+(NSString*)GetPathForCaches:(NSString *)filename;
+(NSString*)GetPathForCaches:(NSString *)filename inDir:(NSString*)dir;

+(NSString*)GetPathForDocuments:(NSString*)filename;
+(NSString*)GetPathForDocuments:(NSString *)filename inDir:(NSString*)dir;

+(NSString*)GetPathForResource:(NSString *)name;
+(NSString*)GetPathForResource:(NSString *)name inDir:(NSString*)dir;


@end
