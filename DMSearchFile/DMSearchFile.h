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

#import <Foundation/Foundation.h>


/**
 *  过滤方法
 *
 *  @param filename 文件名
 *
 *  @return YES - 过滤， NO - 不过滤
 */
typedef BOOL(^DMSearchFileFilterBlock)(NSString *filename);

/**
 *  搜索文件代理
 */
@protocol DMSearchFileDelegate <NSObject>

@optional
/**
 *  过滤方法
 *
 *  @param path 文件路径
 *
 *  @return YES - 过滤, NO - 不过滤
 */
- (BOOL)filterFile:(NSString *)filename;

@end


#pragma mark - DMSearchFile
/**
 *  搜索文件
 */
@interface DMSearchFile : NSObject

/**
 *  搜索文件
 *
 *  @param searchPath 搜索路径
 *  @param ext        后缀名
 *  @param delegate   代理
 *
 *  @return 搜索到的文件数组
 */
+ (NSArray *)searchFileWithPath:(NSString *)searchPath ext:(NSString *)ext delegate:(id<DMSearchFileDelegate>)delegate;
+ (NSArray *)searchFileWithPath:(NSString *)searchPath ext:(NSString *)ext filterBlock:(DMSearchFileFilterBlock)filterBlock;

@end
