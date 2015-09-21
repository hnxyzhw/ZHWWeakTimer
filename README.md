# ZHWWeakTimer
#使用系统的NSTimer会导致内存泄露,在dealloc方法中是不会被释放掉了的.
#自定义了一个定时器,解决内存泄露问题.
