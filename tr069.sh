#!/bin/sh
case "$1" in                                                                    
  start)                                                                        
    echo "Starting CWMP Client." 
    killall -9 cwmp
    sleep 1
    cwmp -F /etc/config/cwmp.conf &                    
    sleep 1                 
    ;;                                                                 
  stop)                                                                         
    echo "Stopping CWMP Client."                                               
    killall -9 cwmp                                                           
    ;;                                                                          
  restart)                                                                      
    echo "Restarting CWMP Client." 
    killall -9 cwmp                                                          
    sleep 1                                                            
    cwmp -F /etc/config/cwmp.conf &                                                    
    sleep 1                                                            
    ;;                                                                 
  *)                                                                 
    echo "Usage: /etc/init.d/tr069 {start|stop|restart}"                      
    exit 1                                                                      
esac

exit 0
