module controller (
	input clock,
	input clear,
	input [3:0] instruction, //vem do instruction register
	output reg cp,
	output reg ep,
	output reg la,
	output reg ea,
	output reg lm,
	output reg su,
	output reg eu,
	output reg ce,
	output reg lb,
	output reg li,
	output reg ei,
	output reg lo,
	output reg hlt
);

	parameter LDA = 4'b0000;
	parameter ADD = 4'b0001;
	parameter SUB = 4'b0010;
	parameter OUT = 4'b1110;
	parameter HLT = 4'b1111;
	
	parameter T1 = 6'b000001;
	parameter T2 = 6'b000010;
	parameter T3 = 6'b000100;
	parameter T4 = 6'b001000;
	parameter T5 = 6'b010000;
	parameter T6 = 6'b100000;

	reg [5:0] ring_counter = T1;
	
always @(negedge clock) begin
	
	cp <= 0; ep <= 0; la <= 0; ea <= 0; lm <= 0; su <= 0; 
	eu <= 0; ce <= 0; lb <= 0; li <= 0; ei <= 0; lo <= 0; hlt <= 0;
	
	if(instruction == HLT) hlt <= 1;
	else begin 
		case(ring_counter)
			T1: begin ep <= 1; lm <= 1; end
			T2: cp <= 1;
			T3: begin ce <= 1; li <= 1; end
			T4: begin
					case(instruction)
						LDA, ADD, SUB: begin lm <= 1; ei <= 1; end
						OUT: begin ea <= 1; lo <= 1; end
						HLT: hlt <= 1;
					endcase
				 end
			T5: begin
					case(instruction)
						LDA: begin ce <= 1; la <= 1; end
						ADD, SUB: begin ce <= 1; lb <= 1; end
						HLT: hlt <= 1;
					endcase
				 end
			T6: begin
					case(instruction)
						ADD: begin la <= 1; eu <= 1; end
						SUB: begin la <= 1; su <= 1; eu <= 1; end
						HLT: hlt <= 1;
					endcase
				 end	
		endcase
	end
	
	if(ring_counter == T6) ring_counter <= T1;
	else ring_counter <= ring_counter << 1;
end
	
	
endmodule 