NAME=reprog
ASM=nasm
LD=ld
SRC=main.asm mainloop.asm handler.asm cmd_handler.asm str.asm calls.asm utils.asm
INCLUDE=utils.inc calls.inc
OBJS=$(SRC:.asm=.o)
ASMFLAGS=-felf64
LDFLAGS=

$(NAME): $(OBJS)
	$(LD) -o $(NAME) $(OBJS) $(LDFLAGS)

all: $(NAME)

debug:
	make -C . "ASMFLAGS=-g -felf64" NAME=$(NAME)_debug

%.o: %.asm $(INCLUDES)
	$(ASM) $(ASMFLAGS) $< -o $@

re: fclean all

clean:
	rm -rf $(OBJS)

fclean: clean
	rm -rf $(NAME) $(NAME)_debug

.PHONY: all re clean fclean debug
