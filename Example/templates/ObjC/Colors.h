// Generated using SketchGen

#import <UIKit/UIKit.h>

#ifndef Colors_h
#define Colors_h

NS_ASSUME_NONNULL_BEGIN

@interface Colors : NSObject
{% for color in colors %}
/// {{ color.name|readable|capitalize }} ({{ color.value.hex }})
@property (nonatomic, strong, readonly) UIColor *{{ color.name|camelcased }};
{% endfor %}
@end

NS_ASSUME_NONNULL_END

#endif
