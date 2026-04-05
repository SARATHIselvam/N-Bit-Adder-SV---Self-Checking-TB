module NbitAdder #(parameter N = 4) (
	input logic [N-1:0]A,
	input logic [N-1:0]B,
	input logic Cin,
	output logic [N-1:0]Sum,
	output logic Cout
);

	logic[N:0]Carry;
	assign Carry[0]= Cin;
	genvar i;
	generate
		for(i=0;i<N;i++) begin: NbitAdd
			assign Sum[i] = A[i]^B[i]^Carry[i];
			assign Carry[i+1] = (A[i]&B[i])|(B[i]&Carry[i])|(Carry[i]&A[i]);
		end
	endgenerate
	assign Cout = Carry[N];
endmodule
