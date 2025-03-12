#ifndef EVENTLOOP_H
#define EVENTLOOP_H

#include <csignal>
#include <cstdlib>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <functional>
#include <chrono>
#include <mediaserver.h>

namespace mdaserver::common {

class EventLoop {
public:
    static void initialize(MediaServer& mdaServer);
    static EventLoop& instance();

    void start();
    void stop();
    int join();
    static int exec();
    static void terminate(int signal);

private:
    explicit EventLoop(MediaServer& mdaServer);

    std::mutex mMutex;
    std::condition_variable mEventCV;
    std::thread mEventLoopThread;
    bool mRunning = false;
    MediaServer& mMDAServer;
};

}


#endif