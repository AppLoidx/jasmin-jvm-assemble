.bytecode 52.0

.source Main.j
.class public Main
.super java/lang/Object

.method public static main([Ljava/lang/String;)V
    .limit stack 2
    .limit locals 2
    getstatic java/lang/System/out Ljava/io/PrintStream;
    ldc "Hello world!"
    invokevirtual java/io/PrintStream.println(Ljava/lang/String;)V
    return
.end method
