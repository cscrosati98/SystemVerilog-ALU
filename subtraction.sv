module subtraction(input logic [5:0] a,b,
					output logic [5:0] z, 
					output logic overFlow);
	logic [5:0] invb;
	
	assign invb = (b ^ 6'b111111) + 6'b000001;
	
	addition sub(.a(a),.b(invb),.z(z),.overFlow(overFlow));

endmodule