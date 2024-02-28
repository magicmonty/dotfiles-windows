if exists("b:current_syntax")
  finish
endif

syn match Special "https://.*"
syn match Constant " \- .\+"
syn match @text.literal " \* "
syn match Error "\\  \\ | /  /"
syn match Error "\\  \\ /  /"
syn match Error "|   |"
syn match Error "\\  V  /" 
syn match Error "\\[ ]\+$" 
syn match Error "\\[ ]\+|[ ]*$" 
syn match Error "[ ]\+|  /[ ]*$" 
syn match Error "^[ ]\+|[ ]\+$"
syn match Special "----" 
