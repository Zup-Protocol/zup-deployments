CONTRACT := $(word 2, $(MAKECMDGOALS))
ARGS := $(wordlist 3, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: update deploy test FeeController ZupRouter

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

deploy-local:
	forge script ${CONTRACT}Deploy --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast --rpc-url anvil ${ARGS}
	
