add_object_library(
  time_utils
  SRCS
    time_utils.cpp
  HDRS
    time_utils.h
)

add_entrypoint_object(
  clock
  SRCS
    clock.cpp
  HDRS
    ../clock.h
  DEPENDS
    libc.include.time
    libc.src.__support.GPU.utils
    .time_utils
)

add_entrypoint_object(
  nanosleep
  SRCS
    nanosleep.cpp
  HDRS
    ../nanosleep.h
  DEPENDS
    libc.include.time
    libc.src.__support.GPU.utils
    .time_utils
)
