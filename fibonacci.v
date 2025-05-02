module d_ff(input [7:0] ic, input ce, input clk, input wire [7:0] D, output reg [7:0] Q);
    initial begin
        Q = ic;
    end

    always @(posedge clk) begin
    if(ce)
        Q <= D;
    end
endmodule

module toggler(input clk, input ce, output reg t);
    initial begin
        t = 0;
    end

    always @(posedge clk) begin
    if(ce)
        t <= !t;
    end
endmodule

module mux(input [7:0] in1, input [7:0] in2, input select, output [7:0] f);
    assign f = select ? in2 : in1;
endmodule;

module adder(input [7:0] Q1, input[7:0] Q2, input select, output [7:0] D1, output [7:0] D2);
    wire [7:0] next;
    assign next = Q1 + Q2;
    mux Q1_mux(.in1(next), .in2(Q1), .select(select), .f(D1));
    mux Q2_mux(.in1(Q2), .in2(next), .select(select), .f(D2));
endmodule;

//current issue is here with odd numbers, seems to be some issue. Just make
//a next state table, you'll be happier
module downcounter(input [3:0] fib_num, input clk, output reg ce);
    reg [3:0] num;
    initial begin
        num = fib_num;
    end

    always @(posedge clk) begin
        if(num > 4'b0000) begin
            ce = 1;
            num = num - 1;
        end
        else
            ce = 0;
    end
endmodule

module fibchip(output wire [7:0] outval);

reg clk = 1'b0;
wire ce;
wire t;
always #1 clk = !clk;
downcounter countchip(.fib_num(4'b1100), .clk(clk), .ce(ce));
toggler togglechip(.clk(clk), .ce(ce), .t(t));

wire [7:0] mem1_in;
wire [7:0] mem1_out;
d_ff mem1(.ic(8'b00000000), .ce(ce), .clk(clk), .D(mem1_in), .Q(mem1_out));


wire [7:0] mem2_in;
wire [7:0] mem2_out;
d_ff mem2(.ic(8'b00000001), .ce(ce), .clk(clk), .D(mem2_in), .Q(mem2_out));

adder addchip(.Q1(mem1_out), .Q2(mem2_out), .select(t), .D1(mem1_in), .D2(mem2_in));

assign outval = t ? mem2_out : mem1_out;

endmodule

module testbench;
    wire [7:0] fin_value;
    fibchip fibonacci_chip(.outval(fin_value));
    initial begin
        #60 $stop;
    end

    initial
        $monitor("Holds %d", fin_value);
endmodule;
