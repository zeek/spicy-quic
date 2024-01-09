# @TEST-DOC: Test that runs the pcap
# @TEST-EXEC: zeek -Cr $TRACES/vector-max-size-crash.pcap $PACKAGE %INPUT > out
# @TEST-EXEC: zeek-cut -m ts uid history service < conn.log > conn.log.cut
# @TEST-EXEC: zeek-cut -m ts uid cause analyzer_kind analyzer_name failure_reason < analyzer.log > analyzer.log.cut
# @TEST-EXEC: btest-diff conn.log.cut
# @TEST-EXEC: btest-diff out
# @TEST-EXEC: btest-diff quic.log

# @TEST-EXEC: TEST_DIFF_CANONIFIER='sed -r "s/\((.+)\.spicy:[0-9]+:[0-9]+\)/(\1.spicy:<line>:<column>)/g" | $SCRIPTS/diff-remove-abspath' btest-diff analyzer.log.cut

event QUIC::unhandled_version(c: connection, is_orig: bool, version: count, dcid: string, scid: string)
	{
	print "QUIC::unhandled_version", c$uid, is_orig, version, dcid, scid;
	}
