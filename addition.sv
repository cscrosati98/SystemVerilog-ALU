module addition(input logic [5:0] a,b,
					output logic [5:0] z, 
					output logic overFlow);
	//set up array for carry bit
	logic [5:0]cin;
	//perform bitwise addition with carry
	fullAdder z0(.a(a[0]),.b(b[0]),.z(z[0]),.cin(1'b0),.cout(cin[0]));
	fullAdder z1(.a(a[1]),.b(b[1]),.z(z[1]),.cin(cin[0]),.cout(cin[1]));
	fullAdder z2(.a(a[2]),.b(b[2]),.z(z[2]),.cin(cin[1]),.cout(cin[2]));
	fullAdder z3(.a(a[3]),.b(b[3]),.z(z[3]),.cin(cin[2]),.cout(cin[3]));
	fullAdder z4(.a(a[4]),.b(b[4]),.z(z[4]),.cin(cin[3]),.cout(cin[4]));
	fullAdder z5(.a(a[5]),.b(b[5]),.z(z[5]),.cin(cin[4]),.cout(cin[5]));
	//detect overflow
	assign overFlow = ((a[5] == b[5])&&(z[5]!=a[5]));
	
endmodule