module addSubfunc(input logic addSub,
						input logic [5:0] a,b,
					output logic [5:0] z, aOut,bOut,
					output logic overFlow);
		logic [5:0] addZ, subZ;
		logic addOF, subOF;
		//create submodule for addition
		addition addTop(.a(a),.b(b),.z(addZ),.overFlow(addOF));
		//create submodule for subtraction
		subtraction subTop(.a(a),.b(b),.z(subZ),.overFlow(subOF));
		
		always_comb
		begin
		//send input values to output lights
		aOut<=a;
		bOut<=b;
			if(addSub==1'b0)
				begin
				//show sum/overflow output for addition
					z <= addZ;
					overFlow<=addOF;
				end
			else
				begin
				//show sum/overflow output for subtraction
					z <= subZ;
					overFlow<=subOF;
				end
		end
		
endmodule