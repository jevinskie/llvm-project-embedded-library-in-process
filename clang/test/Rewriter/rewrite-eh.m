// RUN: %clang_cc1 -rewrite-objc -fobjc-runtime=macosx-fragile-10.5  -fobjc-exceptions -o - %s

@interface NSException
@end

@interface Foo
@end

@implementation Foo
- (void)bar {
    @try {
    } @catch (NSException *e) {
    }
    @catch (Foo *f) {
    }
    @catch (...) {
    }
}
@end
