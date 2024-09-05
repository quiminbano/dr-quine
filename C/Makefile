COLLEN = Collen

GRACE = Grace

SULLY = Sully

SRC_C = Collen.c

SRC_G = Grace.c

SRC_S = Sully.c

OBJ_C = Collen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

COMPILER = cc

FLAGS = -Wall -Wextra -Werror -Wpedantic

all: $(COLLEN) $(GRACE) $(SULLY)

$(COLLEN): $(OBJ_C)
	$(COMPILER) $(FLAGS) $(OBJ_C) -o $(COLLEN)

$(GRACE): $(OBJ_G)
	$(COMPILER) $(FLAGS) $(OBJ_G) -o $(GRACE)

$(SULLY): $(OBJ_S)
	$(COMPILER) $(FLAGS) $(OBJ_S) -o $(SULLY)

%.o: %.c
	$(COMPILER) $(FLAGS) -c $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S)

fclean: clean
	rm -f $(COLLEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re