module fullAdder(input logic a, b, cin, 
						output logic z, cout);
	//find the carry out 
	assign cout = (~cin&a&(b))+(cin&~a&(b))+(cin&a&~(b))+(cin&a&(b));
	//find Z (output)
	assign z = (~a&(b)&~cin)+(a&~(b)&~cin)+(~a&~(b)&cin)+(a&(b)&cin);
endmodule