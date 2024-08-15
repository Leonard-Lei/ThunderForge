# openssl
add_library(openssl INTERFACE)
target_include_directories(openssl INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(openssl INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/openssl/libssl.so
    ${CBD_THIRDPARTY_LIBRARY}/lib/openssl/libcrypto.so
    )

# cbd_component_mode
add_library(cbd_component_mode INTERFACE)
target_include_directories(cbd_component_mode INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(cbd_component_mode 
                    INTERFACE 
                    ${CBD_THIRDPARTY_LIBRARY}/lib/liboa/libmode.a
                    libevent 
                    openssl 
)


# # cbd_component_broker
# add_library(cbd_component_broker INTERFACE)
# target_include_directories(cbd_component_broker INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(cbd_component_broker INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/liboa/libbroker.a
#     libmosquitto openssl glog)

# # cbd_module_rpc
# add_library(cbd_module_rpc INTERFACE)
# target_include_directories(cbd_module_rpc INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(cbd_module_rpc INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/liboa/librpc.a
#     protobuf glog)

# libevent
add_library(libevent INTERFACE)
target_include_directories(libevent INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include/libevent)
target_link_libraries(libevent INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/libevent/libevent.a
    ${CBD_THIRDPARTY_LIBRARY}/lib/libevent/libevent_pthreads.a 
    ${CBD_THIRDPARTY_LIBRARY}/lib/libevent/libevent_openssl.a 
    openssl)

# # glog
# add_library(glog INTERFACE)
# target_include_directories(glog INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(glog INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/glog/libglog.a -lpthread)

# # gflags
# add_library(gflags INTERFACE)
# target_include_directories(gflags INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(gflags INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/gflags/libgflags.a)

# # libmosquitto
# add_library(libmosquitto INTERFACE)
# target_include_directories(libmosquitto INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(libmosquitto INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/libmosquitto/libmosquitto.a)
 
# eigen3
set(EIGEN_INCLUDE_DIR ${CBD_THIRDPARTY_LIBRARY}/include/eigen3)
add_library(eigen INTERFACE)
target_include_directories(eigen INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include/eigen3)

# curl
add_library(curl INTERFACE)
target_include_directories(curl INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(curl INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/curl/libcurl.a openssl -lpthread)
    
# # libsocketcan
# add_library(libsocketcan INTERFACE)
# target_include_directories(libsocketcan INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(libsocketcan INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/libsocketcan/libsocketcan.a)

# # libzmq
# add_library(libzmq INTERFACE)
# target_include_directories(libzmq INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(libzmq INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/libzmq/libzmq.a)

# # canopen
# add_library(canopen INTERFACE)
# target_include_directories(canopen INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
# target_link_libraries(canopen INTERFACE 
#     ${CBD_THIRDPARTY_LIBRARY}/lib/canopen/libcanopen.a -lrt)

# jsoncpp
add_library(jsoncpp INTERFACE)
target_include_directories(jsoncpp INTERFACE ${CBD_THIRDPARTY_LIBRARY}/include)
target_link_libraries(jsoncpp INTERFACE 
    ${CBD_THIRDPARTY_LIBRARY}/lib/jsoncpp/libjsoncpp.a -lpthread)