find_package(OpenSSL REQUIRED)

set(ENV{HILTI_CXX_INCLUDE_DIRS} ${OPENSSL_INCLUDE_DIR})

spicy_add_analyzer(
    NAME QUIC
    PACKAGE_NAME QUIC
    SOURCES QUIC.spicy QUIC.evt
    SCRIPTS __load__.zeek main.zeek
    CXX_LINK ${OPENSSL_LIBRARIES})
