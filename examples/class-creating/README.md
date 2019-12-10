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
