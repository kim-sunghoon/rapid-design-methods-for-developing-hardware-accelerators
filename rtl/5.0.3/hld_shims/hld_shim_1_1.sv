// See LICENSE for license details.
`include "hld_defines.vh"

module hld_shim_1_1
  #(
    parameter FIFO_REQ_DEPTH_LOG2,
    parameter FIFO_RESP_DEPTH_LOG2
   )
( a_clk, clk, rst, config_, start, spl_rd_resp_valid, 
spl_rd_resp_data, spl_rd_req_ready, spl_wr_resp_valid, spl_wr_resp_data, 
spl_wr_req_ready, done, spl_rd_resp_ready, spl_rd_req_valid, spl_rd_req_data, 
spl_wr_resp_ready, spl_wr_req_valid, spl_wr_req_data);

  localparam RD_PORTS = 1;
  localparam WR_PORTS = 1;
  localparam CONFIG_WIDTH = 576;
  
  input a_clk; // Accelerator clock, typically slower than clk (spl/ccip)
  input clk;
  input rst;
  input [CONFIG_WIDTH-1:0] config_;
  input start;
  input spl_rd_resp_valid;
  input [527:0] spl_rd_resp_data;
  input spl_rd_req_ready;
  input spl_wr_resp_valid;
  input [16:0] spl_wr_resp_data;
  input spl_wr_req_ready;
  output reg done;
  output spl_rd_resp_ready;
  output spl_rd_req_valid;
  output [79:0] spl_rd_req_data;
  output spl_wr_resp_ready;
  output spl_wr_req_valid;
  output [605:0] spl_wr_req_data;


  wire         a_spl_rd_req_valid[RD_PORTS-1:0];
  wire         a_spl_rd_req_ready[RD_PORTS-1:0];
  wire [79:0]  a_spl_rd_req_data[RD_PORTS-1:0];

  wire         d_spl_rd_req_valid[RD_PORTS-1:0];
  wire         d_spl_rd_req_ready[RD_PORTS-1:0];
  wire [79:0]  d_spl_rd_req_data[RD_PORTS-1:0];

  wire         a_spl_rd_resp_valid[RD_PORTS-1:0];
  wire         a_spl_rd_resp_ready[RD_PORTS-1:0];
  wire [527:0] a_spl_rd_resp_data[RD_PORTS-1:0];

  wire         d_spl_rd_resp_valid[RD_PORTS-1:0];
  wire         d_spl_rd_resp_ready[RD_PORTS-1:0];
  wire [527:0] d_spl_rd_resp_data[RD_PORTS-1:0];


  wire         a_spl_wr_resp_valid[WR_PORTS-1:0];
  wire         a_spl_wr_resp_ready[WR_PORTS-1:0];
  wire [16:0]  a_spl_wr_resp_data[WR_PORTS-1:0];

  wire         d_spl_wr_resp_valid[WR_PORTS-1:0];
  wire         d_spl_wr_resp_ready[WR_PORTS-1:0];
  wire [16:0]  d_spl_wr_resp_data[WR_PORTS-1:0];

  wire         a_spl_wr_req_ready[WR_PORTS-1:0];
  wire         a_spl_wr_req_valid[WR_PORTS-1:0];
  wire [605:0] a_spl_wr_req_data[WR_PORTS-1:0];

  wire         d_spl_wr_req_valid[WR_PORTS-1:0];
  wire         d_spl_wr_req_ready[WR_PORTS-1:0];
  wire [605:0] d_spl_wr_req_data[WR_PORTS-1:0];

  reg a_rst;
  reg [CONFIG_WIDTH-1:0] a_config_;
  reg a_start;

  
  wire a_done;
  
  reg d_rst;
  reg [CONFIG_WIDTH-1:0] d_config_;
  reg d_start;
  reg c_done[1:0];


  
 
  // Double synchronize combinational signals
  always @(posedge a_clk)
    begin
       d_rst <= rst;
       a_rst <= d_rst;

       d_config_ <= config_;
       a_config_ <= d_config_;
       
       d_start <= start;
       a_start <= d_start;
    end
    
   // Delay done condition from AFU until we don't have any write requests in the shim (AFU done comes with last write)
   reg [7:0] count_after_done;
   always @(posedge clk)
   begin
      if ( spl_wr_req_valid || !spl_wr_req_ready ) 
      begin
         count_after_done <= 0;
      end 
      else 
      begin 
         if ( c_done[1] && !done )
         begin
            count_after_done <= count_after_done + 1;
         end
      end        
      if ( count_after_done == 16)
      begin
         done <= 1;
      end

      if ( !rst)
      begin
         count_after_done <= 0;
         done <= 0;
      end
   end

   always @(posedge clk)
   begin
      c_done[0] <= a_done;
      c_done[1] <= c_done[0];
   end

    // duplicated reset
    (* dont_merge *) reg rd_req_rst0;
    (* dont_merge *) reg rd_resp_rst0;
    (* dont_merge *) reg a_rd_req_rst0;
    (* dont_merge *) reg a_rd_resp_rst0;
    (* dont_merge *) reg wr_req_rst0;
    (* dont_merge *) reg wr_resp_rst0;
    (* dont_merge *) reg a_wr_req_rst0;
    (* dont_merge *) reg a_wr_resp_rst0;
    (* dont_merge *) reg a_acc_rst;
    (* dont_merge *) reg mux_rst;

    wire [1:0] rst_vector_rd_req;
    wire [1:0] rst_vector_rd_resp;
    wire [1:0] rst_vector_wr_req;
    wire [1:0] rst_vector_wr_resp;
    wire [1:0] a_rst_vector_rd_req;
    wire [1:0] a_rst_vector_rd_resp;
    wire [1:0] a_rst_vector_wr_req;
    wire [1:0] a_rst_vector_wr_resp;

    always @(posedge a_clk)
    begin
      a_rd_req_rst0 <= a_rst;
      a_rd_resp_rst0 <= a_rst;
      a_wr_req_rst0 <= a_rst;
      a_wr_resp_rst0 <= a_rst;
      a_acc_rst <= a_rst;
    end

    always @(posedge clk)
    begin
      rd_req_rst0 <= rst;
      rd_resp_rst0 <= rst;
      wr_req_rst0 <= rst;
      wr_resp_rst0 <= rst;
      mux_rst <= rst;
    end

    assign rst_vector_rd_req[0] = rd_req_rst0;
    assign rst_vector_rd_resp[0] = rd_resp_rst0;
    assign a_rst_vector_rd_req[0] = a_rd_req_rst0;
    assign a_rst_vector_rd_resp[0] = a_rd_resp_rst0;
    assign rst_vector_wr_req[0] = wr_req_rst0;
    assign rst_vector_wr_resp[0] = wr_resp_rst0;
    assign a_rst_vector_wr_req[0] = a_wr_req_rst0;
    assign a_rst_vector_wr_resp[0] = a_wr_resp_rst0;
    
    // Arbiter from multitple AFU memory channels to one CCI memory channel for both read and write requests
    MultiChannelMux multi_channel_mux11autag(.clock(clk), .reset(~mux_rst),
      .io_acc_rd_req_in_0_ready(d_spl_rd_req_ready[0]),  .io_acc_rd_req_in_0_valid(d_spl_rd_req_valid[0]),  .io_acc_rd_req_in_0_bits(d_spl_rd_req_data[0]),
      .io_mem_rd_req_out_ready(spl_rd_req_ready),   .io_mem_rd_req_out_valid(spl_rd_req_valid),   .io_mem_rd_req_out_bits(spl_rd_req_data),

      .io_acc_rd_resp_out_0_ready(1'b1),  .io_acc_rd_resp_out_0_valid(d_spl_rd_resp_valid[0]),  .io_acc_rd_resp_out_0_bits({d_spl_rd_resp_data[0][527:0]}),
      .io_mem_rd_resp_in_ready(spl_rd_resp_ready), .io_mem_rd_resp_in_valid(spl_rd_resp_valid), .io_mem_rd_resp_in_bits(spl_rd_resp_data),

      .io_acc_wr_req_in_0_ready(d_spl_wr_req_ready[0]),  .io_acc_wr_req_in_0_valid(d_spl_wr_req_valid[0]),  .io_acc_wr_req_in_0_bits(d_spl_wr_req_data[0]),
      .io_mem_wr_req_out_ready(spl_wr_req_ready), .io_mem_wr_req_out_valid(spl_wr_req_valid), .io_mem_wr_req_out_bits(spl_wr_req_data),

      .io_acc_wr_resp_out_0_ready(1'b1),  .io_acc_wr_resp_out_0_valid(d_spl_wr_resp_valid[0]),  .io_acc_wr_resp_out_0_bits({d_spl_wr_resp_data[0]}),
      .io_mem_wr_resp_in_ready(spl_wr_resp_ready), .io_mem_wr_resp_in_valid(spl_wr_resp_valid), .io_mem_wr_resp_in_bits(spl_wr_resp_data));

   // checking back pressure from AFU (AFU should never produce back pressure
   genvar k;
   generate for (k=0; k<RD_PORTS; k=k+1) begin
   always @(posedge clk)
    begin
       if (a_spl_rd_resp_ready[k] != 1'b1) begin
         $display(
         "Warning: Accelerators read response got full and back pressure is not handled %m @ time %0d:\n", $time);
         $stop(1);
       end

       if (d_spl_rd_resp_ready[k] != 1'b1) begin
         $display(
         "Warning: Async read response FIFO got full and back pressure is not handled %m @ time %0d:\n", $time);
         $stop(1);
       end

       if (spl_rd_resp_ready == 1'b0) begin
         $display(
         "Warning: Async FIFOs got full and back pressure is not handled in the requestor %m @ time %0d:\n", $time);
         $stop(1);
       end
    end
    
    // Asynchronous FIFOs between AFU clock domain and CCI clock domain
    // Some FIFOs are split (multiple fifos chained) to overcome performance issues
    afifo_split_wrapper2
      #(
       .DATA_WIDTH(80),
       .FIFO_DEPTH_LOG2(FIFO_REQ_DEPTH_LOG2),
       .SPLIT_WAYS(2),
       .MLAB_ONLY (0),
       .WR_TO_RD_CLK_STAGE (1)
       )
    rd_req( 
      .rd_rst(~rst_vector_rd_req[k]), .rd_clk( clk), .wr_rst(~a_rst_vector_rd_req[k]), .wr_clk( a_clk),
      .rd_ready( d_spl_rd_req_ready[k]),
      .rd_valid( d_spl_rd_req_valid[k]),
      .rd_data( d_spl_rd_req_data[k]),
      .wr_ready( a_spl_rd_req_ready[k]),
      .wr_valid( a_spl_rd_req_valid[k]),
      .wr_data( a_spl_rd_req_data[k])
      ); 
 
    afifo_split_wrapper2
    #(
      .FIFO_DEPTH_LOG2    (FIFO_RESP_DEPTH_LOG2),
      .DATA_WIDTH         (528),
      .SPLIT_WAYS         (4),
      .MLAB_ONLY          (1),
      .WR_TO_RD_CLK_STAGE (4)
     )
    rd_resp
     (
      .rd_rst(~a_rst_vector_rd_resp[k]), .rd_clk( a_clk), .wr_rst(~rst_vector_rd_resp[k]), .wr_clk( clk),
      .rd_ready( /*a_spl_rd_resp_ready[k]*/1'b1),
      .rd_valid( a_spl_rd_resp_valid[k]),
      .rd_data( a_spl_rd_resp_data[k]),
      .wr_ready( d_spl_rd_resp_ready[k]),
      .wr_valid( d_spl_rd_resp_valid[k]),
      .wr_data( d_spl_rd_resp_data[k])
     );

  end
  endgenerate

  genvar w;
  generate for (w=0; w<WR_PORTS; w=w+1) begin
    afifo_wrapper2
    #(
      .FIFO_DEPTH_LOG2    (FIFO_RESP_DEPTH_LOG2),
      .DATA_WIDTH         (17)
     )
    wr_resp
    (
      .rd_rst(~a_rst_vector_wr_resp[w]), .rd_clk( a_clk), .wr_clk( clk),
      .rd_ready( 1'b1),
      .rd_valid( a_spl_wr_resp_valid[w]),
      .rd_data( a_spl_wr_resp_data[w]),
      .wr_ready( d_spl_wr_resp_ready[w]),
      .wr_valid( d_spl_wr_resp_valid[w]),
      .wr_data( d_spl_wr_resp_data[w])
    );

    always @(posedge clk)
      begin
         if (~ spl_rd_resp_ready && start)
            $display( "Error(Handshaking): spl_rd_resp_ready de-asserted but spl does not respond to back-pressure. Module %m @ time %0d", $time);
         if ( ~spl_wr_resp_ready && start)
            $display( "Error(Handshaking): spl_wr_resp_ready de-asserted but spl does not respond to back-pressure. Module %m @ time %0d", $time);
      end


    afifo_wrapper2
      #(
       .DATA_WIDTH(606),
       .FIFO_DEPTH_LOG2(FIFO_REQ_DEPTH_LOG2),
       .MLAB_ONLY (0)
       )
    wr_req
    (
     .rd_rst(~rst_vector_wr_req[w]), .rd_clk( clk), .wr_clk( a_clk),
     .rd_ready( d_spl_wr_req_ready[w]),
     .rd_valid( d_spl_wr_req_valid[w]),
     .rd_data( d_spl_wr_req_data[w]),
     .wr_ready( a_spl_wr_req_ready[w]),
     .wr_valid( a_spl_wr_req_valid[w]),
     .wr_data( a_spl_wr_req_data[w])
    );
  end
  endgenerate

  // Synthesizable AFU
  `HLD_AFU_MODULE_NAME acc_synth_inst(
    .spl_rd_resp_valid(a_spl_rd_resp_valid[0]), .spl_rd_resp_data(a_spl_rd_resp_data[0]), .spl_rd_resp_ready(a_spl_rd_resp_ready[0]),
    .spl_rd_req_valid(a_spl_rd_req_valid[0]), .spl_rd_req_data(a_spl_rd_req_data[0]), .spl_rd_req_ready(a_spl_rd_req_ready[0]), 
    .spl_wr_resp_valid(a_spl_wr_resp_valid[0]), .spl_wr_resp_data(a_spl_wr_resp_data[0]), .spl_wr_resp_ready(a_spl_wr_resp_ready[0]),
    .spl_wr_req_valid(a_spl_wr_req_valid[0]), .spl_wr_req_data(a_spl_wr_req_data[0]),.spl_wr_req_ready(a_spl_wr_req_ready[0]),

    .clk(a_clk), .rst(a_acc_rst), .config_(a_config_[`HLD_APP_CONFIG_WIDTH-1:0]), .start(a_start), .done(a_done)
  );
endmodule
     

