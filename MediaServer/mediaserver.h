#ifndef MEDIASERVER_H
#define MEDIASERVER_H

#include <thread>
#include <functional>

namespace mdaserver {

class MediaServer {
public:
    explicit MediaServer();
    ~MediaServer();

    void start();
    void stop();
};

}

#endif