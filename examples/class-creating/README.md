Source java code:
```java
public class ClassCreating {
	public static void main(String ... args){
		String s = new String();
		ClassCreating cc = new ClassCreating();
		cc.sayHello();
	}

	public void sayHello(){
		System.out.println("Hello, User!");
	}
}
```

His Jasmin code:
```jasmin
; ClassCreating.j

.bytecode 52.0
.source ClassCreating.java
.class public ClassCreating
.super java/lang/Object

.method public <init>()V
	.limit stack 1
	.limit locals 1
	.line 1
	0: aload_0
	1: invokespecial java/lang/Object/<init>()V
	4: return
.end method

.method public static main([Ljava/lang/String;)V
	; Flag ACC_VARARGS set, see JVM spec
	.limit stack 2
	.limit locals 3
	.line 3
	0: new java/lang/String
	3: dup
	4: invokespecial java/lang/String/<init>()V
	7: astore_1
	.line 4
	8: new ClassCreating
	11: dup
	12: invokespecial ClassCreating/<init>()V
	15: astore_2
	.line 5
	16: aload_2
	17: invokevirtual ClassCreating/sayHello()V
	.line 6
	20: return
.end method

.method public sayHello()V
	.limit stack 2
	.limit locals 1
	.line 9
	0: getstatic java/lang/System/out Ljava/io/PrintStream;
	3: ldc "Hello, User!"
	5: invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	.line 10
	8: return

.end method
```

His disassembled bytecode:
```bytecode
Classfile /C:/java/util/classfileanalyzer-bin-0-7-0/classfileanalyzer/ClassCreating.class
  Last modified 10.12.2019; size 556 bytes
  MD5 checksum fa3f94e2bb9c264e2e049256c19a7213
  Compiled from "ClassCreating.java"
public class ClassCreating
  minor version: 0
  major version: 52
  flags: ACC_PUBLIC, ACC_SUPER
Constant pool:
   #1 = NameAndType        #31:#34        // out:Ljava/io/PrintStream;
   #2 = Utf8               ([Ljava/lang/String;)V
   #3 = Utf8               java/lang/Object
   #4 = Utf8               <init>
   #5 = Class              #3             // java/lang/Object
   #6 = NameAndType        #4:#11         // "<init>":()V
   #7 = Class              #22            // java/io/PrintStream
   #8 = Utf8               sayHello
   #9 = Class              #25            // java/lang/String
  #10 = Utf8               ClassCreating.java
  #11 = Utf8               ()V
  #12 = Class              #29            // java/lang/System
  #13 = Utf8               Code
  #14 = Methodref          #35.#24        // ClassCreating.sayHello:()V
  #15 = Utf8               main
  #16 = Fieldref           #12.#1         // java/lang/System.out:Ljava/io/PrintStream;
  #17 = Utf8               Hello, User!
  #18 = Methodref          #9.#6          // java/lang/String."<init>":()V
  #19 = Utf8               SourceFile
  #20 = Utf8               ClassCreating
  #21 = NameAndType        #26:#32        // println:(Ljava/lang/String;)V
  #22 = Utf8               java/io/PrintStream
  #23 = String             #17            // Hello, User!
  #24 = NameAndType        #8:#11         // sayHello:()V
  #25 = Utf8               java/lang/String
  #26 = Utf8               println
  #27 = Methodref          #5.#6          // java/lang/Object."<init>":()V
  #28 = Utf8               LineNumberTable
  #29 = Utf8               java/lang/System
  #30 = Methodref          #7.#21         // java/io/PrintStream.println:(Ljava/lang/String;)V
  #31 = Utf8               out
  #32 = Utf8               (Ljava/lang/String;)V
  #33 = Methodref          #35.#6         // ClassCreating."<init>":()V
  #34 = Utf8               Ljava/io/PrintStream;
  #35 = Class              #20            // ClassCreating
{
  public ClassCreating();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=1, locals=1, args_size=1
         0: aload_0
         1: invokespecial #27                 // Method java/lang/Object."<init>":()V
         4: return
      LineNumberTable:
        line 1: 0

  public static void main(java.lang.String[]);
    descriptor: ([Ljava/lang/String;)V
    flags: ACC_PUBLIC, ACC_STATIC
    Code:
      stack=2, locals=3, args_size=1
         0: new           #9                  // class java/lang/String
         3: dup
         4: invokespecial #18                 // Method java/lang/String."<init>":()V
         7: astore_1
         8: new           #35                 // class ClassCreating
        11: dup
        12: invokespecial #33                 // Method "<init>":()V
        15: astore_2
        16: aload_2
        17: invokevirtual #14                 // Method sayHello:()V
        20: return
      LineNumberTable:
        line 3: 0
        line 4: 8
        line 5: 16
        line 6: 20

  public void sayHello();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=2, locals=1, args_size=1
         0: getstatic     #16                 // Field java/lang/System.out:Ljava/io/PrintStream;
         3: ldc           #23                 // String Hello, User!
         5: invokevirtual #30                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
         8: return
      LineNumberTable:
        line 9: 0
        line 10: 8
}
SourceFile: "ClassCreating.java"


```
