org 100h


.data

msg1:    db      "1-Add",0dh,0ah,"2-Multiply",0dh,0ah,"3-Subtract",0dh,0ah,"4-Divide", 0Dh,0Ah, '$'
msg2:    db      0dh,0ah,"Enter First No : $"
msg3:    db      0dh,0ah,"Enter Second No : $"
msg4:    db      0dh,0ah,"Choice Error $" 
msg5:    db      0dh,0ah,"Result : $" 
msg6:    db      0dh,0ah ,'thank you for using the calculator! press any key... ', 0Dh,0Ah, '$'


.code
start:  
        mov	cl, 1fh
        call L1
        mov ah, 9
        mov dx, offset msg1 
        int 21h
        mov ah, 0                       
        int 16h  
        cmp al, 31h 
        je Gm3
        cmp al, 32h
        je Drb
        cmp al, 33h
        je Tar7
        cmp al, 34h
        je Qsma
        mov ah, 09h
        mov dx, offset msg4
        int 21h
        mov ah, 0
        int 16h
        jmp start
        

L1:
            
            mov dl, 00b0h
            mov ah, 2h 
            int 21h

            dec	cl
            jnz	L1
            mov dl, 00ah
            mov ah, 2h 
            int 21h
            ret

Gm3:   
            mov	cl, 1fh
            call L1
            mov ah, 09h  
            mov dx, offset msg2  
            int 21h
            mov cx, 0 
            call GebAlrqm  
            push dx
            mov ah, 9
            mov dx, offset msg3
            int 21h 
            mov cx, 0
            call GebAlrqm
            pop bx
            add dx, bx
            push dx 
            mov ah, 9
            mov dx, offset msg5
            int 21h
            mov cx, 10000
            pop dx
            call A3rd 
            jmp exit 
            
GebAlrqm:   
            mov ah, 0
            int 16h   
            mov dx, 0  
            mov bx, 1 
            cmp al, 0dh 
            je GahzAlrqm 
            sub ax, 30h 
            call A3rdAlrqm 
            mov ah, 0 
            push ax  
            inc cx   
            jmp GebAlrqm
   


GahzAlrqm:     
            pop ax  
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx       
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne GahzAlrqm
            ret   


       
       
A3rd:  
        mov ax, dx
        mov dx, 0
        div cx 
        call A3rdAlrqm
        mov bx, dx 
        mov dx, 0
        mov ax, cx 
        mov cx, 10
        div cx
        mov dx, bx 
        mov cx, ax
        cmp ax, 0
        jne A3rd
        ret


A3rdAlrqm: 
            push ax 
            push dx 
            mov dx, ax 
            add dl, 30h
            mov ah, 2
            int 21h
            pop dx  
            pop ax
            ret
      
   
exit:   
        mov dx, offset msg6
        mov ah, 09h
        int 21h  

        mov ah, 0
        int 16h
        ret
            
                       
Drb:   
            mov	cl, 1fh
            call L1
            mov ah, 09h
            mov dx, offset msg2
            int 21h
            mov cx, 0
            call GebAlrqm
            push dx
            mov ah, 9
            mov dx, offset msg3
            int 21h 
            mov cx, 0
            call GebAlrqm
            pop bx
            mov ax, dx
            mul bx 
            mov dx, ax
            push dx 
            mov ah, 9
            mov dx, offset msg5
            int 21h
            mov cx, 10000
            pop dx
            call A3rd 
            jmp exit 


Tar7:   
            mov	cl, 1fh
            call L1
            mov ah, 09h
            mov dx, offset msg2
            int 21h
            mov cx, 0
            call GebAlrqm
            push dx
            mov ah, 9
            mov dx, offset msg3
            int 21h 
            mov cx, 0
            call GebAlrqm
            pop bx
            sub bx, dx
            mov dx, bx
            push dx 
            mov ah, 9
            mov dx, offset msg5
            int 21h
            mov cx, 10000
            pop dx
            call A3rd 
            jmp exit 
    
            
Qsma:     
            mov	cl, 1fh
            call L1
            mov ah, 09h
            mov dx, offset msg2
            int 21h
            mov cx, 0
            call GebAlrqm
            push dx
            mov ah, 9
            mov dx, offset msg3
            int 21h 
            mov cx, 0
            call GebAlrqm
            pop bx
            mov ax, bx
            mov cx, dx
            mov dx, 0
            mov bx, 0
            div cx
            mov bx, dx
            mov dx, ax
            push bx 
            push dx 
            mov ah, 9
            mov dx, offset msg5
            int 21h
            mov cx, 10000
            pop dx
            call A3rd
            pop bx
            cmp bx, 0
            je exit 
            jmp exit
