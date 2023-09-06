# @TEST-DOC: Test that runs the pcap
# @TEST-EXEC: zeek -Cr $TRACES/vector-max-size-crash.pcap $PACKAGE
# @TEST-EXEC: zeek-cut -m ts uid history service < conn.log > conn.log.cut
# @TEST-EXEC: zeek-cut -m ts uid cause analyzer_kind analyzer_name failure_reason < analyzer.log > analyzer.log.cut
# @TEST-EXEC: btest-diff conn.log.cut
# @TEST-EXEC: TEST_DIFF_CANONIFIER=$SCRIPTS/diff-remove-abspath btest-diff analyzer.log.cut
