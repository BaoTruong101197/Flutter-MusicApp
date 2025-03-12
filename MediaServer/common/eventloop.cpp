#include "eventloop.h"

namespace mdaserver::common {

static EventLoop* gInstance = nullptr;

EventLoop::EventLoop(MediaServer& mdaServer) : 
    mEventLoopThread([this]() { start(); }),
    mMDAServer(mdaServer)
{
    std::signal(SIGINT, terminate);
}

void EventLoop::initialize(MediaServer& mdaServer)
{
    if (gInstance == nullptr)
    {
        gInstance = new EventLoop(mdaServer);
    }
}

EventLoop& EventLoop::instance()
{
    if (gInstance == nullptr)
    {
        throw std::runtime_error("EventLoop has not been initialized yet");
    }
    return *gInstance;
}

void EventLoop::start()
{
    mRunning = true;
    mMDAServer.start();
    while (mRunning) {
        std::unique_lock<std::mutex> lock(mMutex);
        
        mEventCV.wait(lock, [this] { return !mRunning; });
        std::exit(0);
    }
}

void EventLoop::stop()
{
    std::lock_guard<std::mutex> lock(mMutex);
    mMDAServer.stop();
    mRunning = false;
    mEventCV.notify_all();
}

int EventLoop::join()
{
    if (mEventLoopThread.joinable())
    {
        mEventLoopThread.join();
        return 1;
    }
    return 0;
}

int EventLoop::exec()
{
    return gInstance->join();
}

void EventLoop::terminate(int signal)
{
    static bool terminate = false;
    if (signal == SIGINT && !terminate) {
        terminate = true;
        gInstance->stop();
    }
}

}