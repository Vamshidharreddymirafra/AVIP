`ifndef MASTER_AGENT_INCLUDED_
`define MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent
// <Description_here>
// agent is container called universal verification component
// that contain driver,monitor,sequencer
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  //factory registration
  `uvm_component_utils(master_agent)
  //handles for sequencer,driver,monitor
    master_sequencer m_sqr_h;
    master_driver_proxy m_drv_h;
    master_monitor_proxy m_mon_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
endclass
//--------------------------------------------------------------------------------------------
//Constructor:new
//Initializes the master_agent class component
//Paramters:
//name-instance name of config template
//--------------------------------------------------------------------------------------------

function  master_agent::new(string name="master_agent",uvm_component parent = null);
  super.new(name,parent);
endfunction : new
//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//Creates the required ports
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void master_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
    m_sqr_h=master_sequencer::type_id::create("master_sequencer",this);
    m_drv_h=master_driver_proxy::type_id::create("master_driver_proxy",this);
    m_mon_h=master_monitor_proxy::type_id::create("master_monitor_proxy",this);
endfunction : build_phase

`endif

