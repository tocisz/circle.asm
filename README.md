# ASCII-art circle on RC2014 in ASM

I was curious how much faster it will be in assembly than in [BASIC](reference/circle.bas) and [FORTH](reference/circle.f).

* [FORTH](reference/circle.f) is noticably faster than [BASIC](reference/circle.bas).
* [ASM](circle.asm) version is *much* faster than both [FORTH](reference/circle.f) and [BASIC](reference/circle.bas).

## Running it

* `circle.bas` was tested on [NASCOM BASIC for RC2014](https://github.com/tocisz/RC2014-nascom);
* `circle.f` was tested on [fig-FORTH ported to RC2014](https://github.com/tocisz/RC2014-FORTH);
* `ram.hex` Intel HEX (see [releases](https://github.com/tocisz/RC2014-nascom/releases)) has base address `0x9000`
and can be loaded by [SCM](https://smallcomputercentral.com/small-computer-monitor/)
or with `HLOAD` from [NASCOM BASIC](https://github.com/tocisz/RC2014-nascom).


```
                                        #                                        
                            #########################                            
                       ###################################                       
                   ###########################################                   
                #################################################                
              #####################################################              
            #########################################################            
          #############################################################          
        #################################################################        
       ###################################################################       
      #####################################################################      
     #######################################################################     
    #########################################################################    
   ###########################################################################   
  #############################################################################  
  #############################################################################  
 ############################################################################### 
 ############################################################################### 
 ############################################################################### 
 ############################################################################### 
#################################################################################
 ############################################################################### 
 ############################################################################### 
 ############################################################################### 
 ############################################################################### 
  #############################################################################  
  #############################################################################  
   ###########################################################################   
    #########################################################################    
     #######################################################################     
      #####################################################################      
       ###################################################################       
        #################################################################        
          #############################################################          
            #########################################################            
              #####################################################              
                #################################################                
                   ###########################################                   
                       ###################################                       
                            #########################                            
                                        #                                        
```