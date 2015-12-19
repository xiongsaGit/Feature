
#define singleton_interface(class)  +(class*)shared##class

#define singleton_implement(class) \
\
static class *singleInstance;\
+(id)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        singleInstance = [super allocWithZone:zone];\
    });\
    return  singleInstance;\
}\
\
+(class*)shared##class\
{\
    if (singleInstance == nil) {\
        singleInstance = [[self alloc]init];\
    }\
    return singleInstance;\
}