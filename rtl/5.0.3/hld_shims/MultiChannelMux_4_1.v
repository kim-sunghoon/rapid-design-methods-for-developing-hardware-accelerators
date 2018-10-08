// See LICENSE for license details.
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif

module DecoupledStge(
  input   clock,
  input   reset,
  output  io_inp_ready,
  input   io_inp_valid,
  input  [79:0] io_inp_bits,
  input   io_out_ready,
  output  io_out_valid,
  output [79:0] io_out_bits
);
  reg  out_valid;
  reg [31:0] GEN_1;
  reg [79:0] out_bits;
  reg [95:0] GEN_2;
  wire  T_24;
  wire  T_25;
  wire  T_26;
  wire  T_27;
  wire [79:0] GEN_0;
  assign io_inp_ready = T_25;
  assign io_out_valid = out_valid;
  assign io_out_bits = out_bits;
  assign T_24 = ~ io_out_valid;
  assign T_25 = io_out_ready | T_24;
  assign T_26 = ~ io_inp_ready;
  assign T_27 = io_inp_valid | T_26;
  assign GEN_0 = io_inp_ready ? io_inp_bits : out_bits;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_1 = {1{$random}};
  out_valid = GEN_1[0:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_2 = {3{$random}};
  out_bits = GEN_2[79:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(reset) begin
      out_valid <= 1'h0;
    end else begin
      out_valid <= T_27;
    end
    if(1'h0) begin
    end else begin
      if(io_inp_ready) begin
        out_bits <= io_inp_bits;
      end
    end
  end
endmodule
module RRArbiter(
  input   clock,
  input   reset,
  output  io_in_0_ready,
  input   io_in_0_valid,
  input  [79:0] io_in_0_bits,
  output  io_in_1_ready,
  input   io_in_1_valid,
  input  [79:0] io_in_1_bits,
  output  io_in_2_ready,
  input   io_in_2_valid,
  input  [79:0] io_in_2_bits,
  output  io_in_3_ready,
  input   io_in_3_valid,
  input  [79:0] io_in_3_bits,
  input   io_out_ready,
  output  io_out_valid,
  output [79:0] io_out_bits,
  output [1:0] io_chosen
);
  wire [1:0] choice;
  wire  GEN_0_ready;
  wire  GEN_0_valid;
  wire [79:0] GEN_0_bits;
  wire  GEN_2;
  wire  GEN_3;
  wire [79:0] GEN_4;
  wire  GEN_5;
  wire  GEN_6;
  wire [79:0] GEN_7;
  wire  GEN_8;
  wire  GEN_9;
  wire [79:0] GEN_10;
  wire  GEN_1_ready;
  wire  GEN_1_valid;
  wire [79:0] GEN_1_bits;
  wire  T_97;
  reg [1:0] lastGrant;
  reg [31:0] GEN_0;
  wire [1:0] GEN_11;
  wire  grantMask_1;
  wire  grantMask_2;
  wire  grantMask_3;
  wire  validMask_1;
  wire  validMask_2;
  wire  validMask_3;
  wire  T_103;
  wire  T_104;
  wire  T_105;
  wire  T_106;
  wire  T_107;
  wire  T_111;
  wire  T_113;
  wire  T_115;
  wire  T_117;
  wire  T_119;
  wire  T_121;
  wire  T_125;
  wire  T_126;
  wire  T_127;
  wire  T_128;
  wire  T_129;
  wire  T_130;
  wire  T_131;
  wire  T_132;
  wire  T_133;
  wire [1:0] GEN_12;
  wire [1:0] GEN_13;
  wire [1:0] GEN_14;
  wire [1:0] GEN_15;
  wire [1:0] GEN_16;
  wire [1:0] GEN_17;
  assign io_in_0_ready = T_130;
  assign io_in_1_ready = T_131;
  assign io_in_2_ready = T_132;
  assign io_in_3_ready = T_133;
  assign io_out_valid = GEN_0_valid;
  assign io_out_bits = GEN_1_bits;
  assign io_chosen = choice;
  assign choice = GEN_17;
  assign GEN_0_ready = GEN_8;
  assign GEN_0_valid = GEN_9;
  assign GEN_0_bits = GEN_10;
  assign GEN_2 = 2'h1 == io_chosen ? io_in_1_ready : io_in_0_ready;
  assign GEN_3 = 2'h1 == io_chosen ? io_in_1_valid : io_in_0_valid;
  assign GEN_4 = 2'h1 == io_chosen ? io_in_1_bits : io_in_0_bits;
  assign GEN_5 = 2'h2 == io_chosen ? io_in_2_ready : GEN_2;
  assign GEN_6 = 2'h2 == io_chosen ? io_in_2_valid : GEN_3;
  assign GEN_7 = 2'h2 == io_chosen ? io_in_2_bits : GEN_4;
  assign GEN_8 = 2'h3 == io_chosen ? io_in_3_ready : GEN_5;
  assign GEN_9 = 2'h3 == io_chosen ? io_in_3_valid : GEN_6;
  assign GEN_10 = 2'h3 == io_chosen ? io_in_3_bits : GEN_7;
  assign GEN_1_ready = GEN_8;
  assign GEN_1_valid = GEN_9;
  assign GEN_1_bits = GEN_10;
  assign T_97 = io_out_ready & io_out_valid;
  assign GEN_11 = T_97 ? io_chosen : lastGrant;
  assign grantMask_1 = 2'h1 > lastGrant;
  assign grantMask_2 = 2'h2 > lastGrant;
  assign grantMask_3 = 2'h3 > lastGrant;
  assign validMask_1 = io_in_1_valid & grantMask_1;
  assign validMask_2 = io_in_2_valid & grantMask_2;
  assign validMask_3 = io_in_3_valid & grantMask_3;
  assign T_103 = validMask_1 | validMask_2;
  assign T_104 = T_103 | validMask_3;
  assign T_105 = T_104 | io_in_0_valid;
  assign T_106 = T_105 | io_in_1_valid;
  assign T_107 = T_106 | io_in_2_valid;
  assign T_111 = validMask_1 == 1'h0;
  assign T_113 = T_103 == 1'h0;
  assign T_115 = T_104 == 1'h0;
  assign T_117 = T_105 == 1'h0;
  assign T_119 = T_106 == 1'h0;
  assign T_121 = T_107 == 1'h0;
  assign T_125 = grantMask_1 | T_117;
  assign T_126 = T_111 & grantMask_2;
  assign T_127 = T_126 | T_119;
  assign T_128 = T_113 & grantMask_3;
  assign T_129 = T_128 | T_121;
  assign T_130 = T_115 & io_out_ready;
  assign T_131 = T_125 & io_out_ready;
  assign T_132 = T_127 & io_out_ready;
  assign T_133 = T_129 & io_out_ready;
  assign GEN_12 = io_in_2_valid ? 2'h2 : 2'h3;
  assign GEN_13 = io_in_1_valid ? 2'h1 : GEN_12;
  assign GEN_14 = io_in_0_valid ? 2'h0 : GEN_13;
  assign GEN_15 = validMask_3 ? 2'h3 : GEN_14;
  assign GEN_16 = validMask_2 ? 2'h2 : GEN_15;
  assign GEN_17 = validMask_1 ? 2'h1 : GEN_16;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_0 = {1{$random}};
  lastGrant = GEN_0[1:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(reset) begin
      lastGrant <= 2'h0;
    end else begin
      if(T_97) begin
        lastGrant <= io_chosen;
      end
    end
  end
endmodule
module ArbiterReged(
  input   clock,
  input   reset,
  output  io_qin_0_ready,
  input   io_qin_0_valid,
  input  [79:0] io_qin_0_bits,
  output  io_qin_1_ready,
  input   io_qin_1_valid,
  input  [79:0] io_qin_1_bits,
  output  io_qin_2_ready,
  input   io_qin_2_valid,
  input  [79:0] io_qin_2_bits,
  output  io_qin_3_ready,
  input   io_qin_3_valid,
  input  [79:0] io_qin_3_bits,
  input   io_qout_ready,
  output  io_qout_valid,
  output [79:0] io_qout_bits
);
  wire  DecoupledStge_5_clock;
  wire  DecoupledStge_5_reset;
  wire  DecoupledStge_5_io_inp_ready;
  wire  DecoupledStge_5_io_inp_valid;
  wire [79:0] DecoupledStge_5_io_inp_bits;
  wire  DecoupledStge_5_io_out_ready;
  wire  DecoupledStge_5_io_out_valid;
  wire [79:0] DecoupledStge_5_io_out_bits;
  wire  DecoupledStge_1_1_clock;
  wire  DecoupledStge_1_1_reset;
  wire  DecoupledStge_1_1_io_inp_ready;
  wire  DecoupledStge_1_1_io_inp_valid;
  wire [79:0] DecoupledStge_1_1_io_inp_bits;
  wire  DecoupledStge_1_1_io_out_ready;
  wire  DecoupledStge_1_1_io_out_valid;
  wire [79:0] DecoupledStge_1_1_io_out_bits;
  wire  DecoupledStge_2_1_clock;
  wire  DecoupledStge_2_1_reset;
  wire  DecoupledStge_2_1_io_inp_ready;
  wire  DecoupledStge_2_1_io_inp_valid;
  wire [79:0] DecoupledStge_2_1_io_inp_bits;
  wire  DecoupledStge_2_1_io_out_ready;
  wire  DecoupledStge_2_1_io_out_valid;
  wire [79:0] DecoupledStge_2_1_io_out_bits;
  wire  DecoupledStge_3_1_clock;
  wire  DecoupledStge_3_1_reset;
  wire  DecoupledStge_3_1_io_inp_ready;
  wire  DecoupledStge_3_1_io_inp_valid;
  wire [79:0] DecoupledStge_3_1_io_inp_bits;
  wire  DecoupledStge_3_1_io_out_ready;
  wire  DecoupledStge_3_1_io_out_valid;
  wire [79:0] DecoupledStge_3_1_io_out_bits;
  wire  in_stage_inps_0_ready;
  wire  in_stage_inps_0_valid;
  wire [79:0] in_stage_inps_0_bits;
  wire  in_stage_inps_1_ready;
  wire  in_stage_inps_1_valid;
  wire [79:0] in_stage_inps_1_bits;
  wire  in_stage_inps_2_ready;
  wire  in_stage_inps_2_valid;
  wire [79:0] in_stage_inps_2_bits;
  wire  in_stage_inps_3_ready;
  wire  in_stage_inps_3_valid;
  wire [79:0] in_stage_inps_3_bits;
  wire  arb_clock;
  wire  arb_reset;
  wire  arb_io_in_0_ready;
  wire  arb_io_in_0_valid;
  wire [79:0] arb_io_in_0_bits;
  wire  arb_io_in_1_ready;
  wire  arb_io_in_1_valid;
  wire [79:0] arb_io_in_1_bits;
  wire  arb_io_in_2_ready;
  wire  arb_io_in_2_valid;
  wire [79:0] arb_io_in_2_bits;
  wire  arb_io_in_3_ready;
  wire  arb_io_in_3_valid;
  wire [79:0] arb_io_in_3_bits;
  wire  arb_io_out_ready;
  wire  arb_io_out_valid;
  wire [79:0] arb_io_out_bits;
  wire [1:0] arb_io_chosen;
  wire  stage_out_clock;
  wire  stage_out_reset;
  wire  stage_out_io_inp_ready;
  wire  stage_out_io_inp_valid;
  wire [79:0] stage_out_io_inp_bits;
  wire  stage_out_io_out_ready;
  wire  stage_out_io_out_valid;
  wire [79:0] stage_out_io_out_bits;
  DecoupledStge DecoupledStge_5 (
    .clock(DecoupledStge_5_clock),
    .reset(DecoupledStge_5_reset),
    .io_inp_ready(DecoupledStge_5_io_inp_ready),
    .io_inp_valid(DecoupledStge_5_io_inp_valid),
    .io_inp_bits(DecoupledStge_5_io_inp_bits),
    .io_out_ready(DecoupledStge_5_io_out_ready),
    .io_out_valid(DecoupledStge_5_io_out_valid),
    .io_out_bits(DecoupledStge_5_io_out_bits)
  );
  DecoupledStge DecoupledStge_1_1 (
    .clock(DecoupledStge_1_1_clock),
    .reset(DecoupledStge_1_1_reset),
    .io_inp_ready(DecoupledStge_1_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_1_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_1_1_io_inp_bits),
    .io_out_ready(DecoupledStge_1_1_io_out_ready),
    .io_out_valid(DecoupledStge_1_1_io_out_valid),
    .io_out_bits(DecoupledStge_1_1_io_out_bits)
  );
  DecoupledStge DecoupledStge_2_1 (
    .clock(DecoupledStge_2_1_clock),
    .reset(DecoupledStge_2_1_reset),
    .io_inp_ready(DecoupledStge_2_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_2_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_2_1_io_inp_bits),
    .io_out_ready(DecoupledStge_2_1_io_out_ready),
    .io_out_valid(DecoupledStge_2_1_io_out_valid),
    .io_out_bits(DecoupledStge_2_1_io_out_bits)
  );
  DecoupledStge DecoupledStge_3_1 (
    .clock(DecoupledStge_3_1_clock),
    .reset(DecoupledStge_3_1_reset),
    .io_inp_ready(DecoupledStge_3_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_3_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_3_1_io_inp_bits),
    .io_out_ready(DecoupledStge_3_1_io_out_ready),
    .io_out_valid(DecoupledStge_3_1_io_out_valid),
    .io_out_bits(DecoupledStge_3_1_io_out_bits)
  );
  RRArbiter arb (
    .clock(arb_clock),
    .reset(arb_reset),
    .io_in_0_ready(arb_io_in_0_ready),
    .io_in_0_valid(arb_io_in_0_valid),
    .io_in_0_bits(arb_io_in_0_bits),
    .io_in_1_ready(arb_io_in_1_ready),
    .io_in_1_valid(arb_io_in_1_valid),
    .io_in_1_bits(arb_io_in_1_bits),
    .io_in_2_ready(arb_io_in_2_ready),
    .io_in_2_valid(arb_io_in_2_valid),
    .io_in_2_bits(arb_io_in_2_bits),
    .io_in_3_ready(arb_io_in_3_ready),
    .io_in_3_valid(arb_io_in_3_valid),
    .io_in_3_bits(arb_io_in_3_bits),
    .io_out_ready(arb_io_out_ready),
    .io_out_valid(arb_io_out_valid),
    .io_out_bits(arb_io_out_bits),
    .io_chosen(arb_io_chosen)
  );
  DecoupledStge stage_out (
    .clock(stage_out_clock),
    .reset(stage_out_reset),
    .io_inp_ready(stage_out_io_inp_ready),
    .io_inp_valid(stage_out_io_inp_valid),
    .io_inp_bits(stage_out_io_inp_bits),
    .io_out_ready(stage_out_io_out_ready),
    .io_out_valid(stage_out_io_out_valid),
    .io_out_bits(stage_out_io_out_bits)
  );
  assign io_qin_0_ready = in_stage_inps_0_ready;
  assign io_qin_1_ready = in_stage_inps_1_ready;
  assign io_qin_2_ready = in_stage_inps_2_ready;
  assign io_qin_3_ready = in_stage_inps_3_ready;
  assign io_qout_valid = stage_out_io_out_valid;
  assign io_qout_bits = stage_out_io_out_bits;
  assign DecoupledStge_5_clock = clock;
  assign DecoupledStge_5_reset = reset;
  assign DecoupledStge_5_io_inp_valid = in_stage_inps_0_valid;
  assign DecoupledStge_5_io_inp_bits = in_stage_inps_0_bits;
  assign DecoupledStge_5_io_out_ready = arb_io_in_0_ready;
  assign DecoupledStge_1_1_clock = clock;
  assign DecoupledStge_1_1_reset = reset;
  assign DecoupledStge_1_1_io_inp_valid = in_stage_inps_1_valid;
  assign DecoupledStge_1_1_io_inp_bits = in_stage_inps_1_bits;
  assign DecoupledStge_1_1_io_out_ready = arb_io_in_1_ready;
  assign DecoupledStge_2_1_clock = clock;
  assign DecoupledStge_2_1_reset = reset;
  assign DecoupledStge_2_1_io_inp_valid = in_stage_inps_2_valid;
  assign DecoupledStge_2_1_io_inp_bits = in_stage_inps_2_bits;
  assign DecoupledStge_2_1_io_out_ready = arb_io_in_2_ready;
  assign DecoupledStge_3_1_clock = clock;
  assign DecoupledStge_3_1_reset = reset;
  assign DecoupledStge_3_1_io_inp_valid = in_stage_inps_3_valid;
  assign DecoupledStge_3_1_io_inp_bits = in_stage_inps_3_bits;
  assign DecoupledStge_3_1_io_out_ready = arb_io_in_3_ready;
  assign in_stage_inps_0_ready = DecoupledStge_5_io_inp_ready;
  assign in_stage_inps_0_valid = io_qin_0_valid;
  assign in_stage_inps_0_bits = io_qin_0_bits;
  assign in_stage_inps_1_ready = DecoupledStge_1_1_io_inp_ready;
  assign in_stage_inps_1_valid = io_qin_1_valid;
  assign in_stage_inps_1_bits = io_qin_1_bits;
  assign in_stage_inps_2_ready = DecoupledStge_2_1_io_inp_ready;
  assign in_stage_inps_2_valid = io_qin_2_valid;
  assign in_stage_inps_2_bits = io_qin_2_bits;
  assign in_stage_inps_3_ready = DecoupledStge_3_1_io_inp_ready;
  assign in_stage_inps_3_valid = io_qin_3_valid;
  assign in_stage_inps_3_bits = io_qin_3_bits;
  assign arb_clock = clock;
  assign arb_reset = reset;
  assign arb_io_in_0_valid = DecoupledStge_5_io_out_valid;
  assign arb_io_in_0_bits = DecoupledStge_5_io_out_bits;
  assign arb_io_in_1_valid = DecoupledStge_1_1_io_out_valid;
  assign arb_io_in_1_bits = DecoupledStge_1_1_io_out_bits;
  assign arb_io_in_2_valid = DecoupledStge_2_1_io_out_valid;
  assign arb_io_in_2_bits = DecoupledStge_2_1_io_out_bits;
  assign arb_io_in_3_valid = DecoupledStge_3_1_io_out_valid;
  assign arb_io_in_3_bits = DecoupledStge_3_1_io_out_bits;
  assign arb_io_out_ready = stage_out_io_inp_ready;
  assign stage_out_clock = clock;
  assign stage_out_reset = reset;
  assign stage_out_io_inp_valid = arb_io_out_valid;
  assign stage_out_io_inp_bits = arb_io_out_bits;
  assign stage_out_io_out_ready = io_qout_ready;
endmodule
module DecoupledStge_5(
  input   clock,
  input   reset,
  output  io_inp_ready,
  input   io_inp_valid,
  input  [140:0] io_inp_bits,
  input   io_out_ready,
  output  io_out_valid,
  output [140:0] io_out_bits
);
  reg  out_valid;
  reg [31:0] GEN_1;
  reg [140:0] out_bits;
  reg [159:0] GEN_2;
  wire  T_24;
  wire  T_25;
  wire  T_26;
  wire  T_27;
  wire [140:0] GEN_0;
  assign io_inp_ready = T_25;
  assign io_out_valid = out_valid;
  assign io_out_bits = out_bits;
  assign T_24 = ~ io_out_valid;
  assign T_25 = io_out_ready | T_24;
  assign T_26 = ~ io_inp_ready;
  assign T_27 = io_inp_valid | T_26;
  assign GEN_0 = io_inp_ready ? io_inp_bits : out_bits;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_1 = {1{$random}};
  out_valid = GEN_1[0:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_2 = {5{$random}};
  out_bits = GEN_2[140:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(reset) begin
      out_valid <= 1'h0;
    end else begin
      out_valid <= T_27;
    end
    if(1'h0) begin
    end else begin
      if(io_inp_ready) begin
        out_bits <= io_inp_bits;
      end
    end
  end
endmodule
module SteerReged(
  input   clock,
  input   reset,
  output  io_qin_ready,
  input   io_qin_valid,
  input  [140:0] io_qin_bits,
  input   io_qout_0_ready,
  output  io_qout_0_valid,
  output [140:0] io_qout_0_bits,
  input   io_qout_1_ready,
  output  io_qout_1_valid,
  output [140:0] io_qout_1_bits,
  input   io_qout_2_ready,
  output  io_qout_2_valid,
  output [140:0] io_qout_2_bits,
  input   io_qout_3_ready,
  output  io_qout_3_valid,
  output [140:0] io_qout_3_bits
);
  wire  DecoupledStge_5_1_clock;
  wire  DecoupledStge_5_1_reset;
  wire  DecoupledStge_5_1_io_inp_ready;
  wire  DecoupledStge_5_1_io_inp_valid;
  wire [140:0] DecoupledStge_5_1_io_inp_bits;
  wire  DecoupledStge_5_1_io_out_ready;
  wire  DecoupledStge_5_1_io_out_valid;
  wire [140:0] DecoupledStge_5_1_io_out_bits;
  wire  DecoupledStge_6_1_clock;
  wire  DecoupledStge_6_1_reset;
  wire  DecoupledStge_6_1_io_inp_ready;
  wire  DecoupledStge_6_1_io_inp_valid;
  wire [140:0] DecoupledStge_6_1_io_inp_bits;
  wire  DecoupledStge_6_1_io_out_ready;
  wire  DecoupledStge_6_1_io_out_valid;
  wire [140:0] DecoupledStge_6_1_io_out_bits;
  wire  DecoupledStge_7_1_clock;
  wire  DecoupledStge_7_1_reset;
  wire  DecoupledStge_7_1_io_inp_ready;
  wire  DecoupledStge_7_1_io_inp_valid;
  wire [140:0] DecoupledStge_7_1_io_inp_bits;
  wire  DecoupledStge_7_1_io_out_ready;
  wire  DecoupledStge_7_1_io_out_valid;
  wire [140:0] DecoupledStge_7_1_io_out_bits;
  wire  DecoupledStge_8_1_clock;
  wire  DecoupledStge_8_1_reset;
  wire  DecoupledStge_8_1_io_inp_ready;
  wire  DecoupledStge_8_1_io_inp_valid;
  wire [140:0] DecoupledStge_8_1_io_inp_bits;
  wire  DecoupledStge_8_1_io_out_ready;
  wire  DecoupledStge_8_1_io_out_valid;
  wire [140:0] DecoupledStge_8_1_io_out_bits;
  wire  out_stage_inps_0_ready;
  wire  out_stage_inps_0_valid;
  wire [140:0] out_stage_inps_0_bits;
  wire  out_stage_inps_1_ready;
  wire  out_stage_inps_1_valid;
  wire [140:0] out_stage_inps_1_bits;
  wire  out_stage_inps_2_ready;
  wire  out_stage_inps_2_valid;
  wire [140:0] out_stage_inps_2_bits;
  wire  out_stage_inps_3_ready;
  wire  out_stage_inps_3_valid;
  wire [140:0] out_stage_inps_3_bits;
  wire [140:0] T_129;
  wire [140:0] T_133;
  wire [140:0] T_137;
  wire [140:0] T_141;
  reg [140:0] pendData;
  reg [159:0] GEN_0;
  reg  pendValid;
  reg [31:0] GEN_3;
  wire [1:0] pendAuId;
  wire  GEN_0_ready;
  wire  GEN_0_valid;
  wire [140:0] GEN_0_bits;
  wire  GEN_4;
  wire  GEN_5;
  wire [140:0] GEN_6;
  wire  GEN_7;
  wire  GEN_8;
  wire [140:0] GEN_9;
  wire  GEN_10;
  wire  GEN_11;
  wire [140:0] GEN_12;
  wire  T_149;
  wire  GEN_1;
  wire  GEN_13;
  wire  GEN_14;
  wire  GEN_15;
  wire  GEN_16;
  wire [140:0] GEN_2;
  wire [140:0] GEN_17;
  wire [140:0] GEN_18;
  wire [140:0] GEN_19;
  wire [140:0] GEN_20;
  wire  GEN_25;
  wire  GEN_22;
  wire  GEN_23;
  wire  GEN_24;
  wire [140:0] GEN_29;
  wire [140:0] GEN_28;
  wire [140:0] GEN_30;
  wire [140:0] GEN_27;
  wire  GEN_3_ready;
  wire  GEN_3_valid;
  wire [140:0] GEN_3_bits;
  wire  T_163;
  wire  T_165;
  wire  T_166;
  wire [140:0] T_168;
  wire [140:0] GEN_31;
  wire  GEN_32;
  wire [140:0] GEN_35;
  DecoupledStge_5 DecoupledStge_5_1 (
    .clock(DecoupledStge_5_1_clock),
    .reset(DecoupledStge_5_1_reset),
    .io_inp_ready(DecoupledStge_5_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_5_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_5_1_io_inp_bits),
    .io_out_ready(DecoupledStge_5_1_io_out_ready),
    .io_out_valid(DecoupledStge_5_1_io_out_valid),
    .io_out_bits(DecoupledStge_5_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_6_1 (
    .clock(DecoupledStge_6_1_clock),
    .reset(DecoupledStge_6_1_reset),
    .io_inp_ready(DecoupledStge_6_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_6_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_6_1_io_inp_bits),
    .io_out_ready(DecoupledStge_6_1_io_out_ready),
    .io_out_valid(DecoupledStge_6_1_io_out_valid),
    .io_out_bits(DecoupledStge_6_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_7_1 (
    .clock(DecoupledStge_7_1_clock),
    .reset(DecoupledStge_7_1_reset),
    .io_inp_ready(DecoupledStge_7_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_7_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_7_1_io_inp_bits),
    .io_out_ready(DecoupledStge_7_1_io_out_ready),
    .io_out_valid(DecoupledStge_7_1_io_out_valid),
    .io_out_bits(DecoupledStge_7_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_8_1 (
    .clock(DecoupledStge_8_1_clock),
    .reset(DecoupledStge_8_1_reset),
    .io_inp_ready(DecoupledStge_8_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_8_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_8_1_io_inp_bits),
    .io_out_ready(DecoupledStge_8_1_io_out_ready),
    .io_out_valid(DecoupledStge_8_1_io_out_valid),
    .io_out_bits(DecoupledStge_8_1_io_out_bits)
  );
  assign io_qin_ready = T_166;
  assign io_qout_0_valid = DecoupledStge_5_1_io_out_valid;
  assign io_qout_0_bits = DecoupledStge_5_1_io_out_bits;
  assign io_qout_1_valid = DecoupledStge_6_1_io_out_valid;
  assign io_qout_1_bits = DecoupledStge_6_1_io_out_bits;
  assign io_qout_2_valid = DecoupledStge_7_1_io_out_valid;
  assign io_qout_2_bits = DecoupledStge_7_1_io_out_bits;
  assign io_qout_3_valid = DecoupledStge_8_1_io_out_valid;
  assign io_qout_3_bits = DecoupledStge_8_1_io_out_bits;
  assign DecoupledStge_5_1_clock = clock;
  assign DecoupledStge_5_1_reset = reset;
  assign DecoupledStge_5_1_io_inp_valid = out_stage_inps_0_valid;
  assign DecoupledStge_5_1_io_inp_bits = out_stage_inps_0_bits;
  assign DecoupledStge_5_1_io_out_ready = io_qout_0_ready;
  assign DecoupledStge_6_1_clock = clock;
  assign DecoupledStge_6_1_reset = reset;
  assign DecoupledStge_6_1_io_inp_valid = out_stage_inps_1_valid;
  assign DecoupledStge_6_1_io_inp_bits = out_stage_inps_1_bits;
  assign DecoupledStge_6_1_io_out_ready = io_qout_1_ready;
  assign DecoupledStge_7_1_clock = clock;
  assign DecoupledStge_7_1_reset = reset;
  assign DecoupledStge_7_1_io_inp_valid = out_stage_inps_2_valid;
  assign DecoupledStge_7_1_io_inp_bits = out_stage_inps_2_bits;
  assign DecoupledStge_7_1_io_out_ready = io_qout_2_ready;
  assign DecoupledStge_8_1_clock = clock;
  assign DecoupledStge_8_1_reset = reset;
  assign DecoupledStge_8_1_io_inp_valid = out_stage_inps_3_valid;
  assign DecoupledStge_8_1_io_inp_bits = out_stage_inps_3_bits;
  assign DecoupledStge_8_1_io_out_ready = io_qout_3_ready;
  assign out_stage_inps_0_ready = DecoupledStge_5_1_io_inp_ready;
  assign out_stage_inps_0_valid = GEN_22;
  assign out_stage_inps_0_bits = GEN_27;
  assign out_stage_inps_1_ready = DecoupledStge_6_1_io_inp_ready;
  assign out_stage_inps_1_valid = GEN_23;
  assign out_stage_inps_1_bits = GEN_28;
  assign out_stage_inps_2_ready = DecoupledStge_7_1_io_inp_ready;
  assign out_stage_inps_2_valid = GEN_24;
  assign out_stage_inps_2_bits = GEN_29;
  assign out_stage_inps_3_ready = DecoupledStge_8_1_io_inp_ready;
  assign out_stage_inps_3_valid = GEN_25;
  assign out_stage_inps_3_bits = GEN_30;
  assign T_129 = 141'h0;
  assign T_133 = 141'h0;
  assign T_137 = 141'h0;
  assign T_141 = 141'h0;
  assign pendAuId = pendData[131:130];
  assign GEN_0_ready = GEN_10;
  assign GEN_0_valid = GEN_11;
  assign GEN_0_bits = GEN_12;
  assign GEN_4 = 2'h1 == pendAuId ? out_stage_inps_1_ready : out_stage_inps_0_ready;
  assign GEN_5 = 2'h1 == pendAuId ? out_stage_inps_1_valid : out_stage_inps_0_valid;
  assign GEN_6 = 2'h1 == pendAuId ? out_stage_inps_1_bits : out_stage_inps_0_bits;
  assign GEN_7 = 2'h2 == pendAuId ? out_stage_inps_2_ready : GEN_4;
  assign GEN_8 = 2'h2 == pendAuId ? out_stage_inps_2_valid : GEN_5;
  assign GEN_9 = 2'h2 == pendAuId ? out_stage_inps_2_bits : GEN_6;
  assign GEN_10 = 2'h3 == pendAuId ? out_stage_inps_3_ready : GEN_7;
  assign GEN_11 = 2'h3 == pendAuId ? out_stage_inps_3_valid : GEN_8;
  assign GEN_12 = 2'h3 == pendAuId ? out_stage_inps_3_bits : GEN_9;
  assign T_149 = pendValid & GEN_0_ready;
  assign GEN_1 = 1'h1;
  assign GEN_13 = 2'h0 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_14 = 2'h1 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_15 = 2'h2 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_16 = 2'h3 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_2 = pendData;
  assign GEN_17 = 2'h0 == pendAuId ? GEN_2 : T_129;
  assign GEN_18 = 2'h1 == pendAuId ? GEN_2 : T_133;
  assign GEN_19 = 2'h2 == pendAuId ? GEN_2 : T_137;
  assign GEN_20 = 2'h3 == pendAuId ? GEN_2 : T_141;
  assign GEN_25 = T_149 ? GEN_16 : 1'h0;
  assign GEN_22 = T_149 ? GEN_13 : 1'h0;
  assign GEN_23 = T_149 ? GEN_14 : 1'h0;
  assign GEN_24 = T_149 ? GEN_15 : 1'h0;
  assign GEN_29 = T_149 ? GEN_19 : T_137;
  assign GEN_28 = T_149 ? GEN_18 : T_133;
  assign GEN_30 = T_149 ? GEN_20 : T_141;
  assign GEN_27 = T_149 ? GEN_17 : T_129;
  assign GEN_3_ready = GEN_10;
  assign GEN_3_valid = GEN_11;
  assign GEN_3_bits = GEN_12;
  assign T_163 = pendValid & GEN_3_ready;
  assign T_165 = pendValid == 1'h0;
  assign T_166 = T_163 | T_165;
  assign T_168 = io_qin_bits;
  assign GEN_31 = io_qin_valid ? T_168 : pendData;
  assign GEN_32 = T_166 ? io_qin_valid : pendValid;
  assign GEN_35 = T_166 ? GEN_31 : pendData;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_0 = {5{$random}};
  pendData = GEN_0[140:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_3 = {1{$random}};
  pendValid = GEN_3[0:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(1'h0) begin
    end else begin
      if(T_166) begin
        if(io_qin_valid) begin
          pendData <= T_168;
        end
      end
    end
    if(reset) begin
      pendValid <= 1'h0;
    end else begin
      if(T_166) begin
        pendValid <= io_qin_valid;
      end
    end
  end
endmodule
module SteerReged_1(
  input   clock,
  input   reset,
  output  io_qin_ready,
  input   io_qin_valid,
  input  [140:0] io_qin_bits,
  input   io_qout_0_ready,
  output  io_qout_0_valid,
  output [140:0] io_qout_0_bits,
  input   io_qout_1_ready,
  output  io_qout_1_valid,
  output [140:0] io_qout_1_bits,
  input   io_qout_2_ready,
  output  io_qout_2_valid,
  output [140:0] io_qout_2_bits,
  input   io_qout_3_ready,
  output  io_qout_3_valid,
  output [140:0] io_qout_3_bits
);
  wire  DecoupledStge_9_1_clock;
  wire  DecoupledStge_9_1_reset;
  wire  DecoupledStge_9_1_io_inp_ready;
  wire  DecoupledStge_9_1_io_inp_valid;
  wire [140:0] DecoupledStge_9_1_io_inp_bits;
  wire  DecoupledStge_9_1_io_out_ready;
  wire  DecoupledStge_9_1_io_out_valid;
  wire [140:0] DecoupledStge_9_1_io_out_bits;
  wire  DecoupledStge_10_1_clock;
  wire  DecoupledStge_10_1_reset;
  wire  DecoupledStge_10_1_io_inp_ready;
  wire  DecoupledStge_10_1_io_inp_valid;
  wire [140:0] DecoupledStge_10_1_io_inp_bits;
  wire  DecoupledStge_10_1_io_out_ready;
  wire  DecoupledStge_10_1_io_out_valid;
  wire [140:0] DecoupledStge_10_1_io_out_bits;
  wire  DecoupledStge_11_1_clock;
  wire  DecoupledStge_11_1_reset;
  wire  DecoupledStge_11_1_io_inp_ready;
  wire  DecoupledStge_11_1_io_inp_valid;
  wire [140:0] DecoupledStge_11_1_io_inp_bits;
  wire  DecoupledStge_11_1_io_out_ready;
  wire  DecoupledStge_11_1_io_out_valid;
  wire [140:0] DecoupledStge_11_1_io_out_bits;
  wire  DecoupledStge_12_1_clock;
  wire  DecoupledStge_12_1_reset;
  wire  DecoupledStge_12_1_io_inp_ready;
  wire  DecoupledStge_12_1_io_inp_valid;
  wire [140:0] DecoupledStge_12_1_io_inp_bits;
  wire  DecoupledStge_12_1_io_out_ready;
  wire  DecoupledStge_12_1_io_out_valid;
  wire [140:0] DecoupledStge_12_1_io_out_bits;
  wire  out_stage_inps_0_ready;
  wire  out_stage_inps_0_valid;
  wire [140:0] out_stage_inps_0_bits;
  wire  out_stage_inps_1_ready;
  wire  out_stage_inps_1_valid;
  wire [140:0] out_stage_inps_1_bits;
  wire  out_stage_inps_2_ready;
  wire  out_stage_inps_2_valid;
  wire [140:0] out_stage_inps_2_bits;
  wire  out_stage_inps_3_ready;
  wire  out_stage_inps_3_valid;
  wire [140:0] out_stage_inps_3_bits;
  wire [140:0] T_129;
  wire [140:0] T_133;
  wire [140:0] T_137;
  wire [140:0] T_141;
  reg [140:0] pendData;
  reg [159:0] GEN_0;
  reg  pendValid;
  reg [31:0] GEN_3;
  wire [1:0] pendAuId;
  wire  GEN_0_ready;
  wire  GEN_0_valid;
  wire [140:0] GEN_0_bits;
  wire  GEN_4;
  wire  GEN_5;
  wire [140:0] GEN_6;
  wire  GEN_7;
  wire  GEN_8;
  wire [140:0] GEN_9;
  wire  GEN_10;
  wire  GEN_11;
  wire [140:0] GEN_12;
  wire  T_149;
  wire  GEN_1;
  wire  GEN_13;
  wire  GEN_14;
  wire  GEN_15;
  wire  GEN_16;
  wire [140:0] GEN_2;
  wire [140:0] GEN_17;
  wire [140:0] GEN_18;
  wire [140:0] GEN_19;
  wire [140:0] GEN_20;
  wire  GEN_23;
  wire [140:0] GEN_30;
  wire [140:0] GEN_28;
  wire [140:0] GEN_29;
  wire  GEN_22;
  wire  GEN_24;
  wire  GEN_25;
  wire [140:0] GEN_27;
  wire  GEN_3_ready;
  wire  GEN_3_valid;
  wire [140:0] GEN_3_bits;
  wire  T_163;
  wire  T_165;
  wire  T_166;
  wire [140:0] T_168;
  wire [140:0] GEN_31;
  wire  GEN_32;
  wire [140:0] GEN_35;
  DecoupledStge_5 DecoupledStge_9_1 (
    .clock(DecoupledStge_9_1_clock),
    .reset(DecoupledStge_9_1_reset),
    .io_inp_ready(DecoupledStge_9_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_9_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_9_1_io_inp_bits),
    .io_out_ready(DecoupledStge_9_1_io_out_ready),
    .io_out_valid(DecoupledStge_9_1_io_out_valid),
    .io_out_bits(DecoupledStge_9_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_10_1 (
    .clock(DecoupledStge_10_1_clock),
    .reset(DecoupledStge_10_1_reset),
    .io_inp_ready(DecoupledStge_10_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_10_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_10_1_io_inp_bits),
    .io_out_ready(DecoupledStge_10_1_io_out_ready),
    .io_out_valid(DecoupledStge_10_1_io_out_valid),
    .io_out_bits(DecoupledStge_10_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_11_1 (
    .clock(DecoupledStge_11_1_clock),
    .reset(DecoupledStge_11_1_reset),
    .io_inp_ready(DecoupledStge_11_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_11_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_11_1_io_inp_bits),
    .io_out_ready(DecoupledStge_11_1_io_out_ready),
    .io_out_valid(DecoupledStge_11_1_io_out_valid),
    .io_out_bits(DecoupledStge_11_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_12_1 (
    .clock(DecoupledStge_12_1_clock),
    .reset(DecoupledStge_12_1_reset),
    .io_inp_ready(DecoupledStge_12_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_12_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_12_1_io_inp_bits),
    .io_out_ready(DecoupledStge_12_1_io_out_ready),
    .io_out_valid(DecoupledStge_12_1_io_out_valid),
    .io_out_bits(DecoupledStge_12_1_io_out_bits)
  );
  assign io_qin_ready = T_166;
  assign io_qout_0_valid = DecoupledStge_9_1_io_out_valid;
  assign io_qout_0_bits = DecoupledStge_9_1_io_out_bits;
  assign io_qout_1_valid = DecoupledStge_10_1_io_out_valid;
  assign io_qout_1_bits = DecoupledStge_10_1_io_out_bits;
  assign io_qout_2_valid = DecoupledStge_11_1_io_out_valid;
  assign io_qout_2_bits = DecoupledStge_11_1_io_out_bits;
  assign io_qout_3_valid = DecoupledStge_12_1_io_out_valid;
  assign io_qout_3_bits = DecoupledStge_12_1_io_out_bits;
  assign DecoupledStge_9_1_clock = clock;
  assign DecoupledStge_9_1_reset = reset;
  assign DecoupledStge_9_1_io_inp_valid = out_stage_inps_0_valid;
  assign DecoupledStge_9_1_io_inp_bits = out_stage_inps_0_bits;
  assign DecoupledStge_9_1_io_out_ready = io_qout_0_ready;
  assign DecoupledStge_10_1_clock = clock;
  assign DecoupledStge_10_1_reset = reset;
  assign DecoupledStge_10_1_io_inp_valid = out_stage_inps_1_valid;
  assign DecoupledStge_10_1_io_inp_bits = out_stage_inps_1_bits;
  assign DecoupledStge_10_1_io_out_ready = io_qout_1_ready;
  assign DecoupledStge_11_1_clock = clock;
  assign DecoupledStge_11_1_reset = reset;
  assign DecoupledStge_11_1_io_inp_valid = out_stage_inps_2_valid;
  assign DecoupledStge_11_1_io_inp_bits = out_stage_inps_2_bits;
  assign DecoupledStge_11_1_io_out_ready = io_qout_2_ready;
  assign DecoupledStge_12_1_clock = clock;
  assign DecoupledStge_12_1_reset = reset;
  assign DecoupledStge_12_1_io_inp_valid = out_stage_inps_3_valid;
  assign DecoupledStge_12_1_io_inp_bits = out_stage_inps_3_bits;
  assign DecoupledStge_12_1_io_out_ready = io_qout_3_ready;
  assign out_stage_inps_0_ready = DecoupledStge_9_1_io_inp_ready;
  assign out_stage_inps_0_valid = GEN_22;
  assign out_stage_inps_0_bits = GEN_27;
  assign out_stage_inps_1_ready = DecoupledStge_10_1_io_inp_ready;
  assign out_stage_inps_1_valid = GEN_23;
  assign out_stage_inps_1_bits = GEN_28;
  assign out_stage_inps_2_ready = DecoupledStge_11_1_io_inp_ready;
  assign out_stage_inps_2_valid = GEN_24;
  assign out_stage_inps_2_bits = GEN_29;
  assign out_stage_inps_3_ready = DecoupledStge_12_1_io_inp_ready;
  assign out_stage_inps_3_valid = GEN_25;
  assign out_stage_inps_3_bits = GEN_30;
  assign T_129 = 141'h0;
  assign T_133 = 141'h0;
  assign T_137 = 141'h0;
  assign T_141 = 141'h0;
  assign pendAuId = pendData[131:130];
  assign GEN_0_ready = GEN_10;
  assign GEN_0_valid = GEN_11;
  assign GEN_0_bits = GEN_12;
  assign GEN_4 = 2'h1 == pendAuId ? out_stage_inps_1_ready : out_stage_inps_0_ready;
  assign GEN_5 = 2'h1 == pendAuId ? out_stage_inps_1_valid : out_stage_inps_0_valid;
  assign GEN_6 = 2'h1 == pendAuId ? out_stage_inps_1_bits : out_stage_inps_0_bits;
  assign GEN_7 = 2'h2 == pendAuId ? out_stage_inps_2_ready : GEN_4;
  assign GEN_8 = 2'h2 == pendAuId ? out_stage_inps_2_valid : GEN_5;
  assign GEN_9 = 2'h2 == pendAuId ? out_stage_inps_2_bits : GEN_6;
  assign GEN_10 = 2'h3 == pendAuId ? out_stage_inps_3_ready : GEN_7;
  assign GEN_11 = 2'h3 == pendAuId ? out_stage_inps_3_valid : GEN_8;
  assign GEN_12 = 2'h3 == pendAuId ? out_stage_inps_3_bits : GEN_9;
  assign T_149 = pendValid & GEN_0_ready;
  assign GEN_1 = 1'h1;
  assign GEN_13 = 2'h0 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_14 = 2'h1 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_15 = 2'h2 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_16 = 2'h3 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_2 = pendData;
  assign GEN_17 = 2'h0 == pendAuId ? GEN_2 : T_129;
  assign GEN_18 = 2'h1 == pendAuId ? GEN_2 : T_133;
  assign GEN_19 = 2'h2 == pendAuId ? GEN_2 : T_137;
  assign GEN_20 = 2'h3 == pendAuId ? GEN_2 : T_141;
  assign GEN_23 = T_149 ? GEN_14 : 1'h0;
  assign GEN_30 = T_149 ? GEN_20 : T_141;
  assign GEN_28 = T_149 ? GEN_18 : T_133;
  assign GEN_29 = T_149 ? GEN_19 : T_137;
  assign GEN_22 = T_149 ? GEN_13 : 1'h0;
  assign GEN_24 = T_149 ? GEN_15 : 1'h0;
  assign GEN_25 = T_149 ? GEN_16 : 1'h0;
  assign GEN_27 = T_149 ? GEN_17 : T_129;
  assign GEN_3_ready = GEN_10;
  assign GEN_3_valid = GEN_11;
  assign GEN_3_bits = GEN_12;
  assign T_163 = pendValid & GEN_3_ready;
  assign T_165 = pendValid == 1'h0;
  assign T_166 = T_163 | T_165;
  assign T_168 = io_qin_bits;
  assign GEN_31 = io_qin_valid ? T_168 : pendData;
  assign GEN_32 = T_166 ? io_qin_valid : pendValid;
  assign GEN_35 = T_166 ? GEN_31 : pendData;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_0 = {5{$random}};
  pendData = GEN_0[140:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_3 = {1{$random}};
  pendValid = GEN_3[0:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(1'h0) begin
    end else begin
      if(T_166) begin
        if(io_qin_valid) begin
          pendData <= T_168;
        end
      end
    end
    if(reset) begin
      pendValid <= 1'h0;
    end else begin
      if(T_166) begin
        pendValid <= io_qin_valid;
      end
    end
  end
endmodule
module SteerReged_2(
  input   clock,
  input   reset,
  output  io_qin_ready,
  input   io_qin_valid,
  input  [140:0] io_qin_bits,
  input   io_qout_0_ready,
  output  io_qout_0_valid,
  output [140:0] io_qout_0_bits,
  input   io_qout_1_ready,
  output  io_qout_1_valid,
  output [140:0] io_qout_1_bits,
  input   io_qout_2_ready,
  output  io_qout_2_valid,
  output [140:0] io_qout_2_bits,
  input   io_qout_3_ready,
  output  io_qout_3_valid,
  output [140:0] io_qout_3_bits
);
  wire  DecoupledStge_13_1_clock;
  wire  DecoupledStge_13_1_reset;
  wire  DecoupledStge_13_1_io_inp_ready;
  wire  DecoupledStge_13_1_io_inp_valid;
  wire [140:0] DecoupledStge_13_1_io_inp_bits;
  wire  DecoupledStge_13_1_io_out_ready;
  wire  DecoupledStge_13_1_io_out_valid;
  wire [140:0] DecoupledStge_13_1_io_out_bits;
  wire  DecoupledStge_14_1_clock;
  wire  DecoupledStge_14_1_reset;
  wire  DecoupledStge_14_1_io_inp_ready;
  wire  DecoupledStge_14_1_io_inp_valid;
  wire [140:0] DecoupledStge_14_1_io_inp_bits;
  wire  DecoupledStge_14_1_io_out_ready;
  wire  DecoupledStge_14_1_io_out_valid;
  wire [140:0] DecoupledStge_14_1_io_out_bits;
  wire  DecoupledStge_15_1_clock;
  wire  DecoupledStge_15_1_reset;
  wire  DecoupledStge_15_1_io_inp_ready;
  wire  DecoupledStge_15_1_io_inp_valid;
  wire [140:0] DecoupledStge_15_1_io_inp_bits;
  wire  DecoupledStge_15_1_io_out_ready;
  wire  DecoupledStge_15_1_io_out_valid;
  wire [140:0] DecoupledStge_15_1_io_out_bits;
  wire  DecoupledStge_16_1_clock;
  wire  DecoupledStge_16_1_reset;
  wire  DecoupledStge_16_1_io_inp_ready;
  wire  DecoupledStge_16_1_io_inp_valid;
  wire [140:0] DecoupledStge_16_1_io_inp_bits;
  wire  DecoupledStge_16_1_io_out_ready;
  wire  DecoupledStge_16_1_io_out_valid;
  wire [140:0] DecoupledStge_16_1_io_out_bits;
  wire  out_stage_inps_0_ready;
  wire  out_stage_inps_0_valid;
  wire [140:0] out_stage_inps_0_bits;
  wire  out_stage_inps_1_ready;
  wire  out_stage_inps_1_valid;
  wire [140:0] out_stage_inps_1_bits;
  wire  out_stage_inps_2_ready;
  wire  out_stage_inps_2_valid;
  wire [140:0] out_stage_inps_2_bits;
  wire  out_stage_inps_3_ready;
  wire  out_stage_inps_3_valid;
  wire [140:0] out_stage_inps_3_bits;
  wire [140:0] T_129;
  wire [140:0] T_133;
  wire [140:0] T_137;
  wire [140:0] T_141;
  reg [140:0] pendData;
  reg [159:0] GEN_0;
  reg  pendValid;
  reg [31:0] GEN_3;
  wire [1:0] pendAuId;
  wire  GEN_0_ready;
  wire  GEN_0_valid;
  wire [140:0] GEN_0_bits;
  wire  GEN_4;
  wire  GEN_5;
  wire [140:0] GEN_6;
  wire  GEN_7;
  wire  GEN_8;
  wire [140:0] GEN_9;
  wire  GEN_10;
  wire  GEN_11;
  wire [140:0] GEN_12;
  wire  T_149;
  wire  GEN_1;
  wire  GEN_13;
  wire  GEN_14;
  wire  GEN_15;
  wire  GEN_16;
  wire [140:0] GEN_2;
  wire [140:0] GEN_17;
  wire [140:0] GEN_18;
  wire [140:0] GEN_19;
  wire [140:0] GEN_20;
  wire  GEN_25;
  wire  GEN_23;
  wire  GEN_24;
  wire [140:0] GEN_30;
  wire  GEN_22;
  wire [140:0] GEN_28;
  wire [140:0] GEN_27;
  wire [140:0] GEN_29;
  wire  GEN_3_ready;
  wire  GEN_3_valid;
  wire [140:0] GEN_3_bits;
  wire  T_163;
  wire  T_165;
  wire  T_166;
  wire [140:0] T_168;
  wire [140:0] GEN_31;
  wire  GEN_32;
  wire [140:0] GEN_35;
  DecoupledStge_5 DecoupledStge_13_1 (
    .clock(DecoupledStge_13_1_clock),
    .reset(DecoupledStge_13_1_reset),
    .io_inp_ready(DecoupledStge_13_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_13_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_13_1_io_inp_bits),
    .io_out_ready(DecoupledStge_13_1_io_out_ready),
    .io_out_valid(DecoupledStge_13_1_io_out_valid),
    .io_out_bits(DecoupledStge_13_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_14_1 (
    .clock(DecoupledStge_14_1_clock),
    .reset(DecoupledStge_14_1_reset),
    .io_inp_ready(DecoupledStge_14_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_14_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_14_1_io_inp_bits),
    .io_out_ready(DecoupledStge_14_1_io_out_ready),
    .io_out_valid(DecoupledStge_14_1_io_out_valid),
    .io_out_bits(DecoupledStge_14_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_15_1 (
    .clock(DecoupledStge_15_1_clock),
    .reset(DecoupledStge_15_1_reset),
    .io_inp_ready(DecoupledStge_15_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_15_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_15_1_io_inp_bits),
    .io_out_ready(DecoupledStge_15_1_io_out_ready),
    .io_out_valid(DecoupledStge_15_1_io_out_valid),
    .io_out_bits(DecoupledStge_15_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_16_1 (
    .clock(DecoupledStge_16_1_clock),
    .reset(DecoupledStge_16_1_reset),
    .io_inp_ready(DecoupledStge_16_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_16_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_16_1_io_inp_bits),
    .io_out_ready(DecoupledStge_16_1_io_out_ready),
    .io_out_valid(DecoupledStge_16_1_io_out_valid),
    .io_out_bits(DecoupledStge_16_1_io_out_bits)
  );
  assign io_qin_ready = T_166;
  assign io_qout_0_valid = DecoupledStge_13_1_io_out_valid;
  assign io_qout_0_bits = DecoupledStge_13_1_io_out_bits;
  assign io_qout_1_valid = DecoupledStge_14_1_io_out_valid;
  assign io_qout_1_bits = DecoupledStge_14_1_io_out_bits;
  assign io_qout_2_valid = DecoupledStge_15_1_io_out_valid;
  assign io_qout_2_bits = DecoupledStge_15_1_io_out_bits;
  assign io_qout_3_valid = DecoupledStge_16_1_io_out_valid;
  assign io_qout_3_bits = DecoupledStge_16_1_io_out_bits;
  assign DecoupledStge_13_1_clock = clock;
  assign DecoupledStge_13_1_reset = reset;
  assign DecoupledStge_13_1_io_inp_valid = out_stage_inps_0_valid;
  assign DecoupledStge_13_1_io_inp_bits = out_stage_inps_0_bits;
  assign DecoupledStge_13_1_io_out_ready = io_qout_0_ready;
  assign DecoupledStge_14_1_clock = clock;
  assign DecoupledStge_14_1_reset = reset;
  assign DecoupledStge_14_1_io_inp_valid = out_stage_inps_1_valid;
  assign DecoupledStge_14_1_io_inp_bits = out_stage_inps_1_bits;
  assign DecoupledStge_14_1_io_out_ready = io_qout_1_ready;
  assign DecoupledStge_15_1_clock = clock;
  assign DecoupledStge_15_1_reset = reset;
  assign DecoupledStge_15_1_io_inp_valid = out_stage_inps_2_valid;
  assign DecoupledStge_15_1_io_inp_bits = out_stage_inps_2_bits;
  assign DecoupledStge_15_1_io_out_ready = io_qout_2_ready;
  assign DecoupledStge_16_1_clock = clock;
  assign DecoupledStge_16_1_reset = reset;
  assign DecoupledStge_16_1_io_inp_valid = out_stage_inps_3_valid;
  assign DecoupledStge_16_1_io_inp_bits = out_stage_inps_3_bits;
  assign DecoupledStge_16_1_io_out_ready = io_qout_3_ready;
  assign out_stage_inps_0_ready = DecoupledStge_13_1_io_inp_ready;
  assign out_stage_inps_0_valid = GEN_22;
  assign out_stage_inps_0_bits = GEN_27;
  assign out_stage_inps_1_ready = DecoupledStge_14_1_io_inp_ready;
  assign out_stage_inps_1_valid = GEN_23;
  assign out_stage_inps_1_bits = GEN_28;
  assign out_stage_inps_2_ready = DecoupledStge_15_1_io_inp_ready;
  assign out_stage_inps_2_valid = GEN_24;
  assign out_stage_inps_2_bits = GEN_29;
  assign out_stage_inps_3_ready = DecoupledStge_16_1_io_inp_ready;
  assign out_stage_inps_3_valid = GEN_25;
  assign out_stage_inps_3_bits = GEN_30;
  assign T_129 = 141'h0;
  assign T_133 = 141'h0;
  assign T_137 = 141'h0;
  assign T_141 = 141'h0;
  assign pendAuId = pendData[131:130];
  assign GEN_0_ready = GEN_10;
  assign GEN_0_valid = GEN_11;
  assign GEN_0_bits = GEN_12;
  assign GEN_4 = 2'h1 == pendAuId ? out_stage_inps_1_ready : out_stage_inps_0_ready;
  assign GEN_5 = 2'h1 == pendAuId ? out_stage_inps_1_valid : out_stage_inps_0_valid;
  assign GEN_6 = 2'h1 == pendAuId ? out_stage_inps_1_bits : out_stage_inps_0_bits;
  assign GEN_7 = 2'h2 == pendAuId ? out_stage_inps_2_ready : GEN_4;
  assign GEN_8 = 2'h2 == pendAuId ? out_stage_inps_2_valid : GEN_5;
  assign GEN_9 = 2'h2 == pendAuId ? out_stage_inps_2_bits : GEN_6;
  assign GEN_10 = 2'h3 == pendAuId ? out_stage_inps_3_ready : GEN_7;
  assign GEN_11 = 2'h3 == pendAuId ? out_stage_inps_3_valid : GEN_8;
  assign GEN_12 = 2'h3 == pendAuId ? out_stage_inps_3_bits : GEN_9;
  assign T_149 = pendValid & GEN_0_ready;
  assign GEN_1 = 1'h1;
  assign GEN_13 = 2'h0 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_14 = 2'h1 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_15 = 2'h2 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_16 = 2'h3 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_2 = pendData;
  assign GEN_17 = 2'h0 == pendAuId ? GEN_2 : T_129;
  assign GEN_18 = 2'h1 == pendAuId ? GEN_2 : T_133;
  assign GEN_19 = 2'h2 == pendAuId ? GEN_2 : T_137;
  assign GEN_20 = 2'h3 == pendAuId ? GEN_2 : T_141;
  assign GEN_25 = T_149 ? GEN_16 : 1'h0;
  assign GEN_23 = T_149 ? GEN_14 : 1'h0;
  assign GEN_24 = T_149 ? GEN_15 : 1'h0;
  assign GEN_30 = T_149 ? GEN_20 : T_141;
  assign GEN_22 = T_149 ? GEN_13 : 1'h0;
  assign GEN_28 = T_149 ? GEN_18 : T_133;
  assign GEN_27 = T_149 ? GEN_17 : T_129;
  assign GEN_29 = T_149 ? GEN_19 : T_137;
  assign GEN_3_ready = GEN_10;
  assign GEN_3_valid = GEN_11;
  assign GEN_3_bits = GEN_12;
  assign T_163 = pendValid & GEN_3_ready;
  assign T_165 = pendValid == 1'h0;
  assign T_166 = T_163 | T_165;
  assign T_168 = io_qin_bits;
  assign GEN_31 = io_qin_valid ? T_168 : pendData;
  assign GEN_32 = T_166 ? io_qin_valid : pendValid;
  assign GEN_35 = T_166 ? GEN_31 : pendData;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_0 = {5{$random}};
  pendData = GEN_0[140:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_3 = {1{$random}};
  pendValid = GEN_3[0:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(1'h0) begin
    end else begin
      if(T_166) begin
        if(io_qin_valid) begin
          pendData <= T_168;
        end
      end
    end
    if(reset) begin
      pendValid <= 1'h0;
    end else begin
      if(T_166) begin
        pendValid <= io_qin_valid;
      end
    end
  end
endmodule
module SteerReged_3(
  input   clock,
  input   reset,
  output  io_qin_ready,
  input   io_qin_valid,
  input  [140:0] io_qin_bits,
  input   io_qout_0_ready,
  output  io_qout_0_valid,
  output [140:0] io_qout_0_bits,
  input   io_qout_1_ready,
  output  io_qout_1_valid,
  output [140:0] io_qout_1_bits,
  input   io_qout_2_ready,
  output  io_qout_2_valid,
  output [140:0] io_qout_2_bits,
  input   io_qout_3_ready,
  output  io_qout_3_valid,
  output [140:0] io_qout_3_bits
);
  wire  DecoupledStge_17_1_clock;
  wire  DecoupledStge_17_1_reset;
  wire  DecoupledStge_17_1_io_inp_ready;
  wire  DecoupledStge_17_1_io_inp_valid;
  wire [140:0] DecoupledStge_17_1_io_inp_bits;
  wire  DecoupledStge_17_1_io_out_ready;
  wire  DecoupledStge_17_1_io_out_valid;
  wire [140:0] DecoupledStge_17_1_io_out_bits;
  wire  DecoupledStge_18_1_clock;
  wire  DecoupledStge_18_1_reset;
  wire  DecoupledStge_18_1_io_inp_ready;
  wire  DecoupledStge_18_1_io_inp_valid;
  wire [140:0] DecoupledStge_18_1_io_inp_bits;
  wire  DecoupledStge_18_1_io_out_ready;
  wire  DecoupledStge_18_1_io_out_valid;
  wire [140:0] DecoupledStge_18_1_io_out_bits;
  wire  DecoupledStge_19_1_clock;
  wire  DecoupledStge_19_1_reset;
  wire  DecoupledStge_19_1_io_inp_ready;
  wire  DecoupledStge_19_1_io_inp_valid;
  wire [140:0] DecoupledStge_19_1_io_inp_bits;
  wire  DecoupledStge_19_1_io_out_ready;
  wire  DecoupledStge_19_1_io_out_valid;
  wire [140:0] DecoupledStge_19_1_io_out_bits;
  wire  DecoupledStge_20_1_clock;
  wire  DecoupledStge_20_1_reset;
  wire  DecoupledStge_20_1_io_inp_ready;
  wire  DecoupledStge_20_1_io_inp_valid;
  wire [140:0] DecoupledStge_20_1_io_inp_bits;
  wire  DecoupledStge_20_1_io_out_ready;
  wire  DecoupledStge_20_1_io_out_valid;
  wire [140:0] DecoupledStge_20_1_io_out_bits;
  wire  out_stage_inps_0_ready;
  wire  out_stage_inps_0_valid;
  wire [140:0] out_stage_inps_0_bits;
  wire  out_stage_inps_1_ready;
  wire  out_stage_inps_1_valid;
  wire [140:0] out_stage_inps_1_bits;
  wire  out_stage_inps_2_ready;
  wire  out_stage_inps_2_valid;
  wire [140:0] out_stage_inps_2_bits;
  wire  out_stage_inps_3_ready;
  wire  out_stage_inps_3_valid;
  wire [140:0] out_stage_inps_3_bits;
  wire [140:0] T_129;
  wire [140:0] T_133;
  wire [140:0] T_137;
  wire [140:0] T_141;
  reg [140:0] pendData;
  reg [159:0] GEN_0;
  reg  pendValid;
  reg [31:0] GEN_3;
  wire [1:0] pendAuId;
  wire  GEN_0_ready;
  wire  GEN_0_valid;
  wire [140:0] GEN_0_bits;
  wire  GEN_4;
  wire  GEN_5;
  wire [140:0] GEN_6;
  wire  GEN_7;
  wire  GEN_8;
  wire [140:0] GEN_9;
  wire  GEN_10;
  wire  GEN_11;
  wire [140:0] GEN_12;
  wire  T_149;
  wire  GEN_1;
  wire  GEN_13;
  wire  GEN_14;
  wire  GEN_15;
  wire  GEN_16;
  wire [140:0] GEN_2;
  wire [140:0] GEN_17;
  wire [140:0] GEN_18;
  wire [140:0] GEN_19;
  wire [140:0] GEN_20;
  wire  GEN_25;
  wire  GEN_24;
  wire [140:0] GEN_29;
  wire [140:0] GEN_30;
  wire [140:0] GEN_27;
  wire  GEN_23;
  wire [140:0] GEN_28;
  wire  GEN_22;
  wire  GEN_3_ready;
  wire  GEN_3_valid;
  wire [140:0] GEN_3_bits;
  wire  T_163;
  wire  T_165;
  wire  T_166;
  wire [140:0] T_168;
  wire [140:0] GEN_31;
  wire  GEN_32;
  wire [140:0] GEN_35;
  DecoupledStge_5 DecoupledStge_17_1 (
    .clock(DecoupledStge_17_1_clock),
    .reset(DecoupledStge_17_1_reset),
    .io_inp_ready(DecoupledStge_17_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_17_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_17_1_io_inp_bits),
    .io_out_ready(DecoupledStge_17_1_io_out_ready),
    .io_out_valid(DecoupledStge_17_1_io_out_valid),
    .io_out_bits(DecoupledStge_17_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_18_1 (
    .clock(DecoupledStge_18_1_clock),
    .reset(DecoupledStge_18_1_reset),
    .io_inp_ready(DecoupledStge_18_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_18_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_18_1_io_inp_bits),
    .io_out_ready(DecoupledStge_18_1_io_out_ready),
    .io_out_valid(DecoupledStge_18_1_io_out_valid),
    .io_out_bits(DecoupledStge_18_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_19_1 (
    .clock(DecoupledStge_19_1_clock),
    .reset(DecoupledStge_19_1_reset),
    .io_inp_ready(DecoupledStge_19_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_19_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_19_1_io_inp_bits),
    .io_out_ready(DecoupledStge_19_1_io_out_ready),
    .io_out_valid(DecoupledStge_19_1_io_out_valid),
    .io_out_bits(DecoupledStge_19_1_io_out_bits)
  );
  DecoupledStge_5 DecoupledStge_20_1 (
    .clock(DecoupledStge_20_1_clock),
    .reset(DecoupledStge_20_1_reset),
    .io_inp_ready(DecoupledStge_20_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_20_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_20_1_io_inp_bits),
    .io_out_ready(DecoupledStge_20_1_io_out_ready),
    .io_out_valid(DecoupledStge_20_1_io_out_valid),
    .io_out_bits(DecoupledStge_20_1_io_out_bits)
  );
  assign io_qin_ready = T_166;
  assign io_qout_0_valid = DecoupledStge_17_1_io_out_valid;
  assign io_qout_0_bits = DecoupledStge_17_1_io_out_bits;
  assign io_qout_1_valid = DecoupledStge_18_1_io_out_valid;
  assign io_qout_1_bits = DecoupledStge_18_1_io_out_bits;
  assign io_qout_2_valid = DecoupledStge_19_1_io_out_valid;
  assign io_qout_2_bits = DecoupledStge_19_1_io_out_bits;
  assign io_qout_3_valid = DecoupledStge_20_1_io_out_valid;
  assign io_qout_3_bits = DecoupledStge_20_1_io_out_bits;
  assign DecoupledStge_17_1_clock = clock;
  assign DecoupledStge_17_1_reset = reset;
  assign DecoupledStge_17_1_io_inp_valid = out_stage_inps_0_valid;
  assign DecoupledStge_17_1_io_inp_bits = out_stage_inps_0_bits;
  assign DecoupledStge_17_1_io_out_ready = io_qout_0_ready;
  assign DecoupledStge_18_1_clock = clock;
  assign DecoupledStge_18_1_reset = reset;
  assign DecoupledStge_18_1_io_inp_valid = out_stage_inps_1_valid;
  assign DecoupledStge_18_1_io_inp_bits = out_stage_inps_1_bits;
  assign DecoupledStge_18_1_io_out_ready = io_qout_1_ready;
  assign DecoupledStge_19_1_clock = clock;
  assign DecoupledStge_19_1_reset = reset;
  assign DecoupledStge_19_1_io_inp_valid = out_stage_inps_2_valid;
  assign DecoupledStge_19_1_io_inp_bits = out_stage_inps_2_bits;
  assign DecoupledStge_19_1_io_out_ready = io_qout_2_ready;
  assign DecoupledStge_20_1_clock = clock;
  assign DecoupledStge_20_1_reset = reset;
  assign DecoupledStge_20_1_io_inp_valid = out_stage_inps_3_valid;
  assign DecoupledStge_20_1_io_inp_bits = out_stage_inps_3_bits;
  assign DecoupledStge_20_1_io_out_ready = io_qout_3_ready;
  assign out_stage_inps_0_ready = DecoupledStge_17_1_io_inp_ready;
  assign out_stage_inps_0_valid = GEN_22;
  assign out_stage_inps_0_bits = GEN_27;
  assign out_stage_inps_1_ready = DecoupledStge_18_1_io_inp_ready;
  assign out_stage_inps_1_valid = GEN_23;
  assign out_stage_inps_1_bits = GEN_28;
  assign out_stage_inps_2_ready = DecoupledStge_19_1_io_inp_ready;
  assign out_stage_inps_2_valid = GEN_24;
  assign out_stage_inps_2_bits = GEN_29;
  assign out_stage_inps_3_ready = DecoupledStge_20_1_io_inp_ready;
  assign out_stage_inps_3_valid = GEN_25;
  assign out_stage_inps_3_bits = GEN_30;
  assign T_129 = 141'h0;
  assign T_133 = 141'h0;
  assign T_137 = 141'h0;
  assign T_141 = 141'h0;
  assign pendAuId = pendData[131:130];
  assign GEN_0_ready = GEN_10;
  assign GEN_0_valid = GEN_11;
  assign GEN_0_bits = GEN_12;
  assign GEN_4 = 2'h1 == pendAuId ? out_stage_inps_1_ready : out_stage_inps_0_ready;
  assign GEN_5 = 2'h1 == pendAuId ? out_stage_inps_1_valid : out_stage_inps_0_valid;
  assign GEN_6 = 2'h1 == pendAuId ? out_stage_inps_1_bits : out_stage_inps_0_bits;
  assign GEN_7 = 2'h2 == pendAuId ? out_stage_inps_2_ready : GEN_4;
  assign GEN_8 = 2'h2 == pendAuId ? out_stage_inps_2_valid : GEN_5;
  assign GEN_9 = 2'h2 == pendAuId ? out_stage_inps_2_bits : GEN_6;
  assign GEN_10 = 2'h3 == pendAuId ? out_stage_inps_3_ready : GEN_7;
  assign GEN_11 = 2'h3 == pendAuId ? out_stage_inps_3_valid : GEN_8;
  assign GEN_12 = 2'h3 == pendAuId ? out_stage_inps_3_bits : GEN_9;
  assign T_149 = pendValid & GEN_0_ready;
  assign GEN_1 = 1'h1;
  assign GEN_13 = 2'h0 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_14 = 2'h1 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_15 = 2'h2 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_16 = 2'h3 == pendAuId ? GEN_1 : 1'h0;
  assign GEN_2 = pendData;
  assign GEN_17 = 2'h0 == pendAuId ? GEN_2 : T_129;
  assign GEN_18 = 2'h1 == pendAuId ? GEN_2 : T_133;
  assign GEN_19 = 2'h2 == pendAuId ? GEN_2 : T_137;
  assign GEN_20 = 2'h3 == pendAuId ? GEN_2 : T_141;
  assign GEN_25 = T_149 ? GEN_16 : 1'h0;
  assign GEN_24 = T_149 ? GEN_15 : 1'h0;
  assign GEN_29 = T_149 ? GEN_19 : T_137;
  assign GEN_30 = T_149 ? GEN_20 : T_141;
  assign GEN_27 = T_149 ? GEN_17 : T_129;
  assign GEN_23 = T_149 ? GEN_14 : 1'h0;
  assign GEN_28 = T_149 ? GEN_18 : T_133;
  assign GEN_22 = T_149 ? GEN_13 : 1'h0;
  assign GEN_3_ready = GEN_10;
  assign GEN_3_valid = GEN_11;
  assign GEN_3_bits = GEN_12;
  assign T_163 = pendValid & GEN_3_ready;
  assign T_165 = pendValid == 1'h0;
  assign T_166 = T_163 | T_165;
  assign T_168 = io_qin_bits;
  assign GEN_31 = io_qin_valid ? T_168 : pendData;
  assign GEN_32 = T_166 ? io_qin_valid : pendValid;
  assign GEN_35 = T_166 ? GEN_31 : pendData;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_0 = {5{$random}};
  pendData = GEN_0[140:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_3 = {1{$random}};
  pendValid = GEN_3[0:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(1'h0) begin
    end else begin
      if(T_166) begin
        if(io_qin_valid) begin
          pendData <= T_168;
        end
      end
    end
    if(reset) begin
      pendValid <= 1'h0;
    end else begin
      if(T_166) begin
        pendValid <= io_qin_valid;
      end
    end
  end
endmodule
module SteerRegedSplit(
  input   clock,
  input   reset,
  output  io_qin_ready,
  input   io_qin_valid,
  input  [527:0] io_qin_bits,
  input   io_qout_0_ready,
  output  io_qout_0_valid,
  output [527:0] io_qout_0_bits,
  input   io_qout_1_ready,
  output  io_qout_1_valid,
  output [527:0] io_qout_1_bits,
  input   io_qout_2_ready,
  output  io_qout_2_valid,
  output [527:0] io_qout_2_bits,
  input   io_qout_3_ready,
  output  io_qout_3_valid,
  output [527:0] io_qout_3_bits
);
  wire  SteerReged_4_clock;
  wire  SteerReged_4_reset;
  wire  SteerReged_4_io_qin_ready;
  wire  SteerReged_4_io_qin_valid;
  wire [140:0] SteerReged_4_io_qin_bits;
  wire  SteerReged_4_io_qout_0_ready;
  wire  SteerReged_4_io_qout_0_valid;
  wire [140:0] SteerReged_4_io_qout_0_bits;
  wire  SteerReged_4_io_qout_1_ready;
  wire  SteerReged_4_io_qout_1_valid;
  wire [140:0] SteerReged_4_io_qout_1_bits;
  wire  SteerReged_4_io_qout_2_ready;
  wire  SteerReged_4_io_qout_2_valid;
  wire [140:0] SteerReged_4_io_qout_2_bits;
  wire  SteerReged_4_io_qout_3_ready;
  wire  SteerReged_4_io_qout_3_valid;
  wire [140:0] SteerReged_4_io_qout_3_bits;
  wire  SteerReged_1_1_clock;
  wire  SteerReged_1_1_reset;
  wire  SteerReged_1_1_io_qin_ready;
  wire  SteerReged_1_1_io_qin_valid;
  wire [140:0] SteerReged_1_1_io_qin_bits;
  wire  SteerReged_1_1_io_qout_0_ready;
  wire  SteerReged_1_1_io_qout_0_valid;
  wire [140:0] SteerReged_1_1_io_qout_0_bits;
  wire  SteerReged_1_1_io_qout_1_ready;
  wire  SteerReged_1_1_io_qout_1_valid;
  wire [140:0] SteerReged_1_1_io_qout_1_bits;
  wire  SteerReged_1_1_io_qout_2_ready;
  wire  SteerReged_1_1_io_qout_2_valid;
  wire [140:0] SteerReged_1_1_io_qout_2_bits;
  wire  SteerReged_1_1_io_qout_3_ready;
  wire  SteerReged_1_1_io_qout_3_valid;
  wire [140:0] SteerReged_1_1_io_qout_3_bits;
  wire  SteerReged_2_1_clock;
  wire  SteerReged_2_1_reset;
  wire  SteerReged_2_1_io_qin_ready;
  wire  SteerReged_2_1_io_qin_valid;
  wire [140:0] SteerReged_2_1_io_qin_bits;
  wire  SteerReged_2_1_io_qout_0_ready;
  wire  SteerReged_2_1_io_qout_0_valid;
  wire [140:0] SteerReged_2_1_io_qout_0_bits;
  wire  SteerReged_2_1_io_qout_1_ready;
  wire  SteerReged_2_1_io_qout_1_valid;
  wire [140:0] SteerReged_2_1_io_qout_1_bits;
  wire  SteerReged_2_1_io_qout_2_ready;
  wire  SteerReged_2_1_io_qout_2_valid;
  wire [140:0] SteerReged_2_1_io_qout_2_bits;
  wire  SteerReged_2_1_io_qout_3_ready;
  wire  SteerReged_2_1_io_qout_3_valid;
  wire [140:0] SteerReged_2_1_io_qout_3_bits;
  wire  SteerReged_3_1_clock;
  wire  SteerReged_3_1_reset;
  wire  SteerReged_3_1_io_qin_ready;
  wire  SteerReged_3_1_io_qin_valid;
  wire [140:0] SteerReged_3_1_io_qin_bits;
  wire  SteerReged_3_1_io_qout_0_ready;
  wire  SteerReged_3_1_io_qout_0_valid;
  wire [140:0] SteerReged_3_1_io_qout_0_bits;
  wire  SteerReged_3_1_io_qout_1_ready;
  wire  SteerReged_3_1_io_qout_1_valid;
  wire [140:0] SteerReged_3_1_io_qout_1_bits;
  wire  SteerReged_3_1_io_qout_2_ready;
  wire  SteerReged_3_1_io_qout_2_valid;
  wire [140:0] SteerReged_3_1_io_qout_2_bits;
  wire  SteerReged_3_1_io_qout_3_ready;
  wire  SteerReged_3_1_io_qout_3_valid;
  wire [140:0] SteerReged_3_1_io_qout_3_bits;
  wire  steer_submod_ins_0_ready;
  wire  steer_submod_ins_0_valid;
  wire [140:0] steer_submod_ins_0_bits;
  wire  steer_submod_ins_1_ready;
  wire  steer_submod_ins_1_valid;
  wire [140:0] steer_submod_ins_1_bits;
  wire  steer_submod_ins_2_ready;
  wire  steer_submod_ins_2_valid;
  wire [140:0] steer_submod_ins_2_bits;
  wire  steer_submod_ins_3_ready;
  wire  steer_submod_ins_3_valid;
  wire [140:0] steer_submod_ins_3_bits;
  wire  steer_submod_outs_0_0_ready;
  wire  steer_submod_outs_0_0_valid;
  wire [140:0] steer_submod_outs_0_0_bits;
  wire  steer_submod_outs_0_1_ready;
  wire  steer_submod_outs_0_1_valid;
  wire [140:0] steer_submod_outs_0_1_bits;
  wire  steer_submod_outs_0_2_ready;
  wire  steer_submod_outs_0_2_valid;
  wire [140:0] steer_submod_outs_0_2_bits;
  wire  steer_submod_outs_0_3_ready;
  wire  steer_submod_outs_0_3_valid;
  wire [140:0] steer_submod_outs_0_3_bits;
  wire  steer_submod_outs_1_0_ready;
  wire  steer_submod_outs_1_0_valid;
  wire [140:0] steer_submod_outs_1_0_bits;
  wire  steer_submod_outs_1_1_ready;
  wire  steer_submod_outs_1_1_valid;
  wire [140:0] steer_submod_outs_1_1_bits;
  wire  steer_submod_outs_1_2_ready;
  wire  steer_submod_outs_1_2_valid;
  wire [140:0] steer_submod_outs_1_2_bits;
  wire  steer_submod_outs_1_3_ready;
  wire  steer_submod_outs_1_3_valid;
  wire [140:0] steer_submod_outs_1_3_bits;
  wire  steer_submod_outs_2_0_ready;
  wire  steer_submod_outs_2_0_valid;
  wire [140:0] steer_submod_outs_2_0_bits;
  wire  steer_submod_outs_2_1_ready;
  wire  steer_submod_outs_2_1_valid;
  wire [140:0] steer_submod_outs_2_1_bits;
  wire  steer_submod_outs_2_2_ready;
  wire  steer_submod_outs_2_2_valid;
  wire [140:0] steer_submod_outs_2_2_bits;
  wire  steer_submod_outs_2_3_ready;
  wire  steer_submod_outs_2_3_valid;
  wire [140:0] steer_submod_outs_2_3_bits;
  wire  steer_submod_outs_3_0_ready;
  wire  steer_submod_outs_3_0_valid;
  wire [140:0] steer_submod_outs_3_0_bits;
  wire  steer_submod_outs_3_1_ready;
  wire  steer_submod_outs_3_1_valid;
  wire [140:0] steer_submod_outs_3_1_bits;
  wire  steer_submod_outs_3_2_ready;
  wire  steer_submod_outs_3_2_valid;
  wire [140:0] steer_submod_outs_3_2_bits;
  wire  steer_submod_outs_3_3_ready;
  wire  steer_submod_outs_3_3_valid;
  wire [140:0] steer_submod_outs_3_3_bits;
  wire [129:0] T_474;
  wire [129:0] T_475;
  wire [10:0] T_476;
  wire [140:0] T_477;
  wire [129:0] T_478;
  wire [129:0] T_479;
  wire [140:0] T_481;
  wire [129:0] T_482;
  wire [129:0] T_483;
  wire [140:0] T_485;
  wire [129:0] T_486;
  wire [129:0] T_487;
  wire [140:0] T_489;
  wire [128:0] T_502;
  wire [128:0] T_503;
  wire [128:0] T_504;
  wire [257:0] T_506;
  wire [386:0] T_507;
  wire [527:0] T_508;
  wire [128:0] T_509;
  wire [128:0] T_510;
  wire [128:0] T_511;
  wire [257:0] T_513;
  wire [386:0] T_514;
  wire [527:0] T_515;
  wire [128:0] T_516;
  wire [128:0] T_517;
  wire [128:0] T_518;
  wire [257:0] T_520;
  wire [386:0] T_521;
  wire [527:0] T_522;
  wire [128:0] T_523;
  wire [128:0] T_524;
  wire [128:0] T_525;
  wire [257:0] T_527;
  wire [386:0] T_528;
  wire [527:0] T_529;
  SteerReged SteerReged_4 (
    .clock(SteerReged_4_clock),
    .reset(SteerReged_4_reset),
    .io_qin_ready(SteerReged_4_io_qin_ready),
    .io_qin_valid(SteerReged_4_io_qin_valid),
    .io_qin_bits(SteerReged_4_io_qin_bits),
    .io_qout_0_ready(SteerReged_4_io_qout_0_ready),
    .io_qout_0_valid(SteerReged_4_io_qout_0_valid),
    .io_qout_0_bits(SteerReged_4_io_qout_0_bits),
    .io_qout_1_ready(SteerReged_4_io_qout_1_ready),
    .io_qout_1_valid(SteerReged_4_io_qout_1_valid),
    .io_qout_1_bits(SteerReged_4_io_qout_1_bits),
    .io_qout_2_ready(SteerReged_4_io_qout_2_ready),
    .io_qout_2_valid(SteerReged_4_io_qout_2_valid),
    .io_qout_2_bits(SteerReged_4_io_qout_2_bits),
    .io_qout_3_ready(SteerReged_4_io_qout_3_ready),
    .io_qout_3_valid(SteerReged_4_io_qout_3_valid),
    .io_qout_3_bits(SteerReged_4_io_qout_3_bits)
  );
  SteerReged_1 SteerReged_1_1 (
    .clock(SteerReged_1_1_clock),
    .reset(SteerReged_1_1_reset),
    .io_qin_ready(SteerReged_1_1_io_qin_ready),
    .io_qin_valid(SteerReged_1_1_io_qin_valid),
    .io_qin_bits(SteerReged_1_1_io_qin_bits),
    .io_qout_0_ready(SteerReged_1_1_io_qout_0_ready),
    .io_qout_0_valid(SteerReged_1_1_io_qout_0_valid),
    .io_qout_0_bits(SteerReged_1_1_io_qout_0_bits),
    .io_qout_1_ready(SteerReged_1_1_io_qout_1_ready),
    .io_qout_1_valid(SteerReged_1_1_io_qout_1_valid),
    .io_qout_1_bits(SteerReged_1_1_io_qout_1_bits),
    .io_qout_2_ready(SteerReged_1_1_io_qout_2_ready),
    .io_qout_2_valid(SteerReged_1_1_io_qout_2_valid),
    .io_qout_2_bits(SteerReged_1_1_io_qout_2_bits),
    .io_qout_3_ready(SteerReged_1_1_io_qout_3_ready),
    .io_qout_3_valid(SteerReged_1_1_io_qout_3_valid),
    .io_qout_3_bits(SteerReged_1_1_io_qout_3_bits)
  );
  SteerReged_2 SteerReged_2_1 (
    .clock(SteerReged_2_1_clock),
    .reset(SteerReged_2_1_reset),
    .io_qin_ready(SteerReged_2_1_io_qin_ready),
    .io_qin_valid(SteerReged_2_1_io_qin_valid),
    .io_qin_bits(SteerReged_2_1_io_qin_bits),
    .io_qout_0_ready(SteerReged_2_1_io_qout_0_ready),
    .io_qout_0_valid(SteerReged_2_1_io_qout_0_valid),
    .io_qout_0_bits(SteerReged_2_1_io_qout_0_bits),
    .io_qout_1_ready(SteerReged_2_1_io_qout_1_ready),
    .io_qout_1_valid(SteerReged_2_1_io_qout_1_valid),
    .io_qout_1_bits(SteerReged_2_1_io_qout_1_bits),
    .io_qout_2_ready(SteerReged_2_1_io_qout_2_ready),
    .io_qout_2_valid(SteerReged_2_1_io_qout_2_valid),
    .io_qout_2_bits(SteerReged_2_1_io_qout_2_bits),
    .io_qout_3_ready(SteerReged_2_1_io_qout_3_ready),
    .io_qout_3_valid(SteerReged_2_1_io_qout_3_valid),
    .io_qout_3_bits(SteerReged_2_1_io_qout_3_bits)
  );
  SteerReged_3 SteerReged_3_1 (
    .clock(SteerReged_3_1_clock),
    .reset(SteerReged_3_1_reset),
    .io_qin_ready(SteerReged_3_1_io_qin_ready),
    .io_qin_valid(SteerReged_3_1_io_qin_valid),
    .io_qin_bits(SteerReged_3_1_io_qin_bits),
    .io_qout_0_ready(SteerReged_3_1_io_qout_0_ready),
    .io_qout_0_valid(SteerReged_3_1_io_qout_0_valid),
    .io_qout_0_bits(SteerReged_3_1_io_qout_0_bits),
    .io_qout_1_ready(SteerReged_3_1_io_qout_1_ready),
    .io_qout_1_valid(SteerReged_3_1_io_qout_1_valid),
    .io_qout_1_bits(SteerReged_3_1_io_qout_1_bits),
    .io_qout_2_ready(SteerReged_3_1_io_qout_2_ready),
    .io_qout_2_valid(SteerReged_3_1_io_qout_2_valid),
    .io_qout_2_bits(SteerReged_3_1_io_qout_2_bits),
    .io_qout_3_ready(SteerReged_3_1_io_qout_3_ready),
    .io_qout_3_valid(SteerReged_3_1_io_qout_3_valid),
    .io_qout_3_bits(SteerReged_3_1_io_qout_3_bits)
  );
  assign io_qin_ready = steer_submod_ins_0_ready;
  assign io_qout_0_valid = steer_submod_outs_0_0_valid;
  assign io_qout_0_bits = T_508;
  assign io_qout_1_valid = steer_submod_outs_0_1_valid;
  assign io_qout_1_bits = T_515;
  assign io_qout_2_valid = steer_submod_outs_0_2_valid;
  assign io_qout_2_bits = T_522;
  assign io_qout_3_valid = steer_submod_outs_0_3_valid;
  assign io_qout_3_bits = T_529;
  assign SteerReged_4_clock = clock;
  assign SteerReged_4_reset = reset;
  assign SteerReged_4_io_qin_valid = steer_submod_ins_0_valid;
  assign SteerReged_4_io_qin_bits = steer_submod_ins_0_bits;
  assign SteerReged_4_io_qout_0_ready = steer_submod_outs_0_0_ready;
  assign SteerReged_4_io_qout_1_ready = steer_submod_outs_0_1_ready;
  assign SteerReged_4_io_qout_2_ready = steer_submod_outs_0_2_ready;
  assign SteerReged_4_io_qout_3_ready = steer_submod_outs_0_3_ready;
  assign SteerReged_1_1_clock = clock;
  assign SteerReged_1_1_reset = reset;
  assign SteerReged_1_1_io_qin_valid = steer_submod_ins_1_valid;
  assign SteerReged_1_1_io_qin_bits = steer_submod_ins_1_bits;
  assign SteerReged_1_1_io_qout_0_ready = steer_submod_outs_1_0_ready;
  assign SteerReged_1_1_io_qout_1_ready = steer_submod_outs_1_1_ready;
  assign SteerReged_1_1_io_qout_2_ready = steer_submod_outs_1_2_ready;
  assign SteerReged_1_1_io_qout_3_ready = steer_submod_outs_1_3_ready;
  assign SteerReged_2_1_clock = clock;
  assign SteerReged_2_1_reset = reset;
  assign SteerReged_2_1_io_qin_valid = steer_submod_ins_2_valid;
  assign SteerReged_2_1_io_qin_bits = steer_submod_ins_2_bits;
  assign SteerReged_2_1_io_qout_0_ready = steer_submod_outs_2_0_ready;
  assign SteerReged_2_1_io_qout_1_ready = steer_submod_outs_2_1_ready;
  assign SteerReged_2_1_io_qout_2_ready = steer_submod_outs_2_2_ready;
  assign SteerReged_2_1_io_qout_3_ready = steer_submod_outs_2_3_ready;
  assign SteerReged_3_1_clock = clock;
  assign SteerReged_3_1_reset = reset;
  assign SteerReged_3_1_io_qin_valid = steer_submod_ins_3_valid;
  assign SteerReged_3_1_io_qin_bits = steer_submod_ins_3_bits;
  assign SteerReged_3_1_io_qout_0_ready = steer_submod_outs_3_0_ready;
  assign SteerReged_3_1_io_qout_1_ready = steer_submod_outs_3_1_ready;
  assign SteerReged_3_1_io_qout_2_ready = steer_submod_outs_3_2_ready;
  assign SteerReged_3_1_io_qout_3_ready = steer_submod_outs_3_3_ready;
  assign steer_submod_ins_0_ready = SteerReged_4_io_qin_ready;
  assign steer_submod_ins_0_valid = io_qin_valid;
  assign steer_submod_ins_0_bits = T_477;
  assign steer_submod_ins_1_ready = SteerReged_1_1_io_qin_ready;
  assign steer_submod_ins_1_valid = io_qin_valid;
  assign steer_submod_ins_1_bits = T_481;
  assign steer_submod_ins_2_ready = SteerReged_2_1_io_qin_ready;
  assign steer_submod_ins_2_valid = io_qin_valid;
  assign steer_submod_ins_2_bits = T_485;
  assign steer_submod_ins_3_ready = SteerReged_3_1_io_qin_ready;
  assign steer_submod_ins_3_valid = io_qin_valid;
  assign steer_submod_ins_3_bits = T_489;
  assign steer_submod_outs_0_0_ready = io_qout_0_ready;
  assign steer_submod_outs_0_0_valid = SteerReged_4_io_qout_0_valid;
  assign steer_submod_outs_0_0_bits = SteerReged_4_io_qout_0_bits;
  assign steer_submod_outs_0_1_ready = io_qout_1_ready;
  assign steer_submod_outs_0_1_valid = SteerReged_4_io_qout_1_valid;
  assign steer_submod_outs_0_1_bits = SteerReged_4_io_qout_1_bits;
  assign steer_submod_outs_0_2_ready = io_qout_2_ready;
  assign steer_submod_outs_0_2_valid = SteerReged_4_io_qout_2_valid;
  assign steer_submod_outs_0_2_bits = SteerReged_4_io_qout_2_bits;
  assign steer_submod_outs_0_3_ready = io_qout_3_ready;
  assign steer_submod_outs_0_3_valid = SteerReged_4_io_qout_3_valid;
  assign steer_submod_outs_0_3_bits = SteerReged_4_io_qout_3_bits;
  assign steer_submod_outs_1_0_ready = io_qout_0_ready;
  assign steer_submod_outs_1_0_valid = SteerReged_1_1_io_qout_0_valid;
  assign steer_submod_outs_1_0_bits = SteerReged_1_1_io_qout_0_bits;
  assign steer_submod_outs_1_1_ready = io_qout_1_ready;
  assign steer_submod_outs_1_1_valid = SteerReged_1_1_io_qout_1_valid;
  assign steer_submod_outs_1_1_bits = SteerReged_1_1_io_qout_1_bits;
  assign steer_submod_outs_1_2_ready = io_qout_2_ready;
  assign steer_submod_outs_1_2_valid = SteerReged_1_1_io_qout_2_valid;
  assign steer_submod_outs_1_2_bits = SteerReged_1_1_io_qout_2_bits;
  assign steer_submod_outs_1_3_ready = io_qout_3_ready;
  assign steer_submod_outs_1_3_valid = SteerReged_1_1_io_qout_3_valid;
  assign steer_submod_outs_1_3_bits = SteerReged_1_1_io_qout_3_bits;
  assign steer_submod_outs_2_0_ready = io_qout_0_ready;
  assign steer_submod_outs_2_0_valid = SteerReged_2_1_io_qout_0_valid;
  assign steer_submod_outs_2_0_bits = SteerReged_2_1_io_qout_0_bits;
  assign steer_submod_outs_2_1_ready = io_qout_1_ready;
  assign steer_submod_outs_2_1_valid = SteerReged_2_1_io_qout_1_valid;
  assign steer_submod_outs_2_1_bits = SteerReged_2_1_io_qout_1_bits;
  assign steer_submod_outs_2_2_ready = io_qout_2_ready;
  assign steer_submod_outs_2_2_valid = SteerReged_2_1_io_qout_2_valid;
  assign steer_submod_outs_2_2_bits = SteerReged_2_1_io_qout_2_bits;
  assign steer_submod_outs_2_3_ready = io_qout_3_ready;
  assign steer_submod_outs_2_3_valid = SteerReged_2_1_io_qout_3_valid;
  assign steer_submod_outs_2_3_bits = SteerReged_2_1_io_qout_3_bits;
  assign steer_submod_outs_3_0_ready = io_qout_0_ready;
  assign steer_submod_outs_3_0_valid = SteerReged_3_1_io_qout_0_valid;
  assign steer_submod_outs_3_0_bits = SteerReged_3_1_io_qout_0_bits;
  assign steer_submod_outs_3_1_ready = io_qout_1_ready;
  assign steer_submod_outs_3_1_valid = SteerReged_3_1_io_qout_1_valid;
  assign steer_submod_outs_3_1_bits = SteerReged_3_1_io_qout_1_bits;
  assign steer_submod_outs_3_2_ready = io_qout_2_ready;
  assign steer_submod_outs_3_2_valid = SteerReged_3_1_io_qout_2_valid;
  assign steer_submod_outs_3_2_bits = SteerReged_3_1_io_qout_2_bits;
  assign steer_submod_outs_3_3_ready = io_qout_3_ready;
  assign steer_submod_outs_3_3_valid = SteerReged_3_1_io_qout_3_valid;
  assign steer_submod_outs_3_3_bits = SteerReged_3_1_io_qout_3_bits;
  assign T_474 = io_qin_bits[129:0];
  assign T_475 = T_474;
  assign T_476 = io_qin_bits[527:517];
  assign T_477 = {T_476,T_475};
  assign T_478 = io_qin_bits[258:129];
  assign T_479 = T_478;
  assign T_481 = {T_476,T_479};
  assign T_482 = io_qin_bits[387:258];
  assign T_483 = T_482;
  assign T_485 = {T_476,T_483};
  assign T_486 = io_qin_bits[516:387];
  assign T_487 = T_486;
  assign T_489 = {T_476,T_487};
  assign T_502 = steer_submod_outs_0_0_bits[128:0];
  assign T_503 = steer_submod_outs_1_0_bits[128:0];
  assign T_504 = steer_submod_outs_2_0_bits[128:0];
  assign T_506 = {T_503,T_502};
  assign T_507 = {T_504,T_506};
  assign T_508 = {steer_submod_outs_3_0_bits,T_507};
  assign T_509 = steer_submod_outs_0_1_bits[128:0];
  assign T_510 = steer_submod_outs_1_1_bits[128:0];
  assign T_511 = steer_submod_outs_2_1_bits[128:0];
  assign T_513 = {T_510,T_509};
  assign T_514 = {T_511,T_513};
  assign T_515 = {steer_submod_outs_3_1_bits,T_514};
  assign T_516 = steer_submod_outs_0_2_bits[128:0];
  assign T_517 = steer_submod_outs_1_2_bits[128:0];
  assign T_518 = steer_submod_outs_2_2_bits[128:0];
  assign T_520 = {T_517,T_516};
  assign T_521 = {T_518,T_520};
  assign T_522 = {steer_submod_outs_3_2_bits,T_521};
  assign T_523 = steer_submod_outs_0_3_bits[128:0];
  assign T_524 = steer_submod_outs_1_3_bits[128:0];
  assign T_525 = steer_submod_outs_2_3_bits[128:0];
  assign T_527 = {T_524,T_523};
  assign T_528 = {T_525,T_527};
  assign T_529 = {steer_submod_outs_3_3_bits,T_528};
endmodule
module DecoupledStge_21(
  input   clock,
  input   reset,
  output  io_inp_ready,
  input   io_inp_valid,
  input  [605:0] io_inp_bits,
  input   io_out_ready,
  output  io_out_valid,
  output [605:0] io_out_bits
);
  reg  out_valid;
  reg [31:0] GEN_1;
  reg [605:0] out_bits;
  reg [607:0] GEN_2;
  wire  T_24;
  wire  T_25;
  wire  T_26;
  wire  T_27;
  wire [605:0] GEN_0;
  assign io_inp_ready = T_25;
  assign io_out_valid = out_valid;
  assign io_out_bits = out_bits;
  assign T_24 = ~ io_out_valid;
  assign T_25 = io_out_ready | T_24;
  assign T_26 = ~ io_inp_ready;
  assign T_27 = io_inp_valid | T_26;
  assign GEN_0 = io_inp_ready ? io_inp_bits : out_bits;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_1 = {1{$random}};
  out_valid = GEN_1[0:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_2 = {19{$random}};
  out_bits = GEN_2[605:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(reset) begin
      out_valid <= 1'h0;
    end else begin
      out_valid <= T_27;
    end
    if(1'h0) begin
    end else begin
      if(io_inp_ready) begin
        out_bits <= io_inp_bits;
      end
    end
  end
endmodule
module RRArbiter_1(
  input   clock,
  input   reset,
  output  io_in_0_ready,
  input   io_in_0_valid,
  input  [605:0] io_in_0_bits,
  input   io_out_ready,
  output  io_out_valid,
  output [605:0] io_out_bits,
  output  io_chosen
);
  wire  choice;
  wire  T_63;
  reg  lastGrant;
  reg [31:0] GEN_1;
  wire  GEN_0;
  assign io_in_0_ready = io_out_ready;
  assign io_out_valid = io_in_0_valid;
  assign io_out_bits = io_in_0_bits;
  assign io_chosen = choice;
  assign choice = 1'h0;
  assign T_63 = io_out_ready & io_out_valid;
  assign GEN_0 = T_63 ? io_chosen : lastGrant;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_1 = {1{$random}};
  lastGrant = GEN_1[0:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(reset) begin
      lastGrant <= 1'h0;
    end else begin
      if(T_63) begin
        lastGrant <= io_chosen;
      end
    end
  end
endmodule
module ArbiterReged_1(
  input   clock,
  input   reset,
  output  io_qin_0_ready,
  input   io_qin_0_valid,
  input  [605:0] io_qin_0_bits,
  input   io_qout_ready,
  output  io_qout_valid,
  output [605:0] io_qout_bits
);
  wire  DecoupledStge_21_1_clock;
  wire  DecoupledStge_21_1_reset;
  wire  DecoupledStge_21_1_io_inp_ready;
  wire  DecoupledStge_21_1_io_inp_valid;
  wire [605:0] DecoupledStge_21_1_io_inp_bits;
  wire  DecoupledStge_21_1_io_out_ready;
  wire  DecoupledStge_21_1_io_out_valid;
  wire [605:0] DecoupledStge_21_1_io_out_bits;
  wire  in_stage_inps_0_ready;
  wire  in_stage_inps_0_valid;
  wire [605:0] in_stage_inps_0_bits;
  wire  arb_clock;
  wire  arb_reset;
  wire  arb_io_in_0_ready;
  wire  arb_io_in_0_valid;
  wire [605:0] arb_io_in_0_bits;
  wire  arb_io_out_ready;
  wire  arb_io_out_valid;
  wire [605:0] arb_io_out_bits;
  wire  arb_io_chosen;
  wire  stage_out_clock;
  wire  stage_out_reset;
  wire  stage_out_io_inp_ready;
  wire  stage_out_io_inp_valid;
  wire [605:0] stage_out_io_inp_bits;
  wire  stage_out_io_out_ready;
  wire  stage_out_io_out_valid;
  wire [605:0] stage_out_io_out_bits;
  DecoupledStge_21 DecoupledStge_21_1 (
    .clock(DecoupledStge_21_1_clock),
    .reset(DecoupledStge_21_1_reset),
    .io_inp_ready(DecoupledStge_21_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_21_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_21_1_io_inp_bits),
    .io_out_ready(DecoupledStge_21_1_io_out_ready),
    .io_out_valid(DecoupledStge_21_1_io_out_valid),
    .io_out_bits(DecoupledStge_21_1_io_out_bits)
  );
  RRArbiter_1 arb (
    .clock(arb_clock),
    .reset(arb_reset),
    .io_in_0_ready(arb_io_in_0_ready),
    .io_in_0_valid(arb_io_in_0_valid),
    .io_in_0_bits(arb_io_in_0_bits),
    .io_out_ready(arb_io_out_ready),
    .io_out_valid(arb_io_out_valid),
    .io_out_bits(arb_io_out_bits),
    .io_chosen(arb_io_chosen)
  );
  DecoupledStge_21 stage_out (
    .clock(stage_out_clock),
    .reset(stage_out_reset),
    .io_inp_ready(stage_out_io_inp_ready),
    .io_inp_valid(stage_out_io_inp_valid),
    .io_inp_bits(stage_out_io_inp_bits),
    .io_out_ready(stage_out_io_out_ready),
    .io_out_valid(stage_out_io_out_valid),
    .io_out_bits(stage_out_io_out_bits)
  );
  assign io_qin_0_ready = in_stage_inps_0_ready;
  assign io_qout_valid = stage_out_io_out_valid;
  assign io_qout_bits = stage_out_io_out_bits;
  assign DecoupledStge_21_1_clock = clock;
  assign DecoupledStge_21_1_reset = reset;
  assign DecoupledStge_21_1_io_inp_valid = in_stage_inps_0_valid;
  assign DecoupledStge_21_1_io_inp_bits = in_stage_inps_0_bits;
  assign DecoupledStge_21_1_io_out_ready = arb_io_in_0_ready;
  assign in_stage_inps_0_ready = DecoupledStge_21_1_io_inp_ready;
  assign in_stage_inps_0_valid = io_qin_0_valid;
  assign in_stage_inps_0_bits = io_qin_0_bits;
  assign arb_clock = clock;
  assign arb_reset = reset;
  assign arb_io_in_0_valid = DecoupledStge_21_1_io_out_valid;
  assign arb_io_in_0_bits = DecoupledStge_21_1_io_out_bits;
  assign arb_io_out_ready = stage_out_io_inp_ready;
  assign stage_out_clock = clock;
  assign stage_out_reset = reset;
  assign stage_out_io_inp_valid = arb_io_out_valid;
  assign stage_out_io_inp_bits = arb_io_out_bits;
  assign stage_out_io_out_ready = io_qout_ready;
endmodule
module DecoupledStge_23(
  input   clock,
  input   reset,
  output  io_inp_ready,
  input   io_inp_valid,
  input  [16:0] io_inp_bits,
  input   io_out_ready,
  output  io_out_valid,
  output [16:0] io_out_bits
);
  reg  out_valid;
  reg [31:0] GEN_1;
  reg [16:0] out_bits;
  reg [31:0] GEN_2;
  wire  T_24;
  wire  T_25;
  wire  T_26;
  wire  T_27;
  wire [16:0] GEN_0;
  assign io_inp_ready = T_25;
  assign io_out_valid = out_valid;
  assign io_out_bits = out_bits;
  assign T_24 = ~ io_out_valid;
  assign T_25 = io_out_ready | T_24;
  assign T_26 = ~ io_inp_ready;
  assign T_27 = io_inp_valid | T_26;
  assign GEN_0 = io_inp_ready ? io_inp_bits : out_bits;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_1 = {1{$random}};
  out_valid = GEN_1[0:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_2 = {1{$random}};
  out_bits = GEN_2[16:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(reset) begin
      out_valid <= 1'h0;
    end else begin
      out_valid <= T_27;
    end
    if(1'h0) begin
    end else begin
      if(io_inp_ready) begin
        out_bits <= io_inp_bits;
      end
    end
  end
endmodule
module SteerReged_4(
  input   clock,
  input   reset,
  output  io_qin_ready,
  input   io_qin_valid,
  input  [16:0] io_qin_bits,
  input   io_qout_0_ready,
  output  io_qout_0_valid,
  output [16:0] io_qout_0_bits
);
  wire  DecoupledStge_23_1_clock;
  wire  DecoupledStge_23_1_reset;
  wire  DecoupledStge_23_1_io_inp_ready;
  wire  DecoupledStge_23_1_io_inp_valid;
  wire [16:0] DecoupledStge_23_1_io_inp_bits;
  wire  DecoupledStge_23_1_io_out_ready;
  wire  DecoupledStge_23_1_io_out_valid;
  wire [16:0] DecoupledStge_23_1_io_out_bits;
  wire  out_stage_inps_0_ready;
  wire  out_stage_inps_0_valid;
  wire [16:0] out_stage_inps_0_bits;
  wire [16:0] T_75;
  reg [16:0] pendData;
  reg [31:0] GEN_0;
  reg  pendValid;
  reg [31:0] GEN_4;
  wire  T_84;
  wire [16:0] GEN_1;
  wire  T_102;
  wire  T_103;
  wire [16:0] T_105;
  wire [16:0] GEN_2;
  wire  GEN_3;
  wire [16:0] GEN_6;
  DecoupledStge_23 DecoupledStge_23_1 (
    .clock(DecoupledStge_23_1_clock),
    .reset(DecoupledStge_23_1_reset),
    .io_inp_ready(DecoupledStge_23_1_io_inp_ready),
    .io_inp_valid(DecoupledStge_23_1_io_inp_valid),
    .io_inp_bits(DecoupledStge_23_1_io_inp_bits),
    .io_out_ready(DecoupledStge_23_1_io_out_ready),
    .io_out_valid(DecoupledStge_23_1_io_out_valid),
    .io_out_bits(DecoupledStge_23_1_io_out_bits)
  );
  assign io_qin_ready = T_103;
  assign io_qout_0_valid = DecoupledStge_23_1_io_out_valid;
  assign io_qout_0_bits = DecoupledStge_23_1_io_out_bits;
  assign DecoupledStge_23_1_clock = clock;
  assign DecoupledStge_23_1_reset = reset;
  assign DecoupledStge_23_1_io_inp_valid = out_stage_inps_0_valid;
  assign DecoupledStge_23_1_io_inp_bits = out_stage_inps_0_bits;
  assign DecoupledStge_23_1_io_out_ready = io_qout_0_ready;
  assign out_stage_inps_0_ready = DecoupledStge_23_1_io_inp_ready;
  assign out_stage_inps_0_valid = T_84;
  assign out_stage_inps_0_bits = GEN_1;
  assign T_75 = 17'h0;
  assign T_84 = pendValid & out_stage_inps_0_ready;
  assign GEN_1 = T_84 ? pendData : T_75;
  assign T_102 = pendValid == 1'h0;
  assign T_103 = T_84 | T_102;
  assign T_105 = io_qin_bits;
  assign GEN_2 = io_qin_valid ? T_105 : pendData;
  assign GEN_3 = T_103 ? io_qin_valid : pendValid;
  assign GEN_6 = T_103 ? GEN_2 : pendData;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_0 = {1{$random}};
  pendData = GEN_0[16:0];
  `endif
  `ifdef RANDOMIZE_REG_INIT
  GEN_4 = {1{$random}};
  pendValid = GEN_4[0:0];
  `endif
  end
`endif
  always @(posedge clock) begin
    if(1'h0) begin
    end else begin
      if(T_103) begin
        if(io_qin_valid) begin
          pendData <= T_105;
        end
      end
    end
    if(reset) begin
      pendValid <= 1'h0;
    end else begin
      if(T_103) begin
        pendValid <= io_qin_valid;
      end
    end
  end
endmodule
module MultiChannelMux(
  input   clock,
  input   reset,
  output  io_acc_rd_req_in_0_ready,
  input   io_acc_rd_req_in_0_valid,
  input  [79:0] io_acc_rd_req_in_0_bits,
  output  io_acc_rd_req_in_1_ready,
  input   io_acc_rd_req_in_1_valid,
  input  [79:0] io_acc_rd_req_in_1_bits,
  output  io_acc_rd_req_in_2_ready,
  input   io_acc_rd_req_in_2_valid,
  input  [79:0] io_acc_rd_req_in_2_bits,
  output  io_acc_rd_req_in_3_ready,
  input   io_acc_rd_req_in_3_valid,
  input  [79:0] io_acc_rd_req_in_3_bits,
  input   io_mem_rd_req_out_ready,
  output  io_mem_rd_req_out_valid,
  output [79:0] io_mem_rd_req_out_bits,
  output  io_mem_rd_resp_in_ready,
  input   io_mem_rd_resp_in_valid,
  input  [527:0] io_mem_rd_resp_in_bits,
  input   io_acc_rd_resp_out_0_ready,
  output  io_acc_rd_resp_out_0_valid,
  output [527:0] io_acc_rd_resp_out_0_bits,
  input   io_acc_rd_resp_out_1_ready,
  output  io_acc_rd_resp_out_1_valid,
  output [527:0] io_acc_rd_resp_out_1_bits,
  input   io_acc_rd_resp_out_2_ready,
  output  io_acc_rd_resp_out_2_valid,
  output [527:0] io_acc_rd_resp_out_2_bits,
  input   io_acc_rd_resp_out_3_ready,
  output  io_acc_rd_resp_out_3_valid,
  output [527:0] io_acc_rd_resp_out_3_bits,
  output  io_acc_wr_req_in_0_ready,
  input   io_acc_wr_req_in_0_valid,
  input  [605:0] io_acc_wr_req_in_0_bits,
  input   io_mem_wr_req_out_ready,
  output  io_mem_wr_req_out_valid,
  output [605:0] io_mem_wr_req_out_bits,
  output  io_mem_wr_resp_in_ready,
  input   io_mem_wr_resp_in_valid,
  input  [16:0] io_mem_wr_resp_in_bits,
  input   io_acc_wr_resp_out_0_ready,
  output  io_acc_wr_resp_out_0_valid,
  output [16:0] io_acc_wr_resp_out_0_bits
);
  wire  arbiter_read_clock;
  wire  arbiter_read_reset;
  wire  arbiter_read_io_qin_0_ready;
  wire  arbiter_read_io_qin_0_valid;
  wire [79:0] arbiter_read_io_qin_0_bits;
  wire  arbiter_read_io_qin_1_ready;
  wire  arbiter_read_io_qin_1_valid;
  wire [79:0] arbiter_read_io_qin_1_bits;
  wire  arbiter_read_io_qin_2_ready;
  wire  arbiter_read_io_qin_2_valid;
  wire [79:0] arbiter_read_io_qin_2_bits;
  wire  arbiter_read_io_qin_3_ready;
  wire  arbiter_read_io_qin_3_valid;
  wire [79:0] arbiter_read_io_qin_3_bits;
  wire  arbiter_read_io_qout_ready;
  wire  arbiter_read_io_qout_valid;
  wire [79:0] arbiter_read_io_qout_bits;
  wire  steer_read_clock;
  wire  steer_read_reset;
  wire  steer_read_io_qin_ready;
  wire  steer_read_io_qin_valid;
  wire [527:0] steer_read_io_qin_bits;
  wire  steer_read_io_qout_0_ready;
  wire  steer_read_io_qout_0_valid;
  wire [527:0] steer_read_io_qout_0_bits;
  wire  steer_read_io_qout_1_ready;
  wire  steer_read_io_qout_1_valid;
  wire [527:0] steer_read_io_qout_1_bits;
  wire  steer_read_io_qout_2_ready;
  wire  steer_read_io_qout_2_valid;
  wire [527:0] steer_read_io_qout_2_bits;
  wire  steer_read_io_qout_3_ready;
  wire  steer_read_io_qout_3_valid;
  wire [527:0] steer_read_io_qout_3_bits;
  wire  arbiter_write_clock;
  wire  arbiter_write_reset;
  wire  arbiter_write_io_qin_0_ready;
  wire  arbiter_write_io_qin_0_valid;
  wire [605:0] arbiter_write_io_qin_0_bits;
  wire  arbiter_write_io_qout_ready;
  wire  arbiter_write_io_qout_valid;
  wire [605:0] arbiter_write_io_qout_bits;
  wire  steer_write_clock;
  wire  steer_write_reset;
  wire  steer_write_io_qin_ready;
  wire  steer_write_io_qin_valid;
  wire [16:0] steer_write_io_qin_bits;
  wire  steer_write_io_qout_0_ready;
  wire  steer_write_io_qout_0_valid;
  wire [16:0] steer_write_io_qout_0_bits;
  ArbiterReged arbiter_read (
    .clock(arbiter_read_clock),
    .reset(arbiter_read_reset),
    .io_qin_0_ready(arbiter_read_io_qin_0_ready),
    .io_qin_0_valid(arbiter_read_io_qin_0_valid),
    .io_qin_0_bits(arbiter_read_io_qin_0_bits),
    .io_qin_1_ready(arbiter_read_io_qin_1_ready),
    .io_qin_1_valid(arbiter_read_io_qin_1_valid),
    .io_qin_1_bits(arbiter_read_io_qin_1_bits),
    .io_qin_2_ready(arbiter_read_io_qin_2_ready),
    .io_qin_2_valid(arbiter_read_io_qin_2_valid),
    .io_qin_2_bits(arbiter_read_io_qin_2_bits),
    .io_qin_3_ready(arbiter_read_io_qin_3_ready),
    .io_qin_3_valid(arbiter_read_io_qin_3_valid),
    .io_qin_3_bits(arbiter_read_io_qin_3_bits),
    .io_qout_ready(arbiter_read_io_qout_ready),
    .io_qout_valid(arbiter_read_io_qout_valid),
    .io_qout_bits(arbiter_read_io_qout_bits)
  );
  SteerRegedSplit steer_read (
    .clock(steer_read_clock),
    .reset(steer_read_reset),
    .io_qin_ready(steer_read_io_qin_ready),
    .io_qin_valid(steer_read_io_qin_valid),
    .io_qin_bits(steer_read_io_qin_bits),
    .io_qout_0_ready(steer_read_io_qout_0_ready),
    .io_qout_0_valid(steer_read_io_qout_0_valid),
    .io_qout_0_bits(steer_read_io_qout_0_bits),
    .io_qout_1_ready(steer_read_io_qout_1_ready),
    .io_qout_1_valid(steer_read_io_qout_1_valid),
    .io_qout_1_bits(steer_read_io_qout_1_bits),
    .io_qout_2_ready(steer_read_io_qout_2_ready),
    .io_qout_2_valid(steer_read_io_qout_2_valid),
    .io_qout_2_bits(steer_read_io_qout_2_bits),
    .io_qout_3_ready(steer_read_io_qout_3_ready),
    .io_qout_3_valid(steer_read_io_qout_3_valid),
    .io_qout_3_bits(steer_read_io_qout_3_bits)
  );
  ArbiterReged_1 arbiter_write (
    .clock(arbiter_write_clock),
    .reset(arbiter_write_reset),
    .io_qin_0_ready(arbiter_write_io_qin_0_ready),
    .io_qin_0_valid(arbiter_write_io_qin_0_valid),
    .io_qin_0_bits(arbiter_write_io_qin_0_bits),
    .io_qout_ready(arbiter_write_io_qout_ready),
    .io_qout_valid(arbiter_write_io_qout_valid),
    .io_qout_bits(arbiter_write_io_qout_bits)
  );
  SteerReged_4 steer_write (
    .clock(steer_write_clock),
    .reset(steer_write_reset),
    .io_qin_ready(steer_write_io_qin_ready),
    .io_qin_valid(steer_write_io_qin_valid),
    .io_qin_bits(steer_write_io_qin_bits),
    .io_qout_0_ready(steer_write_io_qout_0_ready),
    .io_qout_0_valid(steer_write_io_qout_0_valid),
    .io_qout_0_bits(steer_write_io_qout_0_bits)
  );
  assign io_acc_rd_req_in_0_ready = arbiter_read_io_qin_0_ready;
  assign io_acc_rd_req_in_1_ready = arbiter_read_io_qin_1_ready;
  assign io_acc_rd_req_in_2_ready = arbiter_read_io_qin_2_ready;
  assign io_acc_rd_req_in_3_ready = arbiter_read_io_qin_3_ready;
  assign io_mem_rd_req_out_valid = arbiter_read_io_qout_valid;
  assign io_mem_rd_req_out_bits = arbiter_read_io_qout_bits;
  assign io_mem_rd_resp_in_ready = steer_read_io_qin_ready;
  assign io_acc_rd_resp_out_0_valid = steer_read_io_qout_0_valid;
  assign io_acc_rd_resp_out_0_bits = steer_read_io_qout_0_bits;
  assign io_acc_rd_resp_out_1_valid = steer_read_io_qout_1_valid;
  assign io_acc_rd_resp_out_1_bits = steer_read_io_qout_1_bits;
  assign io_acc_rd_resp_out_2_valid = steer_read_io_qout_2_valid;
  assign io_acc_rd_resp_out_2_bits = steer_read_io_qout_2_bits;
  assign io_acc_rd_resp_out_3_valid = steer_read_io_qout_3_valid;
  assign io_acc_rd_resp_out_3_bits = steer_read_io_qout_3_bits;
  assign io_acc_wr_req_in_0_ready = arbiter_write_io_qin_0_ready;
  assign io_mem_wr_req_out_valid = arbiter_write_io_qout_valid;
  assign io_mem_wr_req_out_bits = arbiter_write_io_qout_bits;
  assign io_mem_wr_resp_in_ready = steer_write_io_qin_ready;
  assign io_acc_wr_resp_out_0_valid = steer_write_io_qout_0_valid;
  assign io_acc_wr_resp_out_0_bits = steer_write_io_qout_0_bits;
  assign arbiter_read_clock = clock;
  assign arbiter_read_reset = reset;
  assign arbiter_read_io_qin_0_valid = io_acc_rd_req_in_0_valid;
  assign arbiter_read_io_qin_0_bits = io_acc_rd_req_in_0_bits;
  assign arbiter_read_io_qin_1_valid = io_acc_rd_req_in_1_valid;
  assign arbiter_read_io_qin_1_bits = io_acc_rd_req_in_1_bits;
  assign arbiter_read_io_qin_2_valid = io_acc_rd_req_in_2_valid;
  assign arbiter_read_io_qin_2_bits = io_acc_rd_req_in_2_bits;
  assign arbiter_read_io_qin_3_valid = io_acc_rd_req_in_3_valid;
  assign arbiter_read_io_qin_3_bits = io_acc_rd_req_in_3_bits;
  assign arbiter_read_io_qout_ready = io_mem_rd_req_out_ready;
  assign steer_read_clock = clock;
  assign steer_read_reset = reset;
  assign steer_read_io_qin_valid = io_mem_rd_resp_in_valid;
  assign steer_read_io_qin_bits = io_mem_rd_resp_in_bits;
  assign steer_read_io_qout_0_ready = io_acc_rd_resp_out_0_ready;
  assign steer_read_io_qout_1_ready = io_acc_rd_resp_out_1_ready;
  assign steer_read_io_qout_2_ready = io_acc_rd_resp_out_2_ready;
  assign steer_read_io_qout_3_ready = io_acc_rd_resp_out_3_ready;
  assign arbiter_write_clock = clock;
  assign arbiter_write_reset = reset;
  assign arbiter_write_io_qin_0_valid = io_acc_wr_req_in_0_valid;
  assign arbiter_write_io_qin_0_bits = io_acc_wr_req_in_0_bits;
  assign arbiter_write_io_qout_ready = io_mem_wr_req_out_ready;
  assign steer_write_clock = clock;
  assign steer_write_reset = reset;
  assign steer_write_io_qin_valid = io_mem_wr_resp_in_valid;
  assign steer_write_io_qin_bits = io_mem_wr_resp_in_bits;
  assign steer_write_io_qout_0_ready = io_acc_wr_resp_out_0_ready;
endmodule
