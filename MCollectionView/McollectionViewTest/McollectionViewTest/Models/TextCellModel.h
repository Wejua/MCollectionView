//
//  TextCellModel.h
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#include <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CellType1,
    CellType2,
} CellType;

NS_ASSUME_NONNULL_BEGIN

@interface TextCellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CellType cellType;
@end

NS_ASSUME_NONNULL_END
