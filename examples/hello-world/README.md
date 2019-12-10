# Hello World - Jasmin

```jasmin
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
```

His disassembled bytecode:
```
Classfile /C:/Users/Arthur/Desktop/jasmin/jasmin-jvm-assemble/hello-world/Main.class
  Last modified 31.10.2019; size 309 bytes
  MD5 checksum d2c045e00bda7634503821e4384e8b2b
  Compiled from "Main.j"
public class Main
  minor version: 0
  major version: 52
  flags: ACC_PUBLIC, ACC_SUPER
Constant pool:
   #1 = Utf8               Main.j
   #2 = Class              #17            // Main
   #3 = NameAndType        #21:#23        // out:Ljava/io/PrintStream;
   #4 = Utf8               ([Ljava/lang/String;)V
   #5 = Utf8               java/lang/Object
   #6 = Class              #5             // java/lang/Object
   #7 = Class              #16            // java/io/PrintStream
   #8 = Utf8               Hello world!
   #9 = Class              #19            // java/lang/System
  #10 = Utf8               Code
  #11 = Utf8               main
  #12 = Fieldref           #9.#3          // java/lang/System.out:Ljava/io/PrintStream;
  #13 = String             #8             // Hello world!
  #14 = Utf8               SourceFile
  #15 = NameAndType        #18:#22        // println:(Ljava/lang/String;)V
  #16 = Utf8               java/io/PrintStream
  #17 = Utf8               Main
  #18 = Utf8               println
  #19 = Utf8               java/lang/System
  #20 = Methodref          #7.#15         // java/io/PrintStream.println:(Ljava/lang/String;)V
  #21 = Utf8               out
  #22 = Utf8               (Ljava/lang/String;)V
  #23 = Utf8               Ljava/io/PrintStream;
{
  public static void main(java.lang.String[]);
    descriptor: ([Ljava/lang/String;)V
    flags: ACC_PUBLIC, ACC_STATIC
    Code:
      stack=2, locals=2, args_size=1
         0: getstatic     #12                 // Field java/lang/System.out:Ljava/io/PrintStream;
         3: ldc           #13                 // String Hello world!
         5: invokevirtual #20                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
         8: return
}
SourceFile: "Main.j"
```


And this is his binary (hexadimical) bytecode:

```hexademical
cafe babe 0000 0036 001d 0a00 0600 0f09
0010 0011 0800 120a 0013 0014 0700 1507
0016 0100 063c 696e 6974 3e01 0003 2829
5601 0004 436f 6465 0100 0f4c 696e 654e
756d 6265 7254 6162 6c65 0100 046d 6169
6e01 0016 285b 4c6a 6176 612f 6c61 6e67
2f53 7472 696e 673b 2956 0100 0a53 6f75
7263 6546 696c 6501 000f 4865 6c6c 6f57
6f72 6c64 2e6a 6176 610c 0007 0008 0700
170c 0018 0019 0100 0b48 656c 6c6f 2057
6f72 6c64 0700 1a0c 001b 001c 0100 0a48
656c 6c6f 576f 726c 6401 0010 6a61 7661
2f6c 616e 672f 4f62 6a65 6374 0100 106a
6176 612f 6c61 6e67 2f53 7973 7465 6d01
0003 6f75 7401 0015 4c6a 6176 612f 696f
2f50 7269 6e74 5374 7265 616d 3b01 0013
6a61 7661 2f69 6f2f 5072 696e 7453 7472
6561 6d01 0005 7072 696e 7401 0015 284c
6a61 7661 2f6c 616e 672f 5374 7269 6e67
3b29 5600 2100 0500 0600 0000 0000 0200
0100 0700 0800 0100 0900 0000 1d00 0100
0100 0000 052a b700 01b1 0000 0001 000a
0000 0006 0001 0000 0001 0089 000b 000c
0001 0009 0000 0025 0002 0001 0000 0009
b200 0212 03b6 0004 b100 0000 0100 0a00
0000 0a00 0200 0000 0300 0800 0400 0100
0d00 0000 0200 0e
```

