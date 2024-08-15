# openssl
add_library(openssl INTERFACE)
target_include_directories(openssl INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(openssl INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/openssl/libssl.so
    ${CBD_THIRDPARTY_LIBRARY}/lib/openssl/libcrypto.so
    -ldl)

# cbd_component_mode
add_library(cbd_component_mode INTERFACE)
target_include_directories(cbd_component_mode INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(cbd_component_mode 
                    INTERFACE 
                    ${CBD_THIRDPARTY_LIBRARY}/lib/liboa/libmode.so
                    libevent 
                    openssl 
                    glog
)

# # cbd_component_broker
# add_library(cbd_component_broker INTERFACE)
# target_include_directories(cbd_component_broker INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(cbd_component_broker INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/liboa/libbroker.so
#     libmosquitto libzmq openssl glog)

# # cbd_module_rpc
# add_library(cbd_module_rpc INTERFACE)
# target_include_directories(cbd_module_rpc INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(cbd_module_rpc INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/liboa/librpc.so
#     protobuf glog)

# libevent
add_library(libevent INTERFACE)
target_include_directories(libevent INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include/libevent)
target_link_libraries(libevent INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/libevent/libevent.so
    ${CBD_THIRDPARTY_LIBRARY}/lib/libevent/libevent_pthreads.so 
    ${CBD_THIRDPARTY_LIBRARY}/lib/libevent/libevent_openssl.so 
    openssl)

# # glog
# add_library(glog INTERFACE)
# target_include_directories(glog INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(glog INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/glog/glog.so)

# # gflags
# add_library(gflags INTERFACE)
# target_include_directories(gflags INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(gflags INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/gflags/libgflags.so)

# # libmosquitto
# add_library(libmosquitto INTERFACE)
# target_include_directories(libmosquitto INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(libmosquitto INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/libmosquitto/libmosquitto.so.1)

# eigen3
set(EIGEN_INCLUDE_DIR ${CBD_THIRDPARTY_LIBRARY}/include/eigen3)
add_library(eigen INTERFACE)
target_include_directories(eigen INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include/eigen3)

# curl
add_library(curl INTERFACE)
target_include_directories(curl INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(curl INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/curl/libcurl.so openssl -lpthread)

# # libsocketcan
# add_library(libsocketcan INTERFACE)
# target_include_directories(libsocketcan INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(libsocketcan INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/libsocketcan/libsocketcan.so)

# # Protobuf
# add_library(protobuf INTERFACE)
# target_include_directories(protobuf INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(protobuf INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/protobuf/libprotobuf-lite.so
#     ${CBD_THIRDPARTY_LIBRARY}/lib/protobuf/libprotobuf.so)
# set(PROTOBUF_PROTOC_EXECUTABLE ${CBD_THIRDPARTY_LIBRARY}/bins/protoc)

# # libzmq
# add_library(libzmq INTERFACE)
# target_include_directories(libzmq INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(libzmq INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/libzmq/libzmq.so)

# # canopen
# add_library(canopen INTERFACE)
# target_include_directories(canopen INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(canopen INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/canopen/libcanopen.a -lrt)

# jsoncpp
add_library(jsoncpp INTERFACE)
target_include_directories(jsoncpp INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(jsoncpp INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/jsoncpp/libjsoncpp.so -lpthread)