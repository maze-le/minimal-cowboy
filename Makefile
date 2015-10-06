APPNAME=mincb
PORT=8080

FRONTEND_SOURCE=client
PRIV=priv

# erlang build-system
REBAR=./rebar

.PHONY: deps clean build html css js resources

all: build start


# resolve dependencies
deps: 
	$(REBAR) get-deps
	$(REBAR) compile



# build-section
build: compile frontend

compile:
	@echo "compiling application backend..."
	@$(REBAR) skip_deps=true compile

frontend:
	@mkdir -p $(PRIV)/css
	@cp $(FRONTEND_SOURCE)/*.html $(PRIV)
	@cp $(FRONTEND_SOURCE)/css/* $(PRIV)/css


# start server
start:
	@echo "starting server."
	erl -pa deps/*/ebin ebin -s $(APPNAME) start


