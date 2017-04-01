#!/bin/sh
case "$1" in                                                                    
  start)                                                                        
    echo "Starting CWMP Client." 
    killall -9 cwmpd
    sleep 1
    cwmpd -F /etc/config/cwmpd.conf &                    
    sleep 1                 
    ;;                                                                 
  stop)                                                                         
    echo "Stopping CWMP Client."                                               
    killall -9 cwmpd                                                           
    ;;                                                                          
  restart)                                                                      
    echo "Restarting CWMP Client." 
    killall -9 cwmpd                                                          
    sleep 1                                                            
    cwmpd -F /etc/config/cwmpd.conf &                                                    
    sleep 1                                                            
    ;;                                                                 
  *)                                                                 
    echo "Usage: /etc/init.d/tr069 {start|stop|restart}"                      
    exit 1                                                                      
esac

exit 0
