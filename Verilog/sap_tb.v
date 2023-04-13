module sap_tb (
	input clock,
	input run
);
	reg [7:0] bus;	
	wire cp;
	wire ep;
	wire lm;
	wire ce;
	wire ei;
	wire li;
	wire ea;
	wire la;
	wire eu;
	wire su;
	wire lb;
	wire lo;
	wire hlt;
	wire [3:0] pc_bus;
	wire [7:0] ram_bus;
	wire [7:0] alu_bus;
	wire [7:0] acc_bus;
	wire [3:0] ir_bus;
	wire [3:0] ir_to_controller;
	wire [3:0] mar_to_ram;
	wire [7:0] acc_to_alu;
	wire [7:0] b_to_alu;
	
	wire [7:0] OUTPUT;
	
	wire w_clock = clock && !hlt;
	
	always @(*) begin
		if(ep) bus = pc_bus;
		else if(ce) bus = ram_bus;
		else if(eu) bus = alu_bus;
		else if(ei) bus = ir_bus;
		else if(ea) bus = acc_bus;
	end
	
	
	controller controller (
		.clock (w_clock),
		.cp (cp),
		.ep (ep),
		.lm (lm),
		.ce (ce),
		.li (li),
		.ei (ei),
		.ea (ea),
		.la (la),
		.eu (eu),
		.su (su),
		.lb (lb),
		.lo (lo),
		.instruction (ir_to_controller)
	);
	
	program_counter pc (
		.clock (w_clock),
		.cp (cp),
		.bus_out (pc_bus)
	);
	
	mar mar (
		.clock (w_clock),
		.bus_in (bus),
		.run (run),
		.lm (lm),
		.mar_to_ram (mar_to_ram)
	);
	
	ram ram (
		.run (run),
		.address (mar_to_ram),
		.bus_out (ram_bus)
	);
	
	instruction_register instruction_reg (
		.clock (w_clock),
		.li (li),
		.bus_in (bus),
		.bus_out (ir_bus),
		.ir_to_controller (ir_to_controller)
	);
	
	accumulator acc (
		.clock (w_clock),
		.la (la),
		.bus_in (bus),
		.bus_out (acc_bus),
		.acc_to_alu (acc_to_alu)
	);
	
	b_register b_reg (
		.clock (w_clock),
		.lb (lb),
		.bus_in (bus),
		.b_to_alu (b_to_alu)
	);
	
	alu alu (
		.su (su),
		.A (acc_to_alu),
		.B (b_to_alu),
		.bus_out (alu_bus)
	);
	
	output_register output_reg (
		.clock (w_clock),
		.lo (lo),
		.bus_in (bus),
		.out_to_display (OUTPUT)
	);
	
endmodule 
		