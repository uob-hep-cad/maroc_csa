action = "simulation"

# fetchto = "../../ip_cores"


modules = { "local" : 
            [ "../../hdl"
# , "../../top/pc049a/demo",
# , "../../whiteRabbit/wr-cores/platform"
              ]
            }

#modules = { "local" : 
#            [ "../../top/pc049a/demo", 
#              "../../whiteRabbit/wr-cores/platform",
#              "../../whiteRabbit/wr-cores/ip_cores/general-cores",
#              "../../whiteRabbit/wr-cores/ip_cores/etherbone-core",
#              "../../whiteRabbit/wr-cores/ip_cores/gn4124-core"] 
#            }


files = [ "../hdl/pc049a_demo_tb.vhd" , "../../top/pc049a/demo/pc049a_top.vhd", "../../IPBus/firmware/ethernet/sim/eth_mac_sim.vhd" ]
