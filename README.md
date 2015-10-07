
Minimal-Cowboy
==============

This is a minimal example for integration of the cowboy-webserver into an
erlang/otp application stack.

The build-system is based on GNU/make and rebar.


Resolve the cowboy dependency with:

    make deps

Build and start the application with:

    make build
    make start

Access your webserver on _localhost:8080_. The default-port is 8080, it is defined in the [mincb_app](src/mincb_app.erl)-module.
