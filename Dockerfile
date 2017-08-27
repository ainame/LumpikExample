FROM norionomura/swift:swift-4.0-branch

RUN swift --version
RUN git clone https://github.com/ainame/LumpikExample.git
RUN cd LumpikExample && swift build

CMD ["./.build/debug/LumpikExample"]

