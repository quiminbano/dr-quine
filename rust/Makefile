COLLEN = Collen

GRACE = Grace

SRC_C = Collen.rs

SRC_G = Grace.rs

OBJ_C = Collen.o

OBJ_G = Grace.o

COMPILER = rustc

all: $(COLLEN) $(GRACE)

$(COLLEN): $(OBJ_C)
	$(COMPILER) $(SRC_C) -o $(COLLEN)

$(GRACE): $(OBJ_G)
	$(COMPILER) $(SRC_G) -o $(GRACE)

%.o: %.rs
	$(COMPILER) --emit=obj $< -o $@

clean:
	rm -f $(OBJ_C) $(OBJ_G)

fclean: clean
	rm -f $(COLLEN) $(GRACE)

re: fclean all

.PHONY: all clean fclean re