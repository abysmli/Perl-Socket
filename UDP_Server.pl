#!/usr/bin/perl -w
#UDP_Server.pl
#Design by Li, Yuan

use IO::Socket::INET;

$port = $ARGV[0];
$socket=new IO::Socket::INET(
				LocalPort=>$port,
				Proto=>'udp'
				);
die "Konnte keine Verbindung herstellen\n" unless $socket;

print "UDP Server bereit und wartet auf einer verbingung beim Port 5000\n";

while(1)
{
	$socket->recv($message,3000);
	$peer_address = $socket->peerhost();
	$peer_port = $socket->peerport();
	$length=length($message);
	print "\n($peer_address , $peer_port) hat folgendes gesendet: $message";
	print "\nlength of Packet: $length";
	$socket->send($message);
}
