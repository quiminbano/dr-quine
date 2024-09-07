COLLEN = Collen

GRACE = Grace

SULLY = Sully

SRC_C = Collen.s

SRC_G = Grace.s

SRC_S = Sully.s

OBJ_C = Collen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

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
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S)

fclean: clean
	rm -f $(COLLEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re