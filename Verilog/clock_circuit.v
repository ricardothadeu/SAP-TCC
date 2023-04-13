module clock_circuit (
	input select, //switch para escolher entre auto e manual
	input manual, //push button para o clock manual
	input auto_clock, //clock do FPGA
	input hlt,  //sinal de controle para parar o processamento
	input run,
	output clock
);

assign clock = ((auto_clock && select) || (!select && manual)) && !hlt && !run;

endmodule 