

# JVM Introduction

<h2 align=center> Разбираем Hello World из байт-кода <h2>
    <hr>



<h5 align=center>Kupriyanov Arthur</h5>







Очень полезной книгой для этого стала официальная спецификация JVM - The Java Virtual Machine Specification на сайте [oracle](https://docs.oracle.com/javase/specs/jvms/se8/jvms8.pdf)



Для начала создадим простенькую программу:

```java
    public class Main {
        public static void main(String ... args) {
            System.out.println("Hello World");
        }
    }

```



Скомпилируем её командой `javac Main.java` и собственно сделаем дизассемблинг 

```
    javap -c -v Main
```



*Main.class*

```
Classfile /C:/Users/Arthur/playground/java/jvm/Main.class
  Last modified 26.10.2019; size 413 bytes
  MD5 checksum 6449121a3bb611fee394e4f322401ee1
  Compiled from "Main.java"
public class Main
  minor version: 0
  major version: 52
  flags: ACC_PUBLIC, ACC_SUPER
Constant pool:
   #1 = Methodref          #6.#15         // java/lang/Object."<init>":()V
   #2 = Fieldref           #16.#17        // java/lang/System.out:Ljava/io/PrintStream;
   #3 = String             #18            // Hello World
   #4 = Methodref          #19.#20 // java/io/PrintStream.println:(Ljava/lang/String;)V
   #5 = Class              #21            // Main
   #6 = Class              #22            // java/lang/Object
   #7 = Utf8               <init>
   #8 = Utf8               ()V
   #9 = Utf8               Code
  #10 = Utf8               LineNumberTable
  #11 = Utf8               main
  #12 = Utf8               ([Ljava/lang/String;)V
  #13 = Utf8               SourceFile
  #14 = Utf8               Main.java
  #15 = NameAndType        #7:#8          // "<init>":()V
  #16 = Class              #23            // java/lang/System
  #17 = NameAndType        #24:#25        // out:Ljava/io/PrintStream;
  #18 = Utf8               Hello World
  #19 = Class              #26            // java/io/PrintStream
  #20 = NameAndType        #27:#28        // println:(Ljava/lang/String;)V
  #21 = Utf8               Main
  #22 = Utf8               java/lang/Object
  #23 = Utf8               java/lang/System
  #24 = Utf8               out
  #25 = Utf8               Ljava/io/PrintStream;
  #26 = Utf8               java/io/PrintStream
  #27 = Utf8               println
  #28 = Utf8               (Ljava/lang/String;)V
{
  public Main();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=1, locals=1, args_size=1
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: return
      LineNumberTable:
        line 1: 0

  public static void main(java.lang.String...);
    descriptor: ([Ljava/lang/String;)V
    flags: ACC_PUBLIC, ACC_STATIC, ACC_VARARGS
    Code:
      stack=2, locals=1, args_size=1
         0: getstatic     #2        // Field java/lang/System.out:Ljava/io/PrintStream;
         3: ldc           #3        // String Hello World
         5: invokevirtual #4// Method java/io/PrintStream.println:(Ljava/lang/String;)V
         8: return
      LineNumberTable:
        line 4: 0
        line 5: 8
}
SourceFile: "Main.java"

```



Это просто представление байт-кода, которое человеку видеть легче, чем оригинальный байт-код, но сам он выглядит иначе:

```
    cafe babe 0000 0034 001d 0a00 0600 0f09
    0010 0011 0800 120a 0013 0014 0700 1507
    0016 0100 063c 696e 6974 3e01 0003 2829
    5601 0004 436f 6465 0100 0f4c 696e 654e
    756d 6265 7254 6162 6c65 0100 046d 6169
    6e01 0016 285b 4c6a 6176 612f 6c61 6e67
    2f53 7472 696e 673b 2956 0100 0a53 6f75
    7263 6546 696c 6501 0009 4d61 696e 2e6a
    6176 610c 0007 0008 0700 170c 0018 0019
    0100 0b48 656c 6c6f 2057 6f72 6c64 0700
    1a0c 001b 001c 0100 044d 6169 6e01 0010
    6a61 7661 2f6c 616e 672f 4f62 6a65 6374
    0100 106a 6176 612f 6c61 6e67 2f53 7973
    7465 6d01 0003 6f75 7401 0015 4c6a 6176
    612f 696f 2f50 7269 6e74 5374 7265 616d
    3b01 0013 6a61 7661 2f69 6f2f 5072 696e
    7453 7472 6561 6d01 0007 7072 696e 746c
    6e01 0015 284c 6a61 7661 2f6c 616e 672f
    5374 7269 6e67 3b29 5600 2100 0500 0600
    0000 0000 0200 0100 0700 0800 0100 0900
    0000 1d00 0100 0100 0000 052a b700 01b1
    0000 0001 000a 0000 0006 0001 0000 0001
    0089 000b 000c 0001 0009 0000 0025 0002
    0001 0000 0009 b200 0212 03b6 0004 b100
    0000 0100 0a00 0000 0a00 0200 0000 0400
    0800 0500 0100 0d00 0000 0200 0e
```



С этим кодом мы и будем работать.

Но для начала нам нужно его форматировать, чтобы не путаться что где находится, а байт-код, на самом деле, имеет вполне жесткую структуру:

```
    ClassFile {
        u4             magic;
        u2             minor_version;
        u2             major_version;
        u2             constant_pool_count;
        cp_info        constant_pool[constant_pool_count-1];
        u2             access_flags;
        u2             this_class;
        u2             super_class;
        u2             interfaces_count;
        u2             interfaces[interfaces_count];
        u2             fields_count;
        field_info     fields[fields_count];
        u2             methods_count;
        method_info    methods[methods_count];
        u2             attributes_count;
        attribute_info attributes[attributes_count];
    }
```

Её вы можете найти в спецификации JVM [Chapter 4.1 The ClassFile Structure](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.1)



Тут все просто - слева указана размерность в байтах, а справа описание.

Разбирать байт-код мы будем в hexadecimal, где каждая цифра занимает 4 бита, а следовательно, на два байта - 4 цифры и на четыре байта - 8 цифр.



**magic**

magic - это значение, которое идентифицирует формат нашего класса. Он равен `0xCAFEBABE`, который имеет свою [историю создания](https://en.wikipedia.org/wiki/Java_class_file#Magic_Number).



**minor_version, major_version**

Это версии вашего `class` файла. Если мы назовем `major_version` M и `minor_version` m, то получаем версию нашего `class` файла как `M.m`

Сейчас я сразу буду приводить примеры из примера "Hello World", чтобы посмотреть как они используются:

```
    cafe babe -- magic
    0000 -- minor_version
    0034 -- major_version
```

Его же мы можем видеть в дизассемблированном коде, но уже в десятичной системе счисления:

```
    ...
    public class Main
      minor version: 0
      major version: 52
      flags: ACC_PUBLIC, ...
```



**constant_pool_count**

Здесь указывается количество переменных в пуле констант. При этом, если вы решили писать код на чистом байт-коде, то вам обязательно нужно следить за его значением, так как если вы укажете не то значение, то вся программа полетит к чертям (проверено!).

Также следует не забывать, что вы должны писать туда `количество_переменных_в_пуле + 1`



Итого, получаем:

```
    cafe babe 	-- magic
    0000 0034 	-- version
    001d 		-- constant_pool_count
```



**constant_pool[]**

Каждый тип переменной в пуле констант имеет свою структуру:

```
    cp_info {
     u1 tag;
     u1 info[];
    }
```



Здесь все нужно делать последовательно. Сначала считываем `tag` , чтобы узнать тип переменной и по типу этой переменной смотрим какую структуру имеет последующее его значение `info[]`

Таблица с тэгами можно найти в спецификации [Table 4.3 Constant pool tags](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4-140)

Собственно, вот табличка:

| Constant Type                 | Value |
| ----------------------------- | ----- |
| `CONSTANT_Class`              | 7     |
| `CONSTANT_Fieldref`           | 9     |
| `CONSTANT_Methodref`          | 10    |
| `CONSTANT_InterfaceMethodref` | 11    |
| `CONSTANT_String`             | 8     |
| `CONSTANT_Integer`            | 3     |
| `CONSTANT_Float`              | 4     |
| `CONSTANT_Long`               | 5     |
| `CONSTANT_Double`             | 6     |
| `CONSTANT_NameAndType`        | 12    |
| `CONSTANT_Utf8`               | 1     |
| `CONSTANT_MethodHandle`       | 15    |
| `CONSTANT_MethodType`         | 16    |
| `CONSTANT_InvokeDynamic`      | 18    |



Как ранее уже говорилось, каждый тип константы имеет свою структуру.

Вот, например, структура `CONSTANT_Class`:

```
    CONSTANT_Class_info {
        u1 tag;
        u2 name_index;
    }
```

Структура поля и метода:

```
    CONSTANT_Fieldref_info {
        u1 tag;
        u2 class_index;
        u2 name_and_type_index;
    }

    CONSTANT_Methodref_info {
        u1 tag;
        u2 class_index;
        u2 name_and_type_index;
    }
```

Рассмотрим часть нашего кода:

```
    cafe babe 
    0000 0034 
    001d -- constant_pool_count 
    0a00 0600 0f09 0010 0011 0800 12 ...
```

Итак, смотрим на структуру константы и узнаем, что первый байт отведен под тип константы. Здесь мы видим `0a` (10) - а, следовательно, это `CONSTANT_Methodref`

Смотрим его структуру:

```
    CONSTANT_Methodref_info {
        u1 tag;
        u2 class_index;
        u2 name_and_type_index;
    }
```

После одного байта для тэга, нам нужно еще 4 байта для `class_index` и `name_and_type_index`

```
    cafe babe 
    0000 0034 
    001d -- constant_pool_count 

    0a 0006 000f -- CONSTANT_Methodref
    0900 1000 1108 0012 ...
```

Отлично, мы нашли одну из значений пула констант. Идем дальше. Смотрим, `09` - значит тип  `CONSTANT_Fieldref` 

Получаем:

```
    cafe babe 
    0000 0034 
    001d -- constant_pool_count 

    0a 0006 000f -- CONSTANT_Methodref
    09 0010 0011 -- CONSTANT_Fieldref
    08 0012 ...
```

Вам может показаться, что большинство типов имеет одинаковую форму, но это не так. Например, структура следующего типа выглядит так, `CONSTANT_String`:

```
    CONSTANT_String_info {
        u1 tag;
        u2 string_index;
    }
```



Все эти структуры можно посмотреть в [Chapter 4.4 The Constant Pool](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4)



Теперь разберем, что значат типы внутри самого `info`

Методы, которые попадают под паттерн `*_index` обычно содержат адрес из таблицы пула констант. Например, `class_index`  на значение с типом `CONSTANT_Class_info`, а `string_index` на `CONSTANT_Utf8_info`

Это же мы можем видеть в дизассемблированном коде:

```
    #1 = Methodref          #6.#15         // java/lang/Object."<init>":()V
    #2 = Fieldref           #16.#17        // java/lang/System.out:Ljava/io/PrintStream;
    #3 = String             #18
```

```
    0a 0006 000f -- CONSTANT_Methodref
    09 0010 0011 -- CONSTANT_Fieldref
    08 0012 	 -- CONSTANT_String
```



Также можно выделить представление чисел и строк.

Про представление чисел можно прочитать начиная с главы [4.4.4](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4.4), а мы пока разберем лишь строки, так как числа не входят в программу Hello World

Собственно, вот так представляется строка:

```
    CONSTANT_Utf8_info {
        u1 tag;
        u2 length;
        u1 bytes[length];
    }
```

Например, наш Hello World:

```
    01 		-- tag
    000b 	-- length
    48 65 6c 6c 6f 20 57 6f 72 6c 64	-- bytes[length] // H e l l o   W o r l d
```



И если разбирать все дальше, то получим:

```
    -- [Constant Pool]

    -- methodref 
    0a 0006 000f

    -- fieldref
    09 0010 0011 

    -- string
    08 0012 

    -- methodref
    0a 0013 0014

    -- Class
    07 0015

    -- Class
    07 0016

    -- Utf8
    01 0006 
    3c 69 6e 69 74 3e 

    -- Utf8
    01 0003 
    28 29 56 

    -- Utf8
    01 0004 
    43 6f 64 65 

    -- Utf8
    01 000f 
    4c 69 6e 65 4e 75 6d
    62 65 72 54 61 62 6c 65

    -- Utf8
    01 0004 
    6d 61 69 6e 

    -- Utf8
    01 0016 
    28 5b 4c 6a 61 76 61 2f 6c 61 6e 67
    2f 53 74 72 69 6e 67 3b 29 56 

    -- Utf8
    01 000a 
    53 6f 75 72 63 65 46 69 6c 65

    -- Utf8
    01 0009 
    4d 61 69 6e 2e 6a 61 76 61 

    -- NameAndType
    0c 0007 0008 

    -- Class
    07 0017 

    -- NameAndType
    0c 0018 0019

    -- Utf8
    01 000b 
    48 65 6c 6c 6f 20 57 6f 72 6c 64 

    -- Class
    07 001a

    -- NameAndType
    0c 001b 001c 

    -- Utf8
    01 0004 
    4d 61 69 6e 

    -- Utf8
    01 0010
    6a 61 76 61 2f 6c 61 6e 67 2f 4f 62 6a 65 63 74

    -- Utf8
    01 0010 
    6a 61 76 61 2f 6c 61 6e 67 2f 53 79 73 74 65 6d

    -- Utf8
    01 0003 
    6f 75 74 

    -- Utf8
    01 0015 
    4c 6a 61 76 61 2f 69 6f 2f 50 72 69 6e 74 53 74 
    72 65 61 6d 3b

    -- Utf8
    01 0013 
    6a 61 76 61 2f 69 6f 2f 50 72 69 6e 74 53 74 72 
    65 61 6d 

    -- Utf8
    01 0007 
    70 72 69 6e 74 6c 6e

    -- Utf8
    01 0015 
    28 4c 6a 61 76 61 2f 6c 61 6e 67 2f 53 74 72 69 
    6e 67 3b 29 56 

    -- [Constant Pool END]
```

Также, мы можем сравнить его с дизассемблированным кодом:

```
    Constant pool:
       #1 = Methodref          #6.#15         // java/lang/Object."<init>":()V
       #2 = Fieldref           #16.#17        // java/lang/System.out:Ljava/io/PrintStream;
       #3 = String             #18            // Hello World
       #4 = Methodref          #19.#20  // java/io/PrintStream.println:(Ljava/lang/String;)V
       #5 = Class              #21            // Main
       #6 = Class              #22            // java/lang/Object
       #7 = Utf8               <init>
       #8 = Utf8               ()V
       #9 = Utf8               Code
      #10 = Utf8               LineNumberTable
      #11 = Utf8               main
      #12 = Utf8               ([Ljava/lang/String;)V
      #13 = Utf8               SourceFile
      #14 = Utf8               Main.java
      #15 = NameAndType        #7:#8          // "<init>":()V
      #16 = Class              #23            // java/lang/System
      #17 = NameAndType        #24:#25        // out:Ljava/io/PrintStream;
      #18 = Utf8               Hello World
      #19 = Class              #26            // java/io/PrintStream
      #20 = NameAndType        #27:#28        // println:(Ljava/lang/String;)V
      #21 = Utf8               Main
      #22 = Utf8               java/lang/Object
      #23 = Utf8               java/lang/System
      #24 = Utf8               out
      #25 = Utf8               Ljava/io/PrintStream;
      #26 = Utf8               java/io/PrintStream
      #27 = Utf8               println
      #28 = Utf8               (Ljava/lang/String;)V
```

Тем самым проверив, что все совпадает, ведь по сути `javap` просто обрабатывает этот байт-код и показывает нам его в форматированном виде.

Пул констант нужен для инструкций. Например:

```
      public Main();
        descriptor: ()V
        flags: ACC_PUBLIC
        Code:
          stack=1, locals=1, args_size=1
             0: aload_0
             1: invokespecial #1  // ссылается на адрес 1 в пуле констант
             4: return
```

Подробнее обо всех типах в пуле констант можно узнать в [Chapter 4.4 The Constant Pool](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4)



Идем дальше по структуре *ClassFile*

**access_flags**

Это битовая маска для свойств модификаторов

| Flag Name        | Value  | Interpretation                                               |
| ---------------- | ------ | ------------------------------------------------------------ |
| `ACC_PUBLIC`     | 0x0001 | Declared `public`; may be accessed from outside its package. |
| `ACC_FINAL`      | 0x0010 | Declared `final`; no subclasses allowed.                     |
| `ACC_SUPER`      | 0x0020 | Treat superclass methods specially when invoked by the *invokespecial* instruction. |
| `ACC_INTERFACE`  | 0x0200 | Is an interface, not a class.                                |
| `ACC_ABSTRACT`   | 0x0400 | Declared `abstract`; must not be instantiated.               |
| `ACC_SYNTHETIC`  | 0x1000 | Declared synthetic; not present in the source code.          |
| `ACC_ANNOTATION` | 0x2000 | Declared as an annotation type.                              |
| `ACC_ENUM`       | 0x4000 | Declared as an `enum` type.                                  |

 

**this_class**

Должна содержать адрес на `this` класса. В нашем случае, она находится по адресу 5:

```
    Constant pool:
       #1 = Methodref          #6.#15         // java/lang/Object."<init>":()V
       #2 = Fieldref           #16.#17        // java/lang/System.out:Ljava/io/PrintStream;
       #3 = String             #18            // Hello World
       #4 = Methodref          #19.#20        // java/io/PrintStream.println:(Ljava/lang/String;)V
       #5 = Class              #21            // Main
       #6 = Class              #22            // java/lang/Object
      ...
```

Следует заметить, что структуру этой переменной должна соответствовать `CONSTANT_Class_info`

**super_class**

Адрес предка класса. В нашем случае, значение по адресу `6`. Ну, и также обязательным является структура значения `CONSTANT_Class_info`



Далее, я бы хотел заметить, что имена этих классов заданы в структуре константы `CONSTANT_Utf8_info`. Если мы посмотрим ячейки `#21` и `#22`, то увидим:

```
      ...
      #21 = Utf8               Main
      #22 = Utf8               java/lang/Object
      ...
```

То есть в этих ячейках указан `name_index` из структуры:

```
    CONSTANT_Class_info {
        u1 tag;
        u2 name_index;
    }
```



**interfaces_count, fields_count**

Их в нашей программе нет, поэтому их значения будут равны 0000, а последующих значений **fields[], interfaces[]** просто не будет.

Читайте подробнее [4.1 The ClassFile Structure](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.1)



**methods_count**

Количество методов. Хоть и в коде мы видим один метод в классе, но, на самом деле, их два. Кроме `main` метода еще есть конструктор по умолчанию. Поэтому их количество равно двум, в нашем случае.



**methods[]**

Каждый элемент должен соответствовать структуре *method_info* описанной в [Chapter 4.6 Methods](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.6)

```
    method_info {
        u2             access_flags;
        u2             name_index;
        u2             descriptor_index;
        u2             attributes_count;
        attribute_info attributes[attributes_count];
    }
```



В нашем байт-коде (отформатированном, с комментариями) выглядит это так:

```
    -- [methods]

    -- public Main();

    0001 --access_flags
    0007 -- name_index
    0008 -- descriptor_index
    0001 -- attributes_count

    -- attribute_info
    0009 -- attribute_name_index (Code)
    0000 001d - attribute_length
    0001 -- max_stack
    0001 -- max_locals
    0000 0005 -- code_length 
    2a b7 00 01 b1  -- code[]

    0000 -- exception_table_length
    0001 --  attributes_count;
    000a -- attribute_name_index
    0000 0006 -- attribute_length
    00 01 00 00 00 01


    -- public static void main(java.lang.String...);

    0089  --access_flags
    000b  -- name_index
    000c  -- descriptor_index
    0001  -- attributes_count

    -- attribute_info
    0009  -- attribute_name_index (Code)
    0000 0025 -- attribute_length
    0002 -- max_stack
    0001 -- max_locals 
    0000 0009 -- code_length 
    b2 00 02 12 03 b6 00 04 b1 -- code[]

    0000 -- exception_table_length
    0001 -- attributes_count
    000a -- attribute_name_index
    0000 000a -- attribute_length
    00 02 00 00 00 04 00 08 00 05 

    -- [methods END]
```



Разберем по-подробнее структуру методов:



**access_flags**

Маска модификаторов. [Table 4.5 Method access and property flags](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.6-200-A.1)

| Flag Name          | Value  | Interpretation                                               |
| ------------------ | ------ | ------------------------------------------------------------ |
| `ACC_PUBLIC`       | 0x0001 | Declared `public`; may be accessed from outside its package. |
| `ACC_PRIVATE`      | 0x0002 | Declared `private`; accessible only within the defining class. |
| `ACC_PROTECTED`    | 0x0004 | Declared `protected`; may be accessed within subclasses.     |
| `ACC_STATIC`       | 0x0008 | Declared `static`.                                           |
| `ACC_FINAL`        | 0x0010 | Declared `final`; must not be overridden ([§5.4.5](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-5.html#jvms-5.4.5)). |
| `ACC_SYNCHRONIZED` | 0x0020 | Declared `synchronized`; invocation is wrapped by a monitor use. |
| `ACC_BRIDGE`       | 0x0040 | A bridge method, generated by the compiler.                  |
| `ACC_VARARGS`      | 0x0080 | Declared with variable number of arguments.                  |
| `ACC_NATIVE`       | 0x0100 | Declared `native`; implemented in a language other than Java. |
| `ACC_ABSTRACT`     | 0x0400 | Declared `abstract`; no implementation is provided.          |
| `ACC_STRICT`       | 0x0800 | Declared `strictfp`; floating-point mode is FP-strict.       |
| `ACC_SYNTHETIC`    | 0x1000 | Declared synthetic; not present in the source code.          |



Как мы можем видеть из байт-кода, в методе `public Main();` (конструктор) стоит маска `0001`, который означает `ACC_PUBLIC`.

А теперь сами попробуем собрать метод `main` . Вот что у него есть:

* public - ACC_PUBLIC - 0x0001
* static - ACC_STATIC - 0x0008
* String ... args - ACC_VARARGS - 0x0080

Собираем маску: 0x0001 + 0x0008 + 0x0080 = **0x0089** . Итак, мы получили `access_flag`

> К слову, ACC_VARARGS здесь необязательный, в том плане, что, если бы мы 
> использовали String[] args вместо String ... args, то этого флага бы не было



**name_index**

Адрес имени метода (`CONSTANT_Utf8_info`) в пуле констант. Здесь важно заметить, что имя конструктора это не Main, а `<init>`, расположенная в ячейке #7.

Подробнее о `<init>` и `<clinit>` в [Chapter 2.9 Special Methods](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-2.html#jvms-2.9)



**descriptor_index**

Грубо говоря, это адрес указывающий на дескриптор метода. Этот дескриптор содержит тип возвращаемого значения и тип его сигнатуры.

Также, в JVM используются интерпретируемые сокращения:

| *BaseType* Character | Type        | Interpretation                                               |
| -------------------- | ----------- | ------------------------------------------------------------ |
| `B`                  | `byte`      | signed byte                                                  |
| `C`                  | `char`      | Unicode character code point in the Basic Multilingual Plane, encoded with UTF-16 |
| `D`                  | `double`    | double-precision floating-point value                        |
| `F`                  | `float`     | single-precision floating-point value                        |
| `I`                  | `int`       | integer                                                      |
| `J`                  | `long`      | long integer                                                 |
| `L` *ClassName* `;`  | `reference` | an instance of class *ClassName*                             |
| `S`                  | `short`     | signed short                                                 |
| `Z`                  | `boolean`   | `true` or `false`                                            |
| `[`                  | `reference` | one array dimension                                          |

В общем случае это выглядит так:

```
    ( ParameterDescriptor* ) ReturnDescriptor
```

Например, следующий метод:

```
    Object m(int i, double d, Thread t) {..}
```

Можно представить в виде

```
	(IDLjava/lang/Thread;)Ljava/lang/Object
```

Собственно, `I` - это `int` , `D` - это `double`, а `Ljava/lang/Thread;` класс `Thread` из стандартной библиотеки.



Далее, идут атрибуты, которые также имеют свою структуру.

Но сначала, как и всегда, идет его количество `attributes_count`

Затем сами атрибуты со структурой описанной в [Chapter 4.7 Attributes](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.7)

```
    attribute_info {
        u2 attribute_name_index;
        u4 attribute_length;
        u1 info[attribute_length];
    }
```



**attribute_name_index**

Указание имени атрибута. В нашем случае, у обоих методов это `Code`. Атрибуты это отдельная большая тема, в котором можно по спецификации создавать даже свои атрибуты. Но нам пока следует знать, что `attribute_name_index` просто указывает на адрес в пуле констант со структурой `CONSTANT_Utf8_info`



**attribute_length**

Содержит длину атрибута, не включая `attribute_name_index` и `attribute_length`



**info**

Далее, мы будем использовать структуру `Code`, так как в значении `attribute_name_index` мы  указали на значение в пуле констант `Code`. 

Подробнее: [Chapter 4.7.3 The Code Attribute](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.7.3)

Вот его структура:

```
    Code_attribute {
        u2 attribute_name_index;
        u4 attribute_length;
        u2 max_stack;
        u2 max_locals;
        u4 code_length;
        u1 code[code_length];
        u2 exception_table_length;
        {   u2 start_pc;
            u2 end_pc;
            u2 handler_pc;
            u2 catch_type;
        } exception_table[exception_table_length];
        u2 attributes_count;
        attribute_info attributes[attributes_count];
    }
```



**max_stack**

Максимальный размер стека нужный для операции.

На тему стека можно почитать "[О стеке и куче в контексте мира Java](https://www.tune-it.ru/web/bleizard/blog/-/blogs/o-steke-i-kuce-v-kontekste-mira-java?_com_liferay_blogs_web_portlet_BlogsPortlet_redirect=https%3A%2F%2Fwww.tune-it.ru%2Fweb%2Fbleizard%2Fblog%3Fp_p_id%3Dcom_liferay_blogs_web_portlet_BlogsPortlet%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview%26_com_liferay_blogs_web_portlet_BlogsPortlet_cur%3D2%26_com_liferay_blogs_web_portlet_BlogsPortlet_delta%3D10%26p_r_p_resetCur%3Dfalse)" или в "[JVM Internals](http://blog.jamesdbloom.com/JVMInternals.html)"



**max_locals**

Максимальный размер локальных переменных

Ознакомится с локальными переменными можно либо в [Mastering Java Bytecode at the Core of the JVM](https://jrebel.com/rebellabs/rebel-labs-report-mastering-java-bytecode-at-the-core-of-the-jvm/) или в том же [JVM Internals](http://blog.jamesdbloom.com/JVMInternals.html)



**code_length**

Размер кода, который будет исполнятся внутри метода



**code[]**

Каждый код указывает на какую-то инструкцию. Таблицу соотношения **optcode** и команды с мнемоникой можно найти в википедии - [Java bytecode instruction listings](https://en.wikipedia.org/wiki/Java_bytecode_instruction_listings)

Для примера, возьмем наш конструктор:

```
    -- public Main();

    0001 --access_flags
    0007 -- name_index
    0008 -- descriptor_index
    0001 -- attributes_count

    -- attribute_info
    0009 -- attribute_name_index (Code)
    0000 001d - attribute_length
    00 01 -- max_stack
    00 01 -- max_locals
    00 00 00 05 -- code_length 
    2a b7 00 01 b1  -- code[]

    0000 -- exception_table_length
    0001 --  attributes_count;
    00 0a -- attribute_name_index
    0000 0006 -- attribute_length
    00 01 00 00 00 01
```

Здесь мы можем найти наш код:

```
    2a b7 00 01 b1
```

Ищем в таблице команды и сопоставляем:

```
    2a - aload_0
    b7 0001 - invokespecial #1
    b1 - return
```



Также описания этих команд можно найти здесь: [Chapter 4.10.1.9. Type Checking Instructions](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.10.1.9)

**exception_table_length**

Задает число элементов в таблице exception_table. У нас пока нет перехватов исключений поэтому разбирать его не будем. Но дополнительно можно почитать [Chapter 4.7.3 The Code Attribute](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.7.3)

**exception_table[]**

Имеет вот такую структуру:

```
    {   
        u2 start_pc;
        u2 end_pc;
        u2 handler_pc;
        u2 catch_type;
    }
```

Если упрощать, то нужно указать начало, конец (`start_pc`, `end_pc`) кода, который будет обрабатывать `handler_pc`  и тип исключения `catch_type`



**attributes_count**

Количество атрибутов в `Code`



**attributes[]**

Атрибуты, часто используются анализаторами или отладчиками.



**Конец**

Вот мы и разобрали простую программку Hello World:

Листинг байт-кода с комментариями можно найти на моем гисте: [gist.github](https://gist.github.com/AppLoidx/7173d7277dd73025ae06377a7cc75ed0)



**Использованная литература**

* The Java® Virtual Machine Specification - [docs.oracle](https://docs.oracle.com/javase/specs/jvms/se8/jvms8.pdf)



<hr>



**Author**: Kupriyanov Arthur

Если нашли опечатку или ошибку пишите в вк https://vk.com/apploidxxx или на e-mail [apploidyakutsk@gmail.com](mailto:apploidyakutsk@gmail.com) 



