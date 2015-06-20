/**
 The MIT License (MIT)
 
 Copyright (c) 2015 DreamCao
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "DMSearchFile.h"

#if DEBUG
#define DMSearchDebug(...)   NSLog(__VA_ARGS__)
#else
#define DMSearchDebug(...)
#endif


@implementation DMSearchFile


+ (NSArray *)searchFileWithPath:(NSString *)searchPath ext:(NSString *)ext delegate:(id<DMSearchFileDelegate>)delegate
{
    return [self searchFileWithPath:searchPath ext:ext delegate:delegate filterBlock:nil];
}

+ (NSArray *)searchFileWithPath:(NSString *)searchPath ext:(NSString *)ext filterBlock:(DMSearchFileFilterBlock)filterBlock
{
    return [self searchFileWithPath:searchPath ext:ext delegate:nil filterBlock:filterBlock];
}

+ (NSArray *)searchFileWithPath:(NSString *)searchPath ext:(NSString *)ext delegate:(id<DMSearchFileDelegate>)delegate filterBlock:(DMSearchFileFilterBlock)filterBlock
{
    if (nil == searchPath)
    {
        return nil;
    }
    
    NSError *error = nil;
    NSMutableArray *array = [NSMutableArray array];
    NSArray *dirList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:searchPath error:&error];
    NSString *extTmp = nil;
    
    if (ext.length <= 0)
    {
        extTmp = @"*";
    }
    else
    {
        extTmp = ext;
    }
    
    BOOL suffixFlag = NO;
    for (NSString *filename in dirList)
    {
        if ([extTmp isEqualToString:@"*"])
        {
            suffixFlag = YES;
        }
        else
        {
            suffixFlag = [filename hasSuffix:extTmp];
        }
        
        if (suffixFlag)
        {
            if (nil != delegate)
            {
                if ([delegate respondsToSelector:@selector(filterFile:)] && ![delegate filterFile:filename])
                {
                    [array addObject:filename];
                }
            }
            else if (NULL != filterBlock)
            {
                if (!filterBlock(filename))
                {
                    [array addObject:filename];
                }
            }
            else
            {
                [array addObject:filename];
            }
        }
    }
    
    return array;
}

@end
