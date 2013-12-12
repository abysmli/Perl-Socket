#!/usr/bin/perl -w
#TCP_Client.pl
#Design by Li, Yuan

use IO::Socket;

$ipaddr = $ARGV[0];
print "Server Adresse: $ipaddr\n";
	 
$socket = new IO::Socket::INET (
                                  PeerAddr  => $ipaddr,
                                  PeerPort  => 5000,
                                  Proto => 'tcp',
                               )                
or die "Keine Verbindung zum Server moeglich\n";

print "Mit $ipaddr verbunden ist!\n";

while (1)
{
	print "Bitte Text zum Senden eingeben(q fuer Quit):\n";
	$message_send = <STDIN>;
	if(defined($message_send))
	{
		$flag=$message_send;
		chop($flag);
		$laenge=length($message_send);
		if ($flag eq 'q')
		{
			$socket->send('q');
			close $socket;
			exit;
		}    
		
		for($i=1;$i<=(int(length($message_send)/1024)+1);$i++)
		{
			$socket->send(substr($message_send,($i-1)*1024,1024));
			$socket->recv($message_recevied,1024);
			print "($ipaddr , 5000) hat folgendes von Dir erhalten: \n$message_recevied\n";
			if ($i==int($laenge/1024))
	                {
	                    last;
	                }
		}
	} else {
		exit;
	}
}    
