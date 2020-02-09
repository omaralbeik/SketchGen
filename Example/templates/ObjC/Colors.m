// Generated using SketchGen

#import "Colors.h"

@implementation Colors
{% for color in colors %}
- (UIColor *){{ color.name|camelcased }} {
    return [[UIColor alloc] initWithRed:{{ color.value.red }}
                                  green:{{ color.value.green }}
                                   blue:{{ color.value.blue }}
                                  alpha:{{ color.value.alpha }}];
}
{% endfor %}
@end
