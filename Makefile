# Makefile for 1D-Advection

MODULES = fin_diff.mod

OBJECTS = fin_diff.o main.o

.PHONY: clean

plot.png: make_plots.py read_plot_module.py output.txt grid.txt
	python make_plots.py 	

output.txt grid.txt: main.exe
	./main.exe
	
main.exe: $(MODULES) $(OBJECTS)
	gfortran $(OBJECTS) -o main.exe
	
main.o: main.f90
	gfortran -c main.f90
	
%.mod: %.f90
	gfortran -c $< 
	
clean:
	rm -f *.o  $(MODULES) main.exe *.png *.txt *.pyc
