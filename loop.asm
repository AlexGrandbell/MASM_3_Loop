assume cs:code, ds:data, es:table

data segment
	db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db	'1993','1994','1995'
	;以上是表示21年的21个字符串

	dd	16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065
	dd	97479, 140417, 197514, 345980, 590827, 803530, 1183000, 1843000, 2759000
	dd	3753000, 4649000, 5937000
	;以上是表示21年公司总收入的21个dword型数据
	
	dw	3, 7, 9, 13, 28, 38, 130, 220, 476
	dw	778, 1001, 1442, 2258, 2793, 4037, 5635, 8226, 11542
	dw	14430, 15257, 17800
	;以上是表示21年公司雇员人数的21个word型数据
data ends

table segment
	db 21 dup ('year summ ne ?? ')
table ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov ax,table
    mov es,ax

    ;复制年份
    mov cx,21 ;外循环21年
    mov si,0 ;原数据地址
    mov di,0 ;新数据地址
lp1:mov dx,cx ;保存外循环计数器
    mov cx,2
lp2:mov bx,ds:[si] ;复制16bit
    add si,2 ;地址+2
    mov es:[di],bx ;复制到16bit
    add di,2; 地址+2
    loop lp2
    add di,000CH ;下一行
    mov cx,dx
    loop lp1

    ;复制收入
    mov cx,21 ;外循环21年
    mov si,84 ;原数据地址
    mov di,5 ;新数据地址
lp3:mov dx,cx ;保存外循环计数器
    mov cx,2
lp4:mov bx,ds:[si] ;复制16bit
    add si,2 ;地址+2
    mov es:[di],bx ;复制到16bit
    add di,2; 地址+2
    loop lp4
    add di,000CH ;下一行
    mov cx,dx
    loop lp3

    ;复制人数
    mov cx,21 ;外循环21年
    mov si,168 ;原数据地址
    mov di,000AH ;新数据地址
lp5:mov bx,ds:[si] ;复制16bit
    add si,2 ;地址+2
    mov es:[di],bx ;复制到16bit
    add di,0010H ;下一行
    loop lp5

    ;除法
    mov si,84
    mov di,168
    mov bp,000DH
    mov cx,21

lp6:mov ax,ds:[si]
    mov dx,ds:[si+2];被除数
    mov bx,ds:[di]
    div bx
    mov es:[bp],ax;存储
    add bp,0010H
    add si,4
    add di,2
    loop lp6

    ; 程序结束
    mov ax, 4c00h
    int 21h
code ends
end start