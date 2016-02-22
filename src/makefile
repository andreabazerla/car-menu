EXE= executable
AS= as
LD= ld
FLAGS= --32 -gstabs
FLAGS2= -melf_i386
OBJ= main.o atoi.o menu.o row1.o row2.o row3.o row4.o row5.o row6.o row7.o row8.o read_command.o reset_pressure.o change_state.o change_signal.o itoa.o read_number.o

$(EXE): $(OBJ)
	$(LD) $(FLAGS2) -o $(EXE) $(OBJ)
main.o: main.s
	$(AS) $(FLAGS) -o main.o main.s
atoi.o: atoi.s
	$(AS) $(FLAGS) -o atoi.o atoi.s
menu.o: menu.s
	$(AS) $(FLAGS) -o menu.o menu.s
row1.o: row1.s
	$(AS) $(FLAGS) -o row1.o row1.s
row2.o: row2.s
	$(AS) $(FLAGS) -o row2.o row2.s
row3.o: row3.s
	$(AS) $(FLAGS) -o row3.o row3.s
row4.o: row4.s
	$(AS) $(FLAGS) -o row4.o row4.s
row5.o: row5.s
	$(AS) $(FLAGS) -o row5.o row5.s
row6.o: row6.s
	$(AS) $(FLAGS) -o row6.o row6.s
row7.o: row7.s
	$(AS) $(FLAGS) -o row7.o row7.s
row8.o: row8.s
	$(AS) $(FLAGS) -o row8.o row8.s
read_command.o: read_command.s
	$(AS) $(FLAGS) -o read_command.o read_command.s
reset_pressure.o: reset_pressure.s
	$(AS) $(FLAGS) -o reset_pressure.o reset_pressure.s
change_state.o: change_state.s
	$(AS) $(FLAGS) -o change_state.o change_state.s
change_signal.o: change_signal.s
	$(AS) $(FLAGS) -o change_signal.o change_signal.s
itoa.o: itoa.s
	$(AS) $(FLAGS) -o itoa.o itoa.s
read_number.o: read_number.s
	$(AS) $(FLAGS) -o read_number.o read_number.s
clean:
	rm -f *.o $(EXE) core
