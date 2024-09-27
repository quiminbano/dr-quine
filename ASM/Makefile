COLLEN = Collen

GRACE = Grace

SULLY = Sully

SRC_C = Collen.s

SRC_G = Grace.s

SRC_S = Sully.s

OBJ_C = Collen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

GRACE_TRASH = Grace_kid.s

SULLY_TRASH = Sully_4.s Sully_4 Sully_3.s Sully_3 Sully_2.s Sully_2 Sully_1.s \
Sully_1 Sully_0.s Sully_4.o Sully_3.o Sully_2.o Sully_1.o

COMPILER = nasm

FLAGS_COMPILER = -f elf64

LINKER = cc

FLAGS_LINKER = -Wall -Wextra -Werror -Wpedantic

all: $(COLLEN) $(GRACE) $(SULLY)

$(COLLEN): $(OBJ_C)
	$(LINKER) $(FLAGS_LINKER) $(OBJ_C) -o $(COLLEN)

$(GRACE): $(OBJ_G)
	$(LINKER) $(FLAGS_LINKER) $(OBJ_G) -o $(GRACE)

$(SULLY): $(OBJ_S)
	$(LINKER) $(FLAGS_LINKER) $(OBJ_S) -o $(SULLY)

%.o: %.s
	$(COMPILER) $(FLAGS_COMPILER) $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S) $(GRACE_TRASH) $(SULLY_TRASH)

fclean: clean
	rm -f $(COLLEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re