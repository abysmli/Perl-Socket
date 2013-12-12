#!/usr/bin/perl -w
#UDP_Client.pl
#Design by Li, Yuan

use IO::Socket::INET;

$ipaddr=$ARGV[0];
$ipport=$ARGV[1];

$socket=new IO::Socket::INET(
				PeerAddr=>$ipaddr,
				PeerPort=>$ipport,
				Proto=>'udp'
				);
die "Konnte keine Verbindung herstellen\n" unless $socket;

print "Mit $ipaddr verbunden ist!\n";

$peer_address = $socket->peerhost();
$peer_port = $socket->peerport();

print "Bitte Text zum Senden eingeben(q fuer Quit):\n";
$message_send = <STDIN>;
$flag=$message_send;
chop($flag);
if($flag eq 'q')
{
	close($socket);
	exit();
}
$laenge=length($message_send);	
for($i=1;$i<=(int(length($message_send)/1024)+1);$i++)
{
	$socket->send(substr($message_send,($i-1)*1024,1024));
	$socket->recv($message_recevied,1024);
	print "($peer_address , $peer_port) hat folgendes von Dir erhalten: \n$message_recevied\n";
}