#!/usr/bin/perl -w
#TCP_Server.pl
#Design by Li, Yuan

use IO::Socket;

$ipaddr = $ARGV[0];
print "LocalHost Adresse: $ipaddr\n";

while(1)
{
	
	
	$socket = new IO::Socket::INET (
						LocalHost => $ipaddr,
						LocalPort => 5000,
						Proto => 'tcp',
						Listen => 5,
						Reuse => 1
					);
                                
	die "Konnte keine Verbindung herstellen\n" unless $socket;
					
	print "TCP Server bereit und wartet auf einer verbingung beim Port 5000\n";

	$message_recieved='';
	$client_socket = '';
	$client_socket = $socket->accept();
	$peer_address = $client_socket->peerhost();
	$peer_port = $client_socket->peerport();
	print "Verbunden mit ( $peer_address , $peer_port )\n";
	
	$n=0;	
	while (1)
	{	
		$client_socket->recv($message_recieved,1024);
		$client_socket->send($message_recieved);
		if (($message_recieved eq '' and $n) or ($message_recieved eq 'q'))
		{
			print "Client hat ausgeschaltet!\n";			
			close $socket;			
			last;
		}
		print "Server hat folgendes Empfangen: $message_recieved\n"; 
		$n++;
		
	}
}
                                
