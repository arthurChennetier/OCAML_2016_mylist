OCAMLC		= ocamlc

OCAMLOPT	= ocamlopt

RM		= rm -f

OCAMLFLAGS	= -w Aelz -warn-error A

NAME		= a.out

NAMEBYTE	= $(NAME:%=%_byte)

SOURCE		= my_list.ml

INTERFACE	=

all:		$(NAME)

byte:		$(NAMEBYTE)

$(NAME):
			$(OCAMLOPT) $(OCAMLFLAGS) $(INTERFACE)
			$(OCAMLOPT) $(OCAMLFLAGS) -o $(NAME) $(SOURCE)

$(NAMEBYTE):
			$(OCAMLC) $(OCAMLFLAGS) $(INTERFACE)
			$(OCAMLC) $(OCAMLFLAGS) -o $(NAMEBYTE) $(SOURCE)

clean:
			$(RM) *.o *.cmi *.cmx *.cmo *~

fclean:		clean
			$(RM) $(NAME) $(NAMEBYTE)

re:			fclean all

.PHONY:		all clean fclean re

