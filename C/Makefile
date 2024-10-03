COLLEN = Collen

GRACE = Grace

SULLY = Sully

SRC_C = Collen.c

SRC_G = Grace.c

SRC_S = Sully.c

OBJ_C = Collen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

GRACE_TRASH = Grace_kid.c

SULLY_TRASH = Sully_5.c Sully_5 Sully_4.c Sully_4 Sully_3.c Sully_3 Sully_2.c \
Sully_2 Sully_1.c Sully_1 Sully_0.c Sully_0 Sully_5.o Sully_4.o Sully_3.o \
Sully_2.o Sully_1.o Sully_0.o

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
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S) $(GRACE_TRASH) $(SULLY_TRASH)

fclean: clean
	rm -f $(COLLEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re