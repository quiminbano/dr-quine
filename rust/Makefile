COLLEEN = Colleen

GRACE = Grace

SULLY = Sully

SRC_C = Colleen.rs

SRC_G = Grace.rs

SRC_S = Sully.rs

OBJ_C = Colleen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

GRACE_TRASH = Grace_kid.rs

SULLY_TRASH = Sully_5.rs Sully_5 Sully_4.rs Sully_4 Sully_3.rs Sully_3 \
Sully_2.rs Sully_2 Sully_1.rs Sully_1 Sully_0.rs Sully_0 Sully_5.o Sully_4.o \
Sully_3.o Sully_2.o Sully_1.o Sully_0.o

COMPILER = rustc

all: $(COLLEEN) $(GRACE) $(SULLY)

$(COLLEEN): $(OBJ_C)
	$(COMPILER) $(SRC_C) -o $(COLLEEN)

$(GRACE): $(OBJ_G)
	$(COMPILER) $(SRC_G) -o $(GRACE)

$(SULLY): $(OBJ_S)
	$(COMPILER) $(SRC_S) -o $(SULLY)

%.o: %.rs
	$(COMPILER) --emit=obj $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S) $(GRACE_TRASH) $(SULLY_TRASH)

fclean: clean
	rm -f $(COLLEEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re