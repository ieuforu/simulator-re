// 在模拟器内运行：用 ObjC 运行时导出类和方法，不依赖磁盘上的二进制格式。
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <dlfcn.h>

static void dumpMethods(Class c, char prefix) {
    unsigned n = 0;
    Method *ms = class_copyMethodList(c, &n);
    NSMutableArray *rows = [NSMutableArray array];
    for (unsigned i = 0; i < n; i++)
        [rows addObject:[NSString stringWithFormat:@"  %c %s  <%s>", prefix, sel_getName(method_getName(ms[i])), method_getTypeEncoding(ms[i])]];
    free(ms);
    for (NSString *r in [rows sortedArrayUsingSelector:@selector(compare:)]) puts(r.UTF8String);
}

static void dumpClass(const char *name) {
    Class c = objc_getClass(name);
    if (!c) { printf("缺失: %s\n", name); return; }
    printf("@%s : %s  (%s)\n", name, class_getName(class_getSuperclass(c)), class_getImageName(c));
    unsigned n = 0;
    objc_property_t *ps = class_copyPropertyList(c, &n);
    for (unsigned i = 0; i < n; i++) printf("  . %s\n", property_getName(ps[i]));
    free(ps);
    dumpMethods(object_getClass(c), '+');
    dumpMethods(c, '-');
}

int main(int argc, char **argv) {
    @autoreleasepool {
        if (argc < 3) { puts("probe <framework路径> list <正则> | class <类名...>"); return 2; }
        if (!dlopen(argv[1], RTLD_NOW)) { printf("dlopen 失败: %s\n", dlerror()); return 1; }
        if (!strcmp(argv[2], "list")) {
            NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:@(argv[3]) options:0 error:nil];
            unsigned n = 0;
            Class *cs = objc_copyClassList(&n);
            NSMutableArray *names = [NSMutableArray array];
            for (unsigned i = 0; i < n; i++) {
                NSString *s = @(class_getName(cs[i]));
                if ([re numberOfMatchesInString:s options:0 range:NSMakeRange(0, s.length)])
                    [names addObject:[NSString stringWithFormat:@"%@  [%@]", s, @(class_getImageName(cs[i]) ?: "?").lastPathComponent]];
            }
            for (NSString *s in [names sortedArrayUsingSelector:@selector(compare:)]) puts(s.UTF8String);
            printf("共 %lu\n", (unsigned long)names.count);
        } else {
            for (int i = 3; i < argc; i++) dumpClass(argv[i]);
        }
    }
    return 0;
}
