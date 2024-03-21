cmake_minimum_required(VERSION 3.25)
project(AoCS_IHW_4_Var_4)

set(CMAKE_CXX_STANDARD 17)

add_executable(AoCS_IHW_4_Var_4 main.cpp utils.h game.h)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
target_link_libraries(AoCS_IHW_4_Var_4 Threads::Threads)