CONTRACT := $(word 2, $(MAKECMDGOALS))
ARGS := $(wordlist 3, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: update deploy test

test:
	@forge test -vvv

update: 
	@forge clean && forge update

deploy: 
	@echo "⚡️⚡️⚡️ Updating contracts..." && \
	make update && \
	echo "⚡️⚡️⚡️ Running tests..." && \
	make test && \
	echo "⚡️⚡️⚡️ Deploying ${CONTRACT}..." && \
	forge script ${CONTRACT}Deploy --trezor --broadcast --rpc-url ${ARGS} --verify
