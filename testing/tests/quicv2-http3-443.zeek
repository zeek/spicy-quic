# @TEST-DOC: Pcap with quicv2 http3 traffic produced with https://raw.githubusercontent.com/quic-go/quic-go/master/example/main.go
#
# @TEST-EXEC: zeek -Cr $TRACES/quicv2-http3-443.pcap $PACKAGE
# @TEST-EXEC: zeek-cut -m ts uid history service < conn.log > conn.log.cut
# @TEST-EXEC: btest-diff conn.log.cut
# @TEST-EXEC: btest-diff ssl.log
# @TEST-EXEC: btest-diff quic.log
