# function-call1-craft.s 函数调用和参数传递
    # 文本段, 纯代码
    .global main

    .text
_fun1:
    # 函数调用的序曲, 设置栈指针
    pushq   %rbp           # 把调用者的栈帧底部地址保存起来   
    movq    %rsp, %rbp     # 把调用者的栈帧顶部地址, 设置为本栈帧的底部

    subq    $4, %rsp       # 扩展栈

    movl    $10, -4(%rbp)  # 变量 c 赋值为 10，也可以写成 movl $10, (%rsp)

    # 做加法
    movl    %edi, %eax     # 第一个参数放进 %eax
    addl    %esi, %eax     # 把第二个参数加到 %eax,%eax 同时也是存放返回值的寄存器
    addl    -4(%rbp), %eax # 加上 c 的值

    addq    $4, %rsp       # 缩小栈

    # 函数调用的尾声, 恢复栈指针为原来的值
    popq    %rbp           # 恢复调用者栈帧的底部数值
    retq                   # 返回

    .globl  main          # .global 伪指令让 _main 函数外部可见
main:                                  ## @main
    
    # 函数调用的序曲, 设置栈指针
    pushq   %rbp           # 把调用者的栈帧底部地址保存起来  
    movq    %rsp, %rbp     # 把调用者的栈帧顶部地址, 设置为本栈帧的底部
    
    # 设置第一个和第二个参数, 分别为 1 和 2
    movl    $1, %edi
    movl    $2, %esi

    callq   _fun1                # 调用函数

    # 为 pritf 设置参数
    leaq    .LC0(%rip), %rdi   # 第一个参数是字符串的地址
    movl    %eax, %esi           # 第二个参数是前一个参数的返回值

    call   printf              # 调用函数

    # 设置返回值。这句也常用 xorl %esi, %esi 这样的指令, 都是置为零
    movl    $0, %eax
    
    # 函数调用的尾声, 恢复栈指针为原来的值
    popq    %rbp         # 恢复调用者栈帧的底部数值
    retq                 # 返回

    # 文本段, 保存字符串字面量                                  
    .text
    .section .rodata
.LC0:                                 ## @.str
    .asciz  "Hello World! :%d \n"

