COLLEEN = Colleen

GRACE = Grace

SULLY = Sully

SRC_C = Colleen.c

SRC_G = Grace.c

SRC_S = Sully.c

OBJ_C = Colleen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

GRACE_TRASH = Grace_kid.c

SULLY_TRASH = Sully_5.c Sully_5 Sully_4.c Sully_4 Sully_3.c Sully_3 Sully_2.c \
Sully_2 Sully_1.c Sully_1 Sully_0.c Sully_0

COMPILER = cc

FLAGS = -Wall -Wextra -Werror -Wpedantic

all: $(COLLEEN) $(GRACE) $(SULLY)

$(COLLEEN): $(OBJ_C)
	$(COMPILER) $(FLAGS) $(OBJ_C) -o $(COLLEEN)

$(GRACE): $(OBJ_G)
	$(COMPILER) $(FLAGS) $(OBJ_G) -o $(GRACE)

$(SULLY): $(OBJ_S)
	$(COMPILER) $(FLAGS) $(OBJ_S) -o $(SULLY)

%.o: %.c
	$(COMPILER) $(FLAGS) -c $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S) $(GRACE_TRASH) $(SULLY_TRASH)

fclean: clean
	rm -f $(COLLEEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re