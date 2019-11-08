FROM heroku/heroku:16

ARG version=0.81.0

RUN apt-get -y update && apt-get -y install build-essential cmake checkinstall libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff-dev
RUN git clone https://github.com/freedesktop/poppler.git && cd poppler && git checkout poppler-${version}
RUN cd poppler && mkdir build && cd build && cmake .. -DBUILD_GTK_TESTS=OFF -DBUILD_QT5_TESTS=OFF -DBUILD_CPP_TESTS=OFF -DENABLE_QT5=OFF -DENABLE_LIBOPENJPEG=none && make -j2
RUN cd poppler/build && checkinstall -y --install=no --backup=no --fstrans=yes --pkgname=poppler --pkgversion=${version}