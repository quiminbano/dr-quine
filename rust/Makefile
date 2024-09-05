COLLEN = Collen

GRACE = Grace

SULLY = Sully

SRC_C = Collen.rs

SRC_G = Grace.rs

SRC_S = Sully.rs

OBJ_C = Collen.o

OBJ_G = Grace.o

OBJ_S = Sully.o

COMPILER = rustc

all: $(COLLEN) $(GRACE) $(SULLY)

$(COLLEN): $(OBJ_C)
	$(COMPILER) $(SRC_C) -o $(COLLEN)

$(GRACE): $(OBJ_G)
	$(COMPILER) $(SRC_G) -o $(GRACE)

$(SULLY): $(OBJ_S)
	$(COMPILER) $(SRC_S) -o $(SULLY)

%.o: %.rs
	$(COMPILER) --emit=obj $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G) $(OBJ_S)

fclean: clean
	rm -f $(COLLEN) $(GRACE) $(SULLY)

re: fclean all

.PHONY: all clean fclean re