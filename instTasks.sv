task instTask(logic[5:0] aVal, bVal, logic [2:0] in, logic rdwr);
	instin<=in;
	ain<=aVal;
	bin<=bVal;
	#1 $display("%t A in %b B in %b, Inst in %b", $time, ain, bin, instin);
	@(negedge clock);
	sw<=rdwr;
	@(negedge clock);
	enin<=1'b1;
	repeat (2) @(negedge clock);
	enin<=1'b0;
	repeat(5) @(negedge clock);
	sw<=1'b0;
	repeat(5) @(negedge clock);
	if(rdwr==0) begin
		#1 $display("%t A out %b B out %b, Inst out %b, Output: %b", $time, a, b, inst, z);
		checkOutput(in);
	end else begin
	$display("Write Complete");
	end
endtask

task checkOutput(logic [2:0] in);
	case (in)
		3'b000: begin
			$display("A and B addition");
			#1 ad: assert((a+b)==z) begin
				$display("%t:  A(%b) + B(%b) = Z(%b), inst (%b) ", $time, a, b, z, in);
					end else begin 
				$display("%t:	Addition or read didn't work! A(%b) B(%b), inst (%b) ", $time, a, b, in); end
		end
		
		3'b001: begin
			$display("A and B subtraction");
			#1 sb: assert((a-b)==z) begin
				$display("%t:  A(%b) - B(%b) = Z(%b), inst (%b) ", $time, a, b, z, in);
					end else begin 
				$display("%t:	Subtraction or read didn't work! A(%b) B(%b), inst (%b) ", $time, a, b, in); end
		end
		
		3'b100: begin
			$display("A is equal to B");
			#1 eq: assert((a==b)==z) begin
				$display("%t:  A(%b) == B(%b) = Z(%b), inst (%b) ", $time, a, b, z, in);
					end else begin 
				$display("%t:	Equate or read didn't work! A(%b) B(%b), inst (%b) ", $time, a, b, in); end
		end
		
		3'b101: begin
			$display("A is greater than B");
			#1 gt: assert((a>b)==z) begin
				$display("%t:  A(%b) > B(%b) = Z(%b), inst (%b) ", $time, a, b, z, in);
					end else begin 
				$display("%t:	Greater Than or read didn't work! A(%b) B(%b), inst (%b) ", $time, a, b, in); end
		end
		
		3'b110: begin
			$display("A is less than B");
			#1 lt: assert((a<b)==z) begin
				$display("%t:  A(%b) < B(%b) = Z(%b), inst (%b) ", $time, a, b, z, in);
					end else begin 
				$display("%t:	Less Than or read didn't work! A(%b) B(%b), inst (%b) ", $time, a, b, in); end
		end
		
		3'b111: begin
			$display("A is equal to 0");
			#1 e0: assert((a==5'd0)==z) begin
				$display("%t:  A(%b) == 0 == Z(%b), inst (%b) ", $time, a, z, in);
					end else begin 
				$display("%t:	Equate to Zero or read didn't work! A(%b) Z(%b), inst (%b) ", $time, a, z, in); end
		end
		
		default: begin
			$display("default case");
		end
	endcase
endtask