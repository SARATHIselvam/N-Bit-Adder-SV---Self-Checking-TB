module tb_NbitAdder;
parameter N = 4;
logic [N-1:0]A;
logic [N-1:0]B;
logic Cin;
logic [N-1:0]Sum;
logic Cout;

NbitAdder #(.N(N)) DUT (.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Cout(Cout));

int total_tests = 0;
int total_failed = 0;

task automatic check(input [N-1:0]A_in,B_in,input [N-1:0]Cin_in);
	logic [N-1:0] expectedsum;
	logic expectedcout;
	
	expectedsum = A_in + B_in + Cin_in;
	expectedcout = (A_in + B_in + Cin_in) > 2**N-1;
	
	total_tests++;
	
	if (Sum!== expectedsum || Cout !== expectedcout) begin
		$error("TEST FAIL: A=%0d B=%0d Cin =%0d => Sum =%0d Cout =%0d (Expected: Sum =%0d Cout=%0d)", A_in, B_in, Cin_in, Sum, Cout, expectedsum, expectedcout);
		total_failed++;
	end
endtask

initial begin
	
	A=0;B=0;Cin=0;#5; check(A,B,Cin);
	A={N{1'b1}};B=0;Cin=0;#5; check(A,B,Cin);
	A={N{1'b1}};B=0;Cin=1;#5; check(A,B,Cin);
	A={N{1'b1}};B={N{1'b1}};Cin=1;#5; check(A,B,Cin);
	
	repeat(20) begin
		A=$urandom_range(0, 2**N-1);
		B=$urandom_range(0, 2**N-1);
		Cin=$urandom_range(0,1);
		#5;
		check(A,B,Cin);
	end
	
	if(total_failed == 0)
		$display("All Test Passed %0d Tests", total_tests);
	else
		$display("Test Passed: %0d and Failed Tests: %0d", total_tests, total_failed);
		
	$finish;
end
endmodule
