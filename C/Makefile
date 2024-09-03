COLLEN = Collen

GRACE = Grace

SRC_C = Collen.c

SRC_G = Grace.c

OBJ_C = Collen.o

OBJ_G = Grace.o

COMPILER = cc

FLAGS = -Wall -Wextra -Werror -Wpedantic

all: $(COLLEN) $(GRACE)

$(COLLEN): $(OBJ_C)
	$(COMPILER) $(FLAGS) $(OBJ_C) -o $(COLLEN)

$(GRACE): $(OBJ_G)
	$(COMPILER) $(FLAGS) $(OBJ_G) -o $(GRACE)

%.o: %.c
	$(COMPILER) $(FLAGS) -c $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G)

fclean: clean
	rm -f $(COLLEN) $(GRACE)

re: fclean all

.PHONY: all clean fclean re