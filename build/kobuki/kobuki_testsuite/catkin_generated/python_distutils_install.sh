#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/louis/ros/src/kobuki/kobuki_testsuite"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/louis/ros/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/louis/ros/install/lib/python2.7/dist-packages:/home/louis/ros/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/louis/ros/build" \
    "/usr/bin/python2" \
    "/home/louis/ros/src/kobuki/kobuki_testsuite/setup.py" \
    build --build-base "/home/louis/ros/build/kobuki/kobuki_testsuite" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/louis/ros/install" --install-scripts="/home/louis/ros/install/bin"
