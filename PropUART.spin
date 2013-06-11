{{
┌─────────────────────────────────────────────────┐
│ UART/Asynchronous Serial                        │
│ Interface Object                                │
│                                                 │
│ Author: Joe Grand                               │                     
│ Copyright (c) 2013 Grand Idea Studio, Inc.      │
│ Web: http://www.grandideastudio.com             │
│                                                 │
│ Distributed under a Creative Commons            │
│ Attribution 3.0 United States license           │
│ http://creativecommons.org/licenses/by/3.0/us/  │
└─────────────────────────────────────────────────┘

Program Description:

This object provides the low-level communication interface for an 
asynchronous serial port.

See http://en.wikipedia.org/wiki/Universal_asynchronous_
receiver/transmitter for interface details.

Usage: Call Config first to properly set the desired pinout 
 
}}


CON
{{ Signal Descriptions

   ┌───────────┬────────────────────────────────────────────────────────────────────────────────────────┐
   │    Name   │                                   Description                                          │
   ├───────────┼────────────────────────────────────────────────────────────────────────────────────────┤
   │    TXD    │    Transmit Data: Outgoing data from host (JTAGulator) to target                       │
   ├───────────┼────────────────────────────────────────────────────────────────────────────────────────┤ 
   │    RXD    │    Receive Data: Incoming data from target to host (JTAGulator)                        │
   └───────────┴────────────────────────────────────────────────────────────────────────────────────────┘
 }}
    
  
VAR
  long TXD, RXD       ' UART pins (must stay in this order)


OBJ
  ser           : "JDCogSerial"                         ' Full-duplex serial communication (Carl Jacobs, http://obex.parallax.com/object/298/)
  

PUB Config(txd_pin, rxd_pin, baudrate) : ptr
{
  Setup UART
  Parameters : txd_pin = TXD channel
               rxd_pin = RXD channel
               baudrate = Desired baud rate (supports standard baud rates up to 230400 and non-standard up to 345600) 
}
  longmove(@TXD, @txd_pin, 2)   ' Move passed variables into globals for use in this object

  ' Start JDCogSerial cog
  ptr := ser.Start(|<RXD, |<TXD, baudrate)
    

PUB UART_Check(outbyte) : value
{
  Send a byte on TXD and check for a response on RXD.

  Parameters : num = Byte to send
  Returns    : 8-bit value received from RXD
}


DAT