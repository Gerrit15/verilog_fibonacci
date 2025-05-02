module d_ff(input ce, input clk, input [7:0] D, output reg [7:0] Q);
    initial begin
        D = 8'b00000000;
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

module testbench;
    /*wire [7:0] in1 = 8'b11111111;
    wire [7:0] in2 = 8'b00000000;
    reg select;
    wire [7:0] f;
    mux basic_mux(.in1(in1), .in2(in2), .select(select), .f(f));*/
    reg clk = 1'b0;
    reg ce;
    wire t;

    always #1 clk = ~clk;

    toggler flag(.clk(ce), .ce(ce), .t(t));
    initial begin
        #5 $stop;
    end

    initial
        $monitor("At time %t, have t at %b", $time, t);
endmodule;
