# Config
.PHONY: develop
develop: deps.get
	mix ecto.setup
	cd assets && npm install && cd ..
	mix phx.server

# Deps
.PHONY: deps.get
deps.get:
	mix deps.get

# Clean
.PHONY: clean distclean
clean:
	mix clean

distclean:
	$(RM) -R _build/
	$(RM) -R assets/node_modules
