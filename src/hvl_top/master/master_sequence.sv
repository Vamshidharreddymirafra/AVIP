`ifndef SEQ_INCLUDED_
`define SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: seq
// master sequence
//--------------------------------------------------------------------------------------------
class master_seq extends uvm_sequence #(master_tx);
 
  //factory registration
   `uvm_object_utils(master_seq)

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "master_seq");
endclass : master_seq


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function master_seq::new(string name = "master_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class m_spi_fd_8b_seq extends master_seq;

//register with factory so can use create uvm_method 
//and override in future if necessary 

 `uvm_object_utils(m_spi_fd_8b_seq)
  
  configuration cfg;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new (string name="m_spi_fd_8b_seq");

extern virtual task body();

endclass:m_spi_fd_8b_seq



//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function m_spi_fd_8b_seq::new(string name="m_spi_fd_8b_seq");
	super.new(name);
  cfg = new();
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//creating request which is will be coming from driver
//-----------------------------------------------------------------------------
task m_spi_fd_8b_seq::body(); 
    req=master_tx::type_id::create("req");
    repeat(2) begin
		start_item(req);
    if(!req.randomize () with { master_out_slave_in.size()==2;
                                cfg.cpol == 0;
                                cfg.cphase == 0;
                              });
    `uvm_fatal(get_type_name,"Randomization failed")
    finish_item(req);
end
endtask:body

`endif

