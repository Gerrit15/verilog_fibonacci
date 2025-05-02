./a.out: ./fibonacci.v
	iverilog ./fibonacci.v -W all -DN=4\'b0110

run: ./a.out
	./a.out

clean:
	rm -f ./a.out
