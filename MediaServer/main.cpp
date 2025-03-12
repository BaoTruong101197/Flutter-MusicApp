#include "common/eventloop.h"

int main()
{
    mdaserver::MediaServer mdaServer;
    mdaserver::common::EventLoop::initialize(mdaServer);
    
    return mdaserver::common::EventLoop::instance().exec();
}