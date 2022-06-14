// (C) 1992-2018 Intel Corporation.                            
// Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
// and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
// and/or other countries. Other marks and brands may be claimed as the property  
// of others. See Trademarks on intel.com for full list of Intel trademarks or    
// the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
// Your use of Intel Corporation's design tools, logic functions and other        
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Intel MegaCore Function License Agreement, or other applicable      
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Intel and sold by    
// Intel or its authorized distributors.  Please refer to the applicable          
// agreement for further details.                                                 


//BFM hierachy
`define SLV_BFM bfm

// test bench parameters
`define WAIT_TIME 0  //change to reflect the number of cycles for waitrequest to assert
`define READ_LATENCY 0  //the read latency of the slave BFM
`define INDEX_ZERO 0  //always refer to index zero for non-bursting transactions

module hls_sim_mm_slave_dpi_bfm(
                                  // clock, reset
                                  clock,
                                  reset_n,

                                  // DPI control
                                  do_bind,
                                  enable,

                                  // Avalon MM-slave
                                  avs_clken,

                                  avs_waitrequest,
                                  avs_write,
                                  avs_read,
                                  avs_address,
                                  avs_byteenable,
                                  avs_burstcount,
                                  avs_beginbursttransfer,
                                  avs_begintransfer,
                                  avs_writedata,
                                  avs_readdata,
                                  avs_readdatavalid,

                                  avs_arbiterlock,
                                  avs_lock,
                                  avs_debugaccess

                                  // avs_transactionid,
                                  // avs_readresponse,
                                  // avs_readid,
                                  // avs_writeresponserequest,
                                  // avs_writeresponsevalid,
                                  // avs_writeresponse,
                                  // avs_writeid,
                                  // avs_response
                                  );

   //importing verbosity and avalon_mm packages
   import verbosity_pkg::*;
   import avalon_mm_pkg::*;

   parameter COMPONENT_NAME           = "dut";
   parameter INTERFACE_ID             = 0;

   parameter AV_ADDRESS_W             = 16; // Address width
   parameter AV_SYMBOL_W              = 8;  // Symbol width (default is byte)
   parameter AV_NUMSYMBOLS            = 4;  // Number of symbols per word
   parameter AV_BURSTCOUNT_W          = 3;  // Burst port width
   parameter AV_READRESPONSE_W        = 8;  // Read response port width
   parameter AV_WRITERESPONSE_W       = 8;  // Write response port width

   parameter USE_READ                 = 1;  // Use read interface pin
   parameter USE_WRITE                = 1;  // Use write interface pin
   parameter USE_ADDRESS              = 1;  // Use address interface pinsp
   parameter USE_BYTE_ENABLE          = 1;  // Use byte_enable interface pins
   parameter USE_BURSTCOUNT           = 1;  // Use burstcount interface pin
   parameter USE_READ_DATA            = 1;  // Use readdata interface pin
   parameter USE_READ_DATA_VALID      = 1;  // Use readdatavalid interface pin
   parameter USE_WRITE_DATA           = 1;  // Use writedata interface pin
   parameter USE_BEGIN_TRANSFER       = 1;  // Use begintransfer interface pin
   parameter USE_BEGIN_BURST_TRANSFER = 1;  // Use beginbursttransfer interface pin
   parameter USE_WAIT_REQUEST         = 1;  // Use waitrequest interface pin

   parameter USE_ARBITERLOCK          = 0;  // Use arbiterlock interface pin
   parameter USE_LOCK                 = 0;  // Use lock interface pin
   parameter USE_DEBUGACCESS          = 0;  // Use debugaccess interface pin

   // parameter USE_TRANSACTIONID        = 0;  // Use transactionid interface pin
   // parameter USE_WRITERESPONSE        = 0;  // Use write response interface pins
   // parameter USE_READRESPONSE         = 0;  // Use read response interface pins

   parameter USE_CLKEN                = 0;  // Use NTCM interface pins

   parameter AV_FIX_READ_LATENCY      = 0;  // Fixed read latency (cycles)
   parameter AV_MAX_PENDING_READS     = 1;  // Max pending pipelined reads
   parameter AV_MAX_PENDING_WRITES    = 0;  // Max pending pipelined writes

   parameter AV_BURST_LINEWRAP        = 0;  // Line wrap bursts (y/n)
   parameter AV_BURST_BNDR_ONLY       = 0;  // Assert Addr alignment

   parameter AV_READ_WAIT_TIME        = 0;  // Fixed wait time cycles when
   parameter AV_WRITE_WAIT_TIME       = 0;  // USE_WAIT_REQUEST is 0
   parameter REGISTER_WAITREQUEST     = 0;  ///TODO-implementation pending
   parameter AV_REGISTERINCOMINGSIGNALS = 0;// Indicate that waitrequest is come from register

   localparam AV_DATA_W = (AV_SYMBOL_W * AV_NUMSYMBOLS);

   import "DPI-C" context function int __ihc_hls_mm_slave_read  (string component_name, int id, input bit [AV_ADDRESS_W-1:0] address, output bit [AV_DATA_W-1:0] data);
   import "DPI-C" context function void __ihc_hls_mm_slave_write(string component_name, int id, input bit [AV_ADDRESS_W-1:0] address,  input bit [AV_DATA_W-1:0] data, input bit [AV_NUMSYMBOLS-1:0] byte_enable);
   import "DPI-C" context function void __ihc_hls_dbgs(string msg);

   //chandle slave_objptr;

   function int lindex;
      // returns the left index for a vector having a declared width
      // when width is 0, then the left index is set to 0 rather than -1
      input [31:0] width;
      lindex = (width > 0) ? (width-1) : 0;
   endfunction

   input                                            clock;
   input                                            reset_n;
   input                                            do_bind;
   input                                            enable;

   output                                           avs_waitrequest;
   output                                           avs_readdatavalid;
   output [lindex(AV_SYMBOL_W * AV_NUMSYMBOLS):0]   avs_readdata;
   input                                            avs_write;
   input                                            avs_read;
   input  [lindex(AV_ADDRESS_W):0]                  avs_address;
   input  [lindex(AV_NUMSYMBOLS):0]                 avs_byteenable;
   input  [lindex(AV_BURSTCOUNT_W):0]               avs_burstcount;
   input                                            avs_beginbursttransfer;
   input                                            avs_begintransfer;
   input  [lindex(AV_SYMBOL_W * AV_NUMSYMBOLS):0]   avs_writedata;
   input                                            avs_arbiterlock;
   input                                            avs_lock;
   input                                            avs_debugaccess;

   // input  [lindex(AV_TRANSACTIONID_W): 0          ] avs_transactionid;
   // output [lindex(AV_READRESPONSE_W): 0           ] avs_readresponse;
   // output [lindex(AV_TRANSACTIONID_W): 0          ] avs_readid;
   // input                                            avs_writeresponserequest;
   // output                                           avs_writeresponsevalid;
   // output [lindex(AV_WRITERESPONSE_W): 0          ] avs_writeresponse;
   // output [lindex(AV_TRANSACTIONID_W): 0          ] avs_writeid;
   // output [1:0]                                     avs_response;

   input                                            avs_clken;

   altera_avalon_mm_slave_bfm
     #(
       .AV_ADDRESS_W               (AV_ADDRESS_W               ),
       .AV_SYMBOL_W                (AV_SYMBOL_W                ),
       .AV_NUMSYMBOLS              (AV_NUMSYMBOLS              ),
       .AV_BURSTCOUNT_W            (AV_BURSTCOUNT_W            ),
       .AV_READRESPONSE_W          (AV_READRESPONSE_W          ),
       .AV_WRITERESPONSE_W         (AV_WRITERESPONSE_W         ),

       .USE_READ                   (USE_READ                   ),
       .USE_WRITE                  (USE_WRITE                  ),
       .USE_ADDRESS                (USE_ADDRESS                ),
       .USE_BYTE_ENABLE            (USE_BYTE_ENABLE            ),
       .USE_BURSTCOUNT             (USE_BURSTCOUNT             ),
       .USE_READ_DATA              (USE_READ_DATA              ),
       .USE_READ_DATA_VALID        (USE_READ_DATA_VALID        ),
       .USE_WRITE_DATA             (USE_WRITE_DATA             ),
       .USE_BEGIN_TRANSFER         (USE_BEGIN_TRANSFER         ),
       .USE_BEGIN_BURST_TRANSFER   (USE_BEGIN_BURST_TRANSFER   ),
       .USE_WAIT_REQUEST           (USE_WAIT_REQUEST           ),

       .USE_TRANSACTIONID          (0                          ),
       .USE_WRITERESPONSE          (0                          ),
       .USE_READRESPONSE           (0                          ),
       .USE_CLKEN                  (USE_CLKEN                  ),

       .AV_FIX_READ_LATENCY        (AV_FIX_READ_LATENCY        ),
       .AV_MAX_PENDING_READS       (AV_MAX_PENDING_READS       ),
       .AV_MAX_PENDING_WRITES      (AV_MAX_PENDING_WRITES      ),

       .AV_BURST_LINEWRAP          (AV_BURST_LINEWRAP          ),
       .AV_BURST_BNDR_ONLY         (AV_BURST_BNDR_ONLY         ),

       .AV_READ_WAIT_TIME          (AV_READ_WAIT_TIME          ),
       .AV_WRITE_WAIT_TIME         (AV_WRITE_WAIT_TIME         ),

       .USE_ARBITERLOCK            (USE_ARBITERLOCK            ),
       .USE_LOCK                   (USE_LOCK                   ),
       .USE_DEBUGACCESS            (USE_DEBUGACCESS            ),
       .AV_REGISTERINCOMINGSIGNALS (AV_REGISTERINCOMINGSIGNALS ),
       .REGISTER_WAITREQUEST       (REGISTER_WAITREQUEST       )
      )
     bfm (
          .clk                      (clock                  ),
          .reset                    (~reset_n               ), // mm slave bfm uses assert high reset

          .avs_clken                (avs_clken              ),

          .avs_waitrequest          (avs_waitrequest        ),
          .avs_write                (avs_write              ),
          .avs_read                 (avs_read               ),
          .avs_address              (avs_address            ),
          .avs_byteenable           (avs_byteenable         ),
          .avs_writedata            (avs_writedata          ),
          .avs_burstcount           (avs_burstcount         ),
          .avs_beginbursttransfer   (avs_beginbursttransfer  ),
          .avs_begintransfer        (avs_begintransfer       ),
          .avs_readdata             (avs_readdata            ),
          .avs_readdatavalid        (avs_readdatavalid       ),
          .avs_arbiterlock          (avs_arbiterlock         ),
          .avs_lock                 (avs_lock                ),
          .avs_debugaccess          (avs_debugaccess         )

          // .avs_transactionid        (avs_transactionid       ),
          // .avs_readresponse         (avs_readresponse        ),
          // .avs_readid               (avs_readid              ),
          // .avs_writeresponserequest (avs_writeresponserequest),
          // .avs_writeresponsevalid   (avs_writeresponsevalid  ),
          // .avs_writeresponse        (avs_writeresponse       ),
          // .avs_writeid              (avs_writeid             ),
          // .avs_response             (avs_response            )
          );

    //local variables
    Request_t request;
    reg [AV_BURSTCOUNT_W-1:0] burst_size;
    reg [AV_ADDRESS_W-1:0] address; 
    reg [AV_DATA_W-1:0] data [(2**AV_BURSTCOUNT_W)-1:0];   
    reg [AV_NUMSYMBOLS-1:0] byte_enable [(2**AV_BURSTCOUNT_W)-1:0];   
    //reg [AV_DATA_W-1:0] internal_mem [AV_ADDRESS_W-1:0];
    string message;
    int previous_latency = 0;
    int previous_burst_size = 0;
    time previous_read_time = 0;
    longint clock_cycle_cnt;

    // track clock cycle for latency calculations
    always @(posedge clock or negedge reset_n) begin  
      if (!reset_n) begin
        clock_cycle_cnt <= 0;
      end else begin
        clock_cycle_cnt <= clock_cycle_cnt + 1;
      end
    end

    //initialize the Slave BFM
    initial
    begin
      `SLV_BFM.init();   
    end  
      
    //wait for requests from the master
    always @(`SLV_BFM.signal_command_received) 
    begin    
          int latency;
          int current_time;


          //get the master request
          slave_pop_and_get_command(request, address, burst_size, data, byte_enable);	
          if (request==REQ_WRITE)
          begin
            $sformat(message, "[%7t][msim] %m: Master %s request to address %h with burst size %d, data[0] %h and byte enable[0] %h", $time, convert_to_str(request), address, burst_size, data[0], byte_enable[0]);
            __ihc_hls_dbgs(message);	
          end
          else if (request==REQ_READ)
          begin
            $sformat(message, "[%7t][msim] %m: Master %s request from address %h with burst size %d", $time, convert_to_str(request), address, burst_size);
            __ihc_hls_dbgs(message);	
          end	
          
          //slave BFM responses to the master's request
          if (request==REQ_WRITE)
          begin
            //internal_mem[address] = data;
            for (int i = 0; i < burst_size; i++) begin
              __ihc_hls_mm_slave_write(COMPONENT_NAME, INTERFACE_ID, address + (i << $clog2(AV_NUMSYMBOLS)), data[i], byte_enable[i]);
            end
          end
          else if (request==REQ_READ)
          begin
            //data = internal_mem[address];
            for (int i = 0; i < burst_size; i++) begin
              latency = __ihc_hls_mm_slave_read(COMPONENT_NAME, INTERFACE_ID, address + (i << $clog2(AV_NUMSYMBOLS)), data[i]);
            end
            if (latency <= 1) begin
              latency = 0;
            end

            // calculate the number of cycles left in the previous read response and use that if it is larger than the latency
            current_time = clock_cycle_cnt;//$time / CLOCK_PERIOD_PS;
            if ((previous_read_time + previous_latency + previous_burst_size) > (current_time + latency)) begin
                latency = previous_read_time + previous_latency + previous_burst_size - current_time;
            end
            $sformat(message, "");
            __ihc_hls_dbgs(message);	

            slave_set_and_push_response(burst_size, data, latency);


            // record the latencies for future read latency calculations
            previous_latency = (latency == 0) ? 1 : latency; //minimum latency is 1 cycle from push response
            previous_burst_size = burst_size;
            previous_read_time = current_time;

          end
    end
    
    //----------------------------------------------------------------------------------
    // tasks
    //----------------------------------------------------------------------------------
    
    //this task pops the master request from queue and extract the request information  
    task slave_pop_and_get_command;
    output Request_t request;
    output [AV_ADDRESS_W-1:0] address;
    output [AV_BURSTCOUNT_W-1:0] burst_size;
    output [AV_DATA_W-1:0] data [(2**AV_BURSTCOUNT_W)-1:0];
    output [AV_NUMSYMBOLS-1:0] byte_enable [(2**AV_BURSTCOUNT_W)-1:0];
      
    begin
      `SLV_BFM.pop_command();  
      request = `SLV_BFM.get_command_request();
      address = `SLV_BFM.get_command_address();    
      burst_size = `SLV_BFM.get_command_burst_count();
      for (int i = 0; i < burst_size; i++) begin
          data[i]        = `SLV_BFM.get_command_data(i);   
          byte_enable[i] = `SLV_BFM.get_command_byte_enable(i);   
      end
    end
    endtask
    
    //this task sets a response as a result of master request and push it back to the master
    task slave_set_and_push_response;  
    input [AV_BURSTCOUNT_W-1:0] burst_size;
    input [AV_DATA_W-1:0] data [(2**AV_BURSTCOUNT_W)-1:0];  
    input int latency; 
      
    begin 
      `SLV_BFM.set_response_burst_size(burst_size);
      `SLV_BFM.set_response_latency(latency, 0);
      for (int i = 0; i < burst_size; i++) begin
        `SLV_BFM.set_response_data(data[i], i);  
      end
      `SLV_BFM.push_response();
    end
    endtask
    
    //this function converts the enumerated variable to string variable
    function automatic string convert_to_str(Request_t request);
    case(request)
      REQ_READ: return "Read";
          REQ_WRITE: return "Write";
          REQ_IDLE: return "Idle";
    endcase 
    endfunction


endmodule

// vim:set filetype=verilog:
